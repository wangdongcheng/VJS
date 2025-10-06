SELECT AC.CUCODE AS 'Customer ID', '' AS 'Zone', 'Region/Gozo' AS 'Delivery Route', AD.AD_DELIVERY_ROUTE AS 'Day', '' AS 'Storage Classification', 
'1/0' AS 'Monday', '1/0' AS 'Tuesday', '1/0' AS 'Wednesday', '1/0' AS 'Thursday', '1/0' AS 'Friday', '1/0' AS 'Saturday', '1/0' AS 'Sunday'
FROM SL_ADDRESSES AD
INNER JOIN SL_ACCOUNTS AC ON AD.AD_ACC_CODE=AC.CUCODE
WHERE AC.CU_DO_NOT_USE = 0