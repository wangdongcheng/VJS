SELECT 'VJSCL' AS Company, '' AS 'Reason for Sample', STKCODE AS 'Inventory ID', STKNAME AS 'Description', '1/0' AS 'Is Kit',
STK_SORT_KEY1 AS 'Category', STK_SORT_KEY AS 'Brand', 'Average' AS 'Valuation Method',
CASE WHEN V.VAT_RATE = 0 THEN 'RE'
	 WHEN V.VAT_RATE = 5 THEN 'RR'
	 WHEN V.VAT_RATE = 18 THEN 'RF' END AS 'Tax Category', 'C091000' AS 'Inventory GL Account', '' AS 'Inventory GL Sub Account',
'LU' AS 'Lot/Serial Class', 'EA' AS 'Base UOM', '' AS 'Purchase UOM', '' AS 'Purchase UOM Conversion to Base (Multiply)',
CASE WHEN S3.STK_USRFLAG8 = 1 THEN 'OUTER' ELSE 'EA' END AS 'Sales UOM', 
CASE WHEN S3.STK_USRFLAG8 = 1 THEN S.STK_EC_SUP_UNIT ELSE 1 END AS 'Sales UOM Conversion to Base (Multiply)', 
'EA' AS 'Each UOM', '1' AS 'Each UOM Conversion to Base (Multiply)', 'EA' AS 'Pack UOM', '1' AS 'Pack UOM Conversion to Base (Multiply)', 
'OUTER' AS 'Case UOM', CASE WHEN S.STK_EC_SUP_UNIT IS NULL OR S.STK_EC_SUP_UNIT = 0 THEN 1 ELSE S.STK_EC_SUP_UNIT END AS 'Case UOM Conversion to Base (Multiply)', 
'PALLET' AS 'Pallet UOM', CASE WHEN S3.STK_USRNUM6 = 0 THEN 1 ELSE S3.STK_USRNUM6 END AS 'Pallet UOM Conversion to Base (Multiply)',
S.STK_COSTPRICE AS 'Last Cost', S.STK_BASEPRICE AS 'Default Price', S2.STK_SELLPRICE10 AS 'RRP (incl. VAT)', 'Chilled/NonFood' AS 'Storage Type', 
'' AS 'Weight',
CASE WHEN S.STK_S_WGHT_NAME = 'KG' THEN 'KG' ELSE '' END AS 'Weight UOM',
CASE WHEN S.STK_S_WGHT_NAME = 'L' THEN S.STK_S_WEIGHT ELSE '' END AS 'Volume',
CASE WHEN S.STK_S_WGHT_NAME = 'L' THEN 'L' ELSE '' END AS 'Volume UOM', '0' AS 'Sell Item by Exact Weight',
CASE WHEN S.STK_S_WGHT_NAME = 'KG' THEN S.STK_S_WEIGHT ELSE '' END AS 'Content Weight',
S3.STK_USRNUM8 AS 'Content Volume', S3.STK_USRNUM7 AS 'Units per Pallet', 
CASE WHEN S3.STK_USRNUM7 = 0 OR S3.STK_USRNUM6 = 0 THEN 0 ELSE S3.STK_USRNUM6/S3.STK_USRNUM7 END AS 'Pallet Layers', '1/0' AS 'Waste Charge Applies',
'' AS 'FMD Scan Required', '' AS 'FMD Scan Type', '1/0' AS 'Assembly Required', '' AS 'MA Number', '' AS 'QA Approval Required', 
'' AS 'QP Approval Required', '' AS 'RP Approval Required',
--NOT INCLUDED--
S.STK_SORT_KEY2 AS 'Type', S.STK_SORT_KEY3 AS 'Supplier', S.STK_NOTES AS 'Notes', S.STK_BARCODE AS 'Barcode', S.STK_EC_COM_CODE AS 'Commodity Code',
S.STK_EC_KILOS AS 'Expiry Days Alarm',
--CUSTOM FIELDS--
S3.STK_USRFLAG1 AS 'Do Not Load', S3.STK_USRFLAG3 AS 'Delisted', S3.STK_USRCHAR2 AS 'Company Division', S3.STK_USRCHAR5 AS 'Barcode 2',
S3.STK_USRNUM1 AS 'PO Min Qty', S3.STK_USRNUM2 AS 'Commission Rate %', S3.STK_USRFLAG2 AS 'Order Process', S3.STK_USRCHAR12 AS 'Order Shelf Life',
S3.STK_USRCHAR13 AS 'Sales Min Ord Qty', S3.STK_USRFLAG4 AS 'Pick List Large Bag', S3.STK_USRFLAG6 AS 'Exclude MHV Report', 
S3.STK_USRFLAG7 AS 'Orijen Special Breed', S3.STK_USRCHAR5 AS 'Family Code', S3.STK_USRFLAG8 AS 'Sell Only In Cases', 
S3.STK_USRCHAR7 AS 'Barcode Outer Case',  S3.STK_USRCHAR14 AS 'Dimensions', S3.STK_USRNUM4 AS 'Min Stock Coverage', 
S3.STK_USRNUM5 AS 'Max Stock Coverage', S3.STK_USRCHAR16 AS 'Executive', S3.STK_USRCHAR17 AS 'Champion Category'
FROM STK_STOCK S
INNER JOIN STK_STOCK3 S3 ON S.STKCODE=S3.STKCODE3
INNER JOIN STK_STOCK_2 S2 ON S.STKCODE=S2.STKCODE2
INNER JOIN SL_ANALYSIS SL ON S2.STK_SANALYSIS1=SL.SACODE
INNER JOIN SYS_VATCONTROL V ON SL.SAVATCODE=V.VAT_CODE
INNER JOIN (SELECT DISTINCT LOC_STOCKCODE2, LOC_USERFLAG1, LOC_USERFLAG2 FROM STK_LOCATION2) L ON S.STKCODE=L.LOC_STOCKCODE2
WHERE S3.STK_USRFLAG3 = 0