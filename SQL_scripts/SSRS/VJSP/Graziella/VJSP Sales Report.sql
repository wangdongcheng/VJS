-- Base matrix: all customers × all stocks × years including LYTD

-- SELECT CUNAME FROM SL_ACCOUNTS WHERE CU_DO_NOT_USE = 0
DECLARE @CustName NVARCHAR(100) = 'ALPHA MEDICAL - NON MEDICINALS';
WITH Matrix AS (
    SELECT 
        a.CUCODE, 
        a.CUNAME, 
        s.stkcode AS DET_STOCK_CODE,
        s.STK_SORT_KEY,
        s.stkname,
        y.[Year]
    FROM sl_accounts a
    CROSS JOIN stk_stock s
    CROSS JOIN (
        SELECT DISTINCT CAST(YEAR(det_date) AS varchar) AS [Year]
        FROM SL_PL_NL_DETAIL
        WHERE YEAR(det_date) BETWEEN 2022 AND YEAR(GETDATE())
        UNION
        SELECT 'LYTD'
    
	)y
	where a.CU_DO_NOT_USE = 0 and s.STK_DO_NOT_USE = 0
)

, SalesData AS (
    -- Regular sales
    SELECT 
        d.DET_ACCOUNT,
        d.DET_STOCK_CODE,
        CAST(YEAR(det_date) AS varchar) AS [Year],
        SUM(CASE WHEN det_type = 'CRN' THEN -det_quantity ELSE det_quantity END) AS Qty,
        SUM(CASE WHEN det_type = 'CRN' THEN -det_nett ELSE det_nett END) AS Sales
    FROM SL_PL_NL_DETAIL d
    WHERE 
        det_type IN ('INV', 'CRN')
        AND DET_ORIGIN = 'so'
        AND YEAR(det_date) >= 2022
    GROUP BY 
        d.DET_ACCOUNT,
        d.DET_STOCK_CODE,
        YEAR(det_date)

    UNION ALL

    -- LYTD sales
    SELECT 
        d.DET_ACCOUNT,
        d.DET_STOCK_CODE,
        'LYTD' AS [Year],
        SUM(CASE WHEN det_type = 'CRN' THEN -det_quantity ELSE det_quantity END) AS Qty,
        SUM(CASE WHEN det_type = 'CRN' THEN -det_nett ELSE det_nett END) AS Sales
    FROM SL_PL_NL_DETAIL d
    WHERE 
        det_type IN ('INV', 'CRN')
        AND DET_ORIGIN = 'so'
        AND det_date >= DATEADD(YEAR, -1, DATEFROMPARTS(YEAR(GETDATE()), 1, 1)) 
        AND det_date <  DATEADD(YEAR, -1, CAST(GETDATE() AS DATE))
    GROUP BY 
        d.DET_ACCOUNT,
        d.DET_STOCK_CODE
)
SELECT 
    m.CUCODE,
    m.CUNAME,
    m.DET_STOCK_CODE,
    m.STK_SORT_KEY,
    m.stkname,
    m.[Year],
    ISNULL(s.Qty, 0) AS Qty,
    ISNULL(s.Sales, 0) AS Sales
FROM Matrix m
LEFT JOIN SalesData s 
    ON m.CUCODE = s.DET_ACCOUNT 
    AND m.DET_STOCK_CODE = s.DET_STOCK_CODE 
    AND m.[Year] = s.[Year]
where m.cuname = @CustName
and m.stk_sort_key in (
'50ABBOTTNUTRITION',
'50ADELCO',
'50AZURE',
'50BIOGENA',
'50BIOTECH',
'50BLOCCS',
'50CPPHARMA',
'50DEUTERA',
'50ESSENTIAL PHARMA',
'50FARVIMA',
'50FERRER',
'50GENERIS',
'50HULKA',
'50ICARE',
'50INFECTO',
'50MEDINFAR',
'50MYLAN',
'50MYLANINSTITUTIONAL',
'50NATURALWELLBEING',
'50NEWFOUNDLAND',
'50NOVARTIS',
'50NOVATIN',
'50OMNI VISION',
'50PAC3',
'50PFIZERCONSUMER',
'50PHARMAAND',
'50PHARMAMEDICO',
'50SANDOZ',
'50SERVIER',
'50SHAUNUNGARO',
'50SWEDPOSTURE',
'50TILMAN',
'50VICKS'
)
ORDER BY 
    m.CUNAME, m.[Year], m.STK_SORT_KEY