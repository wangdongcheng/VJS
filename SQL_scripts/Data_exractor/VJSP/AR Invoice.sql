SELECT CASE WHEN ST_TRANTYPE = 'INV' THEN 'Invoice'
			WHEN ST_TRANTYPE = 'CRN' THEN 'Credit Memo'
		ELSE ST_TRANTYPE END AS 'Type', ST_COPYCUST,
'PSIN' + RIGHT('000000' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR(10)), 7) AS 'Reference Nbr.', 'All' AS 'Tenant', ST_DATE AS 'Document Date'
, CM.[AcuCustomerID] AS 'Customer ID', 'MAIN' AS 'Customer Location', 
CAST(ST_PERIODNUMBER AS varchar(2)) + CAST(YEAR(ST_DATE) AS varchar(4)) AS 'Posting Period', ST_HEADER_REF AS 'Customer Ref.', ST_DESCRIPTION AS 'Document Description', 
'EUR' AS 'Currency', '' AS 'Currency Rate Type','1.00' AS 'Currency Rate', CU_TERMS AS 'Credit Terms', ST_DUEDATE AS 'Due Date', '50' AS 'Branch', '' AS 'Line Description', '' AS 'Inventory ID', '' AS 'Quantity', 
'' AS 'Unit Price', '' AS 'UOM', '' AS 'Amount', ST_UNALLOCATED AS 'Balance', '' AS 'Account', '' AS 'Subaccount', SRM.[AcuSalesRepCode] AS 'Salesperson ID', '' AS 'Notes'
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
INNER JOIN SL_ACCOUNTS A ON T.ST_COPYCUST=A.CUCODE
LEFT JOIN VJSERVER03.SPOT.[dbo].[VJSP_SalesRepMapping] SRM ON T.ST_USER1=SRM.[AccSalesRepCode]
WHERE ST_UNALLOCATED <> 0 AND ST_TRANTYPE IN ('INV', 'CRN')