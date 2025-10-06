SELECT 'SM' AS 'OrderType', 'PSSO' + RIGHT('000000' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR(10)), 7) AS 'Order Nbr', 'All' AS 'Tenant', 
AcuCustomerID AS 'Customer ID', 'MAIN' AS 'Customer Location', 'Open' AS 'Status', OH_DATE AS 'Doc Date', OH_REQUIREDDATE AS 'Requested Dated', 
CASE WHEN OH_TYPE = 'O' THEN 'Standard' ELSE 'Return Request' END AS 'Order Class', 'FALSE' AS 'Is Pre-Order', OH_DESCRIPTION AS 'Description', 'EUR' AS 'Currency', 
OH_ORDER_NUMBER AS 'External Ref.', IM.Workgroup AS 'Workgroup', IM.Manager AS 'Sales Manager', '' AS 'Credit Terms', 'Route' AS 'Delivery Method', '' AS 'Distribution Zone', 
'' AS 'Urgent Delivery', '' AS 'Finance Comment', '' AS 'WH Comment', '50' AS 'Branch',
OD.OD_STOCK_CODE,
IM.InventoryID, 'VJSP-MAIN' AS 'Warehouse', 'UNIT' AS 'UOM', OD.OD_QTYORD AS 'Order Qty',
OD.OD_UNITCST AS 'Unit Price', CASE WHEN OD_NETT = 0 THEN 1 ELSE 0 END AS 'Free Item', OD_LINEDISC AS 'Discount Percentage', OD_L_DISCVAL AS 'Discount Amt.', OD_NETT AS 'Ext. Price',
CASE WHEN OD_TYPE = 'O' THEN '' ELSE OH_DESCRIPTION END AS 'Reason Code', SRM.[AcuSalesRepCode] AS 'Salesperson ID', '' AS 'Tax Category ID'
FROM ORD_DETAIL OD
INNER JOIN ORD_HEADER OH ON OD.OD_ORDER_NUMBER=OH.OH_ORDER_NUMBER
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
WHERE d.rn = 1)  CM ON OD.OD_ACCOUNT=CM.[AccessCustomerCode]
LEFT JOIN VJSERVER03.SPOT.[dbo].[VJSP_SalesRepMapping] SRM ON OH.OH_USER1=SRM.[AccSalesRepCode]
LEFT JOIN VJSERVER03.SPOT.[dbo].[VJSP_InventoryMapping] IM ON OD.OD_STOCK_CODE=IM.AccessCode
WHERE OD_DATE >= DATEADD(day, -14, SYSUTCDATETIME()) AND OH_STATUS = 0