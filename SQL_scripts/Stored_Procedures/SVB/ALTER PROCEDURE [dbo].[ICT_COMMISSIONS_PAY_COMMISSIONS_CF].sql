SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[ICT_COMMISSIONS_PAY_COMMISSIONS_CF]
    @DATEFROM DATETIME,
    @DATETO DATETIME

AS

/* Process to look at all receipts allocated within the date range and fully allocated invoices */
CREATE TABLE #primarykeys_invoices (
    salheaderkey_inv VARCHAR(20)
)
INSERT INTO #primarykeys_invoices
SELECT DISTINCT S_AL_HEADER_KEY
FROM SL_ALLOC_HISTORY
WHERE S_AL_REFERENCE IN (
        SELECT S_AL_REFERENCE
        FROM SL_ALLOC_HISTORY
        WHERE S_AL_VALUE_HOME > 0
            AND S_AL_REFERENCE <> 0
            AND S_AL_DATE BETWEEN dbo.dateonly(@DateFrom) AND dbo.dateonly(@DateTo)
            AND S_AL_HEADER_KEY IN (
                SELECT ST_HEADER_KEY
                FROM SL_TRANSACTIONS
                WHERE ST_UNALLOCATED < 0.02
                    AND ST_TRANTYPE = 'PAY'
            )
    )
    AND S_AL_VALUE_HOME <> 0
    AND S_AL_DATE BETWEEN dbo.dateonly(@DateFrom) AND dbo.dateonly(@DateTo)
    AND S_AL_HEADER_KEY IN (
        SELECT ST_HEADER_KEY
        FROM SL_TRANSACTIONS
        WHERE ST_UNALLOCATED < 0.02
            AND ST_TRANTYPE = 'INV'
    )

/* Process to take credit notes into account */
CREATE TABLE #primarykeys_cnotes (
    salheaderkey_crn VARCHAR(20)
)
INSERT INTO #primarykeys_cnotes
SELECT DISTINCT S_AL_HEADER_KEY
FROM SL_ALLOC_HISTORY
WHERE S_AL_REFERENCE IN (
        SELECT S_AL_REFERENCE
        FROM SL_ALLOC_HISTORY
        WHERE S_AL_VALUE_HOME > 0
            AND S_AL_REFERENCE <> 0
            AND S_AL_DATE BETWEEN dbo.dateonly(@DateFrom) AND dbo.dateonly(@DateTo)
            AND S_AL_HEADER_KEY IN (
                SELECT ST_HEADER_KEY
                FROM SL_TRANSACTIONS
                WHERE ST_UNALLOCATED < 0.02
                    AND ST_TRANTYPE = 'PAY'
            )
    )
    AND S_AL_VALUE_HOME <> 0
    AND S_AL_DATE BETWEEN dbo.dateonly(@DateFrom) AND dbo.dateonly(@DateTo)
    AND S_AL_HEADER_KEY IN (
        SELECT ST_HEADER_KEY
        FROM SL_TRANSACTIONS
        WHERE ST_UNALLOCATED < 0.02
            AND ST_TRANTYPE = 'CRN'
    )

/* Include all invoices for commissions */
CREATE TABLE #ICT_COMMISSIONS_DUE (
    [DocumentType] VARCHAR(25),
    [InvoiceNo] VARCHAR(10),
    [TranDescription] VARCHAR(30),
    [Date] DATETIME,
    [AllocatedDate] DATETIME,					
    [NetAmt] FLOAT,
    [GrossAmt] FLOAT,
    [SalesRep] VARCHAR(40),	
    [Document] VARCHAR(20),
	[OrderNumber] FLOAT,
    [CustomerCode] VARCHAR(10),
    [CO_OS_ST_PRIMARY] FLOAT NOT NULL,			
    [CUNAME] VARCHAR(40),
    [COMMISSIONDUE] FLOAT
)

INSERT INTO #ICT_COMMISSIONS_DUE
SELECT
    'Commissions Due:',
    ST_HEADER_REF,
    ST_DESCRIPTION,
    ST_DATE,
    ST_ALLOC_DATE1,
    SUM(CASE WHEN DET_TYPE = 'CRN' THEN DET_NETT *-1
		ELSE DET_NETT
	END),      
    SUM(CASE WHEN DET_TYPE = 'CRN' THEN DET_GROSS *-1
		ELSE DET_GROSS
	END),
    ST_USER1,
    ST_USER3,
    ST_ORDER_NUMBER,
    ST_COPYCUST,
    ST_PRIMARY,
    CUNAME,
SUM(CASE WHEN ST_USER1 = '20 TRISHA DE LACY' THEN
		CASE WHEN STK_SORT_KEY LIKE '20 CLARINS%' OR STK_SORT_KEY LIKE '20 THALGO%' THEN
            CASE WHEN DET_TYPE = 'INV' THEN (DET_nett * 0.02)
            ELSE (DET_nett * 0.02 * -1)
			END
		ELSE	CASE WHEN DET_TYPE = 'INV' THEN (DET_nett * 0.015)
				ELSE (DET_nett * 0.015 * -1)
				END
		END
	ELSE	CASE
            WHEN DET_TYPE = 'INV' THEN (DET_nett * 0.015)
            ELSE (DET_nett * 0.015 * -1)
			END
	END) Commission
FROM SL_ACCOUNTS A
INNER JOIN SL_TRANSACTIONS H ON CUCODE = ST_COPYCUST
INNER JOIN SL_PL_NL_DETAIL D ON H.ST_HEADER_KEY=D.DET_HEADER_KEY
LEFT OUTER JOIN STK_STOCK S ON D.DET_STOCK_CODE=S.STKCODE
WHERE st_trantype IN ('INV','CRN')
    AND st_unallocated < 0.02
    AND st_header_key COLLATE Latin1_General_CI_AS IN (
        SELECT salheaderkey_inv
        FROM #primarykeys_invoices
        UNION ALL
        SELECT salheaderkey_crn
        FROM #primarykeys_cnotes
    )
GROUP BY ST_HEADER_REF, ST_DESCRIPTION, ST_DATE, ST_ALLOC_DATE1, ST_USER1, ST_USER3, ST_ORDER_NUMBER, ST_COPYCUST, ST_PRIMARY, CUNAME

/* Table for commissions to collect */
CREATE TABLE #ICT_COMMISSIONS_OUTSTANDING (
    [DocumentType] VARCHAR(25),
    [InvoiceNo] VARCHAR(10),
    [TranDescription] VARCHAR(30),
    [Date] DATETIME,
    [AllocatedDate] DATETIME,
    [NetAmt] FLOAT,
    [GrossAmt] FLOAT,
    [SalesRep] VARCHAR(40),
    [Document] VARCHAR(20),
	[OrderNumber] FLOAT,
    [CustomerCode] VARCHAR(10),
    [CO_OS_ST_PRIMARY] FLOAT NOT NULL,
    [CUNAME] VARCHAR(40),
    [COMMISSIONDUE] FLOAT
)

INSERT INTO #ICT_COMMISSIONS_OUTSTANDING
SELECT     
	'Commissions To Collect',
    'All',
    'All',
    @dateto,
    @dateto,
	SUM(CASE WHEN DET_TYPE = 'INV' THEN (DET_NETT)
    ELSE (DET_NETT * -1)
    END) Net,
	SUM(CASE WHEN DET_TYPE = 'INV' THEN (DET_GROSS)
    ELSE (DET_NETT * -1)
    END) Gross,
    ST_USER1,
    'Invoice',
	0,
    ST_COPYCUST,
    0,
    CUNAME,
SUM(CASE WHEN ST_USER1 = '20 TRISHA DE LACY' THEN
		CASE WHEN STK_SORT_KEY LIKE '20 CLARINS%' OR STK_SORT_KEY LIKE '20 THALGO%' THEN
            CASE WHEN DET_TYPE = 'INV' THEN (DET_nett * 0.02)
            ELSE (DET_nett * 0.02 * -1)
			END
		ELSE	CASE WHEN DET_TYPE = 'INV' THEN (DET_nett * 0.015)
				ELSE (DET_nett * 0.015 * -1)
				END
		END
	ELSE	CASE
            WHEN DET_TYPE = 'INV' THEN (DET_nett * 0.015)
            ELSE (DET_nett * 0.015 * -1)
			END
	END) Commission
FROM SL_TRANSACTIONS H
INNER JOIN SL_PL_NL_DETAIL D ON H.ST_HEADER_KEY=D.DET_HEADER_KEY
INNER JOIN SL_ACCOUNTS A ON H.ST_COPYCUST=A.CUCODE
LEFT OUTER JOIN STK_STOCK S ON D.DET_STOCK_CODE=S.STKCODE
WHERE ST_TRANTYPE IN ('INV','CRN') AND ST_UNALLOCATED > 0.02
AND CAST(DATEADD(DAY, ISNULL(A.CU_DUE_DAYS, 0), H.ST_DATE) AS DATE) < CAST(GETDATE() AS DATE) -- added by Paul 30/04/2026 for ticket 2753965888
GROUP BY ST_USER1, ST_COPYCUST, CUNAME

/* Output for Crystal Reports */
SELECT CD.*
FROM #ICT_COMMISSIONS_DUE CD
INNER JOIN SL_ACCOUNTS2 ON customercode = CUCODE2
WHERE CU_USRFLAG4 = 0

UNION ALL

SELECT CO.*
FROM #ICT_COMMISSIONS_OUTSTANDING CO
INNER JOIN SL_ACCOUNTS2 ON customercode = CUCODE2
WHERE CU_USRFLAG4 = 0
GO
