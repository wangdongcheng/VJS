DECLARE @SalesRep VARCHAR(50) = ' All';

-- Set this to the desired sales representative or 'All' for all reps
SELECT
    ST_COPYCUST,
    CUNAME,
    CU_DUE_DAYS,
    ST_TRANTYPE,
    ST_HEADER_REF,
    ST_ORDER_NUMBER,
    ST_DATE,
    ST_DUEDATE,
    ST_ANTICPAYDATE,
    CASE
        WHEN ST_TRANTYPE IN ('INV', 'ADR') THEN ST_GROSS
        ELSE ST_GROSS * -1
    END AS ST_GROSS,
    CASE
        WHEN ST_TRANTYPE IN ('INV', 'ADR') THEN ST_UNALLOCATED
        ELSE ST_UNALLOCATED * -1
    END AS ST_UNALLOCATED,
    CU_A_P_DAYS,
    ST_QUERY_FLAG,
    ST_USER1,
    CASE
        WHEN ST_DUEDATE < GETDATE() THEN DATEDIFF(DAY, ST_DUEDATE, GETDATE())
        ELSE 0
    END AS DaysLate,
    c.DefaultRep AS 'SalesTime_DefaultRep'
FROM
    SL_TRANSACTIONS
    INNER JOIN SL_ACCOUNTS ON ST_COPYCUST = CUCODE
    INNER JOIN SL_ACCOUNTS2 ON CUCODE = CUCODE2
    LEFT JOIN [Salestime_scl].[dbo].[Customers] c ON ST_COPYCUST = c.CustomerCode
WHERE
    ST_UNALLOCATED <> 0 AND
    CU_USRFLAG6 = 0 AND
    NOT (
        ST_TRANTYPE = 'INV' AND
        CASE
            WHEN ST_DUEDATE < GETDATE() THEN DATEDIFF(DAY, ST_DUEDATE, GETDATE())
            ELSE 0
        END = 0
    ) AND
    (
        c.DefaultRep LIKE CASE
            WHEN @SalesRep = ' All' THEN '30%'
            ELSE @SalesRep
        END
    ) AND
    ST_TRANTYPE IN ('INV', 'CRN');

SELECT DISTINCT
    st_user1
FROM
    (
        SELECT
            ' All' AS st_user1 -- space before All is intentional to ensure it appears at the top of the list
        UNION ALL
        SELECT
            DefaultRep
        FROM
            salestime_scl.dbo.Customers
        WHERE
            defaultrep <> '30 OFFICE' AND
            defaultrep <> ''
        UNION ALL
        SELECT
            SR.DefaultRep
        FROM
            salestime_scl.[dbo].[SalesReps] SR
            INNER JOIN salestime_scl.[dbo].[Users] U ON U.Id = SR.UserId
        WHERE
            U.IsActive = '1' AND
            SR.DefaultRep <> '30 OFFICE'
    ) t
ORDER BY
    st_user1;

-- backup 20260310_145111
-- select 'All' as st_user1
-- union all
--   SELECT DISTINCT DefaultRep
--   FROM [dbo].[SalesReps] SR
--   inner join [dbo].[Users] U ON U.Id=SR.UserId
--   WHERE U.IsActive = '1' AND SR.DefaultRep <> '30 OFFICE'
--   SELECT ST_COPYCUST,CUNAME,CU_DUE_DAYS,ST_TRANTYPE, ST_HEADER_REF, ST_DATE, ST_DUEDATE, ST_ANTICPAYDATE, 
-- CASE WHEN ST_TRANTYPE IN ('INV','ADR') THEN ST_GROSS ELSE ST_GROSS*-1 END AS ST_GROSS, 
-- CASE WHEN ST_TRANTYPE IN ('INV','ADR') THEN ST_UNALLOCATED ELSE ST_UNALLOCATED*-1 END AS ST_UNALLOCATED,  
-- CU_A_P_DAYS, ST_QUERY_FLAG, ST_USER1, 
-- CASE WHEN ST_DUEDATE < GETDATE() THEN DATEDIFF(DAY,ST_DUEDATE,GETDATE()) ELSE 0 END AS DaysLate
-- FROM   SL_TRANSACTIONS 
-- INNER JOIN SL_ACCOUNTS  ON ST_COPYCUST=CUCODE
-- INNER JOIN SL_ACCOUNTS2 ON CUCODE = CUCODE2
-- WHERE   ST_UNALLOCATED<>0 AND CU_USRFLAG6=0
-- AND NOT (ST_TRANTYPE='INV' AND CASE WHEN ST_DUEDATE < GETDATE() THEN DATEDIFF(DAY,ST_DUEDATE,GETDATE()) ELSE 0 END =0)
-- AND ST_USER1 LIKE CASE WHEN @SalesRep='All' THEN '30%' ELSE @SalesRep END 
-- AND ST_TRANTYPE IN ('INV','CRN')