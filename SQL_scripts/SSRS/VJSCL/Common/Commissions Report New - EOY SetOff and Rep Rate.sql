CREATE TABLE
    #tmp (
        DET_HEADER_REF VARCHAR(11),
        INV DECIMAL(18, 2),
        CRN DECIMAL(18, 2),
        TRANREP VARCHAR(20),
        CUCODE VARCHAR(10),
        CUNAME VARCHAR(40),
        CUSORT VARCHAR(40),
        STKCODE VARCHAR(25),
        STK_SORT_KEY VARCHAR(25),
        Division VARCHAR(20),
        DET_TYPE VARCHAR(3),
        ST_DATE DATETIME,
        S_AL_DATE DATETIME,
        DET_NETT DECIMAL(18, 2),
        DET_VAT DECIMAL(18, 2),
        VAT_RATE DECIMAL(18, 2),
        RepCommissionRate DECIMAL(18, 4),
        TOTAL_TRANS_COUNT DECIMAL(18, 2),
        PAYMENT_WITH_VAT DECIMAL(18, 2),
        PAYMENT_WITHOUT_VAT DECIMAL(18, 2),
        EOY_SetOff DECIMAL(18, 2)
    )
INSERT INTO
    #tmp
SELECT
    SL.ST_HEADER_REF AS DET_HEADER_REF,
    CASE
        WHEN SL.ST_TRANTYPE = 'INV' AND
        AH.S_AL_VALUE_HOME < 0 THEN AH.S_AL_VALUE_HOME
        ELSE 0
    END AS INV,
    CASE
        WHEN SL.ST_TRANTYPE = 'CRN' AND
        AH.S_AL_VALUE_HOME > 0 THEN AH.S_AL_VALUE_HOME
        ELSE 0
    END AS CRN,
    SL.ST_USER1 AS TRANREP,
    A.CUCODE,
    A.CUNAME,
    A.CUSORT,
    S.STKCODE,
    S.STK_SORT_KEY,
    S3.STK_USRCHAR2 AS Division,
    SLD.DET_TYPE,
    SL.ST_DATE,
    AH.S_AL_DATE,
    SLD.DET_NETT,
    SLD.DET_VAT,
    CAST(SLD.DET_VAT / SLD.DET_NETT AS DECIMAL(18, 2)) AS VAT_RATE,
    CASE
        WHEN SL.ST_DATE >= '20260101' THEN COALESCE(CR.CommissionRate, 0) -- new rep-based rates
        ELSE
        -- old stock-based rates (incl your Septona rule)
        CASE
            WHEN S.STK_SORT_KEY = '30 SEPTONA' AND
            YEAR(SL.ST_DATE) < 2024 AND
            S3.STK_USRNUM2 = 1 THEN 2
            ELSE S3.STK_USRNUM2
        END
    END AS RepCommissionRate,
    IQ.TOTAL_TRANS_COUNT,
    CASE
        WHEN (
            SL.ST_TRANTYPE = 'INV' AND
            AH.S_AL_VALUE_HOME < 0
        ) OR
        (
            SL.ST_TRANTYPE = 'CRN' AND
            AH.S_AL_VALUE_HOME > 0
        ) THEN CAST(
            (
                (AH.S_AL_VALUE_HOME * (DET_NETT + DET_VAT)) / IQ.InvTotGross
            ) AS DECIMAL(18, 2)
        )
        ELSE 0
    END AS PAYMENT_WITH_VAT,
    /*If no payment on invoice, then no commission
    If invoice fully paid then full commission
    If partially paid, commission given prorata*/
    CASE
        WHEN (
            SL.ST_TRANTYPE = 'INV' AND
            AH.S_AL_VALUE_HOME < 0
        ) OR
        (
            SL.ST_TRANTYPE = 'CRN' AND
            AH.S_AL_VALUE_HOME > 0
        ) THEN CAST(
            (
                (AH.S_AL_VALUE_HOME * (DET_NETT + DET_VAT)) / IQ.InvTotGross
            ) / (1 + CAST(DET_VAT / DET_NETT AS DECIMAL(18, 2))) AS DECIMAL(18, 2)
        )
        ELSE 0
    END AS PAYMENT_WITHOUT_VAT,
    A2.CU_USRNUM4 AS EOY_SetOff
FROM
    dbo.SL_ACCOUNTS A
    INNER JOIN SL_ACCOUNTS2 A2 ON A2.CUCODE2 = A.CUCODE
    INNER JOIN dbo.SL_TRANSACTIONS SL ON A.CUCODE = SL.ST_COPYCUST
    INNER JOIN dbo.SL_PL_NL_DETAIL SLD ON SL.ST_HEADER_KEY = SLD.DET_HEADER_KEY
    INNER JOIN (
        SELECT
            COUNT(*) AS TOTAL_TRANS_COUNT,
            DET_HEADER_KEY,
            SUM(DET_NETT) + SUM(DET_VAT) AS InvTotGross
        FROM
            SL_PL_NL_DETAIL
        WHERE
            DET_NETT <> 0
        GROUP BY
            DET_HEADER_KEY
    ) IQ ON IQ.DET_HEADER_KEY = SL.ST_HEADER_KEY
    INNER JOIN dbo.STK_STOCK S ON S.STKCODE = SLD.DET_STOCK_CODE
    INNER JOIN dbo.STK_STOCK3 S3 ON S3.STKCODE3 = S.STKCODE
    LEFT JOIN [Spot].[dbo].[VJSCL_CommissionRate] CR ON CR.SalesRep = SL.ST_USER1
    INNER JOIN (
        SELECT
            MAX(S_AL_DATE) AS S_AL_DATE,
            S_AL_HEADER_KEY,
            SUM(S_AL_VALUE_HOME) AS S_AL_VALUE_HOME
        FROM
            SL_ALLOC_HISTORY
        WHERE
            S_AL_VALUE_HOME > 0
        GROUP BY
            MONTH(S_AL_DATE),
            YEAR(S_AL_DATE),
            S_AL_HEADER_KEY
        UNION ALL
        SELECT
            MAX(S_AL_DATE) AS S_AL_DATE,
            S_AL_HEADER_KEY,
            SUM(S_AL_VALUE_HOME) AS S_AL_VALUE_HOME
        FROM
            SL_ALLOC_HISTORY
        WHERE
            S_AL_VALUE_HOME < 0
        GROUP BY
            MONTH(S_AL_DATE),
            YEAR(S_AL_DATE),
            S_AL_HEADER_KEY
    ) AH ON SL.ST_HEADER_KEY = AH.S_AL_HEADER_KEY
WHERE
    DATEPART(m, AH.S_AL_DATE) = @MONTH AND
    DATEPART(yyyy, AH.S_AL_DATE) = @YEAR AND
    (
        (
            ST_TRANTYPE IN ('INV') AND
            AH.S_AL_VALUE_HOME < 0
        ) OR
        (
            ST_TRANTYPE IN ('CRN') AND
            AH.S_AL_VALUE_HOME > 0
        )
    ) AND
    DET_NETT <> 0
ORDER BY
    SL.ST_USER1,
    A.CUNAME,
    DET_HEADER_REF
SELECT
    *
FROM
    (
        SELECT
            DET_HEADER_REF,
            INV,
            CRN,
            TRANREP AS 'RepTakingCommission',
            RepCommissionRate AS CommissionRate,
            CUCODE,
            CUNAME,
            DET_TYPE,
            ST_DATE,
            S_AL_DATE,
            STKCODE,
            VAT_RATE,
            (
                PAYMENT_WITH_VAT - (PAYMENT_WITH_VAT * EOY_SetOff / 100)
            ) * -1 AS PAYMENT_WITH_VAT,
            (
                PAYMENT_WITHOUT_VAT - (PAYMENT_WITHOUT_VAT * EOY_SetOff / 100)
            ) * -1 AS PAYMENT_WITHOUT_VAT,
            (
                (
                    (
                        PAYMENT_WITHOUT_VAT - (PAYMENT_WITHOUT_VAT * EOY_SetOff / 100)
                    ) * RepCommissionRate
                ) / 100
            ) * -1 AS CommissionDue
        FROM
            #tmp
    ) Z
WHERE
    Z.RepTakingCommission LIKE CASE
        WHEN @SalesRep = 'All' THEN '30%'
        ELSE @SalesRep
    END