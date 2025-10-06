SELECT 'Payment' AS 'Type', 
'PSPY' + RIGHT('000000' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR(10)), 7) AS 'Reference Nbr.', 'All' AS 'Tenant', CM.[AcuCustomerID] AS 'Customer ID', 'MAIN' AS 'Customer Location', 'CSTDIRECT' AS 'Payment Method', '' AS 'Cash Account', 
ST_DATE AS 'Payment Date', CAST(ST_PERIODNUMBER AS varchar(2)) + CAST(YEAR(ST_ALLOC_DATE1) AS varchar(4)) AS 'Payment Period', ST_HEADER_REF AS 'Payment Ref.', 
ST_DESCRIPTION AS 'Document Description', '50' AS 'Branch', 'EUR' AS 'Currency', 'BANK' AS 'Currency Rate Type', '1.00' AS 'Currency Rate', '' AS 'Account', ST_UNALLOCATED AS 'Balance', 
'' AS 'Notes'
FROM SL_TRANSACTIONS T
LEFT JOIN (SELECT  AccessCustomerCode,
        AcuCustomerID
FROM (
    SELECT  AccessCustomerCode,
            AcuCustomerID,
            ROW_NUMBER() OVER (
                PARTITION BY AccessCustomerCode
                ORDER BY AcuCustomerID
            ) AS rn
    FROM VJSERVER03.[Spot].[dbo].[VJSP_CustomerMappings]
) d
WHERE d.rn = 1)  CM ON T.ST_COPYCUST=CM.[AccessCustomerCode]
LEFT JOIN VJSERVER03.SPOT.[dbo].[VJSP_SalesRepMapping] SRM ON T.ST_USER1=SRM.[AccSalesRepCode]
WHERE ST_UNALLOCATED <> 0 AND ST_TRANTYPE = 'PAY'