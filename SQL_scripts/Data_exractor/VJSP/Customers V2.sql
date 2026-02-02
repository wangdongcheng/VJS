SELECT 
AC.CUCODE AS 'Customer Code', 
AC.CUNAME AS 'Name', 
AC2.CU_CONTACT_FIRSTNAME AS 'First Name',
AC2.CU_CONTACT_SURNAME AS 'Surname',
AC.CU_EMAIL AS 'Email',
AC.CUPHONE AS 'Phone1',
AC.CUADDRESS AS 'Billing Address L1',
AC.CU_ADDRESS_USER1 AS 'Billing City',
AC.CU_COUNTRY_CODE AS 'Country Code',
AC.CU_COUNTRY AS 'Billing Country',
AC.CUPOSTCODE AS 'Billing Postal Code', 
AC.CUSORT AS 'Customer Type',
P.PriceName AS 'Price Key',
AC.CUUSER3 AS 'Pay Method', 
CASE WHEN AC.CU_TERMS = 'CASH' OR AC.CU_TERMS = 'CASH SALE' THEN 'COD'
        WHEN UPPER(LTRIM(RTRIM(AC.CU_TERMS))) LIKE '% DAYS' 
        THEN CONCAT(
            CASE WHEN LEN(LEFT(AC.CU_TERMS, CHARINDEX(' ', AC.CU_TERMS + ' ') - 1)) = 1 THEN '0' ELSE '' 
            END, 
        LEFT(AC.CU_TERMS, CHARINDEX(' ', AC.CU_TERMS + ' ') - 1), 'D'
        )
        ELSE AC.CU_TERMS
		END AS 'Terms', 
AC.CUCURRENCYCODE AS 'Currency',
'MT'+CU_VAT_REG_NO AS 'Tax Registration ID',
AC.CU_COMPANY_REG_NUMBER AS 'Company Reg. ID',
CASE WHEN AC.CU_COUNTRY_CODE = 'MT' THEN 'LOCVAT' ELSE 'EUVAT' END AS 'Tax Zone',
AD.AD_CODE AS 'Address Code',
AD.AD_ADDRESS AS 'Shipping Address L1', 
AD.AD_ADDRESS_USER1 AS 'Shipping City', 
AD.AD_E_MAIL AS 'Ship Email',
AD.AD_POSTCODE AS 'Shipping Postal Code',
AD.AD_PHONE AS 'Ship Phone',
AD.AD_COUNTRY AS 'Ship Country',
'P092000' AS 'AR Account'
FROM SL_ACCOUNTS AC
INNER JOIN SL_ACCOUNTS2 AC2 ON AC.CUCODE=AC2.CUCODE2
INNER JOIN SL_ADDRESSES AD ON AC.CUCODE=AD.AD_ACC_CODE 
INNER JOIN (select *
from
(
  select case col 
	when 'STK_USRPRCKEY1' then '1'
	when 'STK_USRPRCKEY2' then '2'
	when 'STK_USRPRCKEY3' then '3'
	when 'STK_USRPRCKEY4' then '4'
	when 'STK_USRPRCKEY5' then '5'
	when 'STK_USRPRCKEY6' then '6' 
	when 'STK_USRPRCKEY7' then '7' 
	when 'STK_USRPRCKEY8' then '8'
	when 'STK_USRPRCKEY9' then '9' 
	when 'STK_USRPRCKEY10' then '10' end as PriceKey, value as 'PriceName'
  from LANG_USERFIELDS
  unpivot
  (
    value
    for col in (STK_USRPRCKEY1, STK_USRPRCKEY2, STK_USRPRCKEY3, STK_USRPRCKEY4, STK_USRPRCKEY5, STK_USRPRCKEY6, STK_USRPRCKEY7, STK_USRPRCKEY8, STK_USRPRCKEY9, STK_USRPRCKEY10)
  ) unpiv
) src) P ON AC.CU_PRICE_KEY=P.PriceKey
WHERE AC.CU_DO_NOT_USE = 0
-- add by paul 20260130_094128
and (ad.ad_del_address = 1 OR
        ad.ad_del_address_2 = 1) and
        ad.AD_DO_NOT_USE = 0
-- add end
ORDER BY AC.CUNAME, ad.ad_code;