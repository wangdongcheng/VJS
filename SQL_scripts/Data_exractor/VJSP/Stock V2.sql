SELECT STKCODE AS 'Inventory ID', STKNAME AS 'Description', '0' AS 'Is Kit',
STK_SORT_KEY2 AS 'Category', STK_SORT_KEY1 AS 'Brand', 'Average' AS 'Valuation Method',
CASE WHEN V.VAT_RATE = 0 THEN 'RE'
	 WHEN V.VAT_RATE = 5 THEN 'RR'
	 WHEN V.VAT_RATE = 18 THEN 'RF' END AS 'Tax Category', 'P091000' AS 'Inventory GL Account', '' AS 'Inventory GL Sub Account',
'LU' AS 'Lot/Serial Class', 'EA' AS 'Base UOM', 'EA' AS 'Purchase UOM', '1' AS 'Purchase UOM Conversion to Base (Multiply)', 'EA' AS 'Sales UOM', 
'1' AS 'Sales UOM Conversion to Base (Multiply)', 'EA' AS 'Each UOM', '1' AS 'Each UOM Conversion to Base (Multiply)', 'EA' AS 'Pack UOM', 
'1' AS 'Pack UOM Conversion to Base (Multiply)', 'OUTER' AS 'Case UOM', '1' AS 'Case UOM Conversion to Base (Multiply)', 'PALLET' AS 'Pallet UOM', 
'1' AS 'Pallet UOM Conversion to Base (Multiply)', S.STK_COSTPRICE AS 'Last Cost', S.STK_BASEPRICE AS 'Default Price', 
S2.STK_SELLPRICE10 AS 'RRP (incl. VAT)', 'Chilled/NonFood' AS 'Storage Type', '' AS 'Weight', '' AS 'Weight UOM', '' AS 'Volume', 
'' AS 'Volume UOM', 0 AS 'Sell Item by Exact Weight', '' AS 'Content Weight', '' AS 'Conent Volume', '' AS 'Units Per Pallet Layer',
'' AS 'Pallet Layers', '1' AS 'Waste Charge Applies', L.LOC_USERFLAG1 AS 'FMD Scan Required', L.LOC_USERFLAG2 AS 'FMD Type', 
'1/2/3' AS 'Assembly Required', '' AS 'MA Number',
CASE WHEN S.STK_SORT_KEY2 = '50MEDICAL DEVICE' THEN '1' ELSE 0 END AS 'QA Required',
CASE WHEN S.STK_SORT_KEY = '50NOVARTIS' THEN '1' ELSE 0 END AS 'QP Required',
CASE WHEN S.STK_SORT_KEY = '50NOVARTIS' OR S.STK_SORT_KEY2 = '50MEDICAL DEVICE' THEN 0 ELSE 1 END AS 'RP Required',
--NOT INCLUDED--
S.STK_SORT_KEY3 AS 'Type', S.STK_SORT_KEY AS 'Supplier', S.STK_NOTES AS 'Notes', 
--CUSTOM FIELDS--
S3.STK_USRFLAG1 AS 'Do Not Load', S3.STK_USRFLAG2 AS 'Dangerous Drug', S3.STK_USRFLAG3 AS 'Fridge Item', 
S3.STK_USRCHAR2 AS 'Classification', S3.STK_USRCHAR5 AS 'POM/OTC', S3.STK_USRCHAR6 AS 'Generic Status', S3.STK_USRFLAG4 AS 'Extended Credit',
S3.STK_USRFLAG9 AS 'Imported by VJ', S3.STK_USRNUM2 AS 'Expiry Dont''t Block', S3.STK_USRNUM3 AS 'Commission Rate',
S.STK_EC_ORIGIN AS 'Country of Origin', S.STK_EC_COM_CODE AS 'Commodity Code'
FROM STK_STOCK S
INNER JOIN STK_STOCK3 S3 ON S.STKCODE=S3.STKCODE3
INNER JOIN STK_STOCK_2 S2 ON S.STKCODE=S2.STKCODE2
INNER JOIN SL_ANALYSIS SL ON S2.STK_SANALYSIS1=SL.SACODE
INNER JOIN SYS_VATCONTROL V ON SL.SAVATCODE=V.VAT_CODE
INNER JOIN (SELECT DISTINCT LOC_STOCKCODE2, LOC_USERFLAG1, LOC_USERFLAG2 FROM STK_LOCATION2) L ON S.STKCODE=L.LOC_STOCKCODE2
WHERE S.STK_DO_NOT_USE=0
ORDER BY 2