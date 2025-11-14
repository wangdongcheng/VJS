SELECT 'VJSCL' AS 'Company', '' AS 'Reason for Sample', AC.CUCODE AS 'Customer Code', AC.CUNAME AS 'Name', AC.CUUSER1 AS 'Default salesrep Code', '' AS 'Sales Manager', 
AC.CUCONTACT AS 'Main Contact Attention', AC.CU_EMAIL AS 'Email', '' AS 'Web', AC.CUPHONE AS 'Phone1', '' AS 'PHone2', 
AC.CUADDRESS AS 'Billing Address L1', '' AS 'Billing Address L2', AC.CU_ADDRESS_USER1 AS 'Billing City', AC.CUPOSTCODE AS 'Billing Postal Code', 
AD.AD_ADDRESS AS 'Shipping Address L1', '' AS 'Shipping Address L2', AD.AD_ADDRESS_USER1 AS 'Shipping City', 
AD.AD_POSTCODE AS 'Shipping Postal Code', AC.CU_COUNTRY_CODE AS 'Country Code', '' AS 'Distribution Zone', '1' AS 'Individual Pick',
CASE WHEN AC.CU_TERMS = 'CASH' OR AC.CU_TERMS = 'CASH SALE' THEN 'COD'
        WHEN UPPER(LTRIM(RTRIM(AC.CU_TERMS))) LIKE '% DAYS' 
        THEN CONCAT(
            CASE WHEN LEN(LEFT(AC.CU_TERMS, CHARINDEX(' ', AC.CU_TERMS + ' ') - 1)) = 1 THEN '0' ELSE '' 
            END, 
        LEFT(AC.CU_TERMS, CHARINDEX(' ', AC.CU_TERMS + ' ') - 1), 'D'
        )
        ELSE AC.CU_TERMS
		END AS 'Terms', 
AC.CU_CREDIT_LIMIT AS 'Credit Limit Amount', AC.CUUSER3 AS 'Pay Method', 
CU_VAT_REG_NO AS 'Tax Registration ID', CASE WHEN AC.CU_COUNTRY_CODE = 'MT' THEN 'LOCVAT' ELSE 'EUVAT' END AS 'Tax Zone',
CASE WHEN AC.CUSORT LIKE '%PHARMA%' THEN 1 ELSE '0' END AS 'License to Sell Pharma Items', '' AS 'License Expiry Date', 'C092000' AS 'AR Account',
--CUSTOM FIELDS TO FOLLOW--
AC2.CU_USRFLAG1 AS 'Do Not Load', AC2.CU_USRCHAR1 AS 'ID Card No.', AC2.CU_USRCHAR2 AS 'Company Registration No.',
AC2.CU_USRCHAR8 AS 'Contract Detail', AC2.CU_USRCHAR9 AS 'Pet Food Rep', AC2.CU_USRCHAR11 AS 'Main Div Rep', 
AC2.CU_USRCHAR5 AS 'BDF Customer Rank', AC2.CU_USRCHAR6 AS 'H&D Customer Rank', AC2.CU_USRFLAG2 AS 'Focus Review', 
AC2.CU_USRFLAG3 AS 'Not Show Discount', AC2.CU_USRFLAG4 AS 'Strictly Cash', AC2.CU_USRFLAG5 AS 'Marketing Opt Out',
AC2.CU_USRCHAR10 AS 'Director 1', AC2.CU_USRCHAR12 AS 'Director 2', AC2.CU_USRCHAR13 AS 'Phone Marketing', AC2.CU_USRFLAG6 AS 'Bad Debts',
AC2.CU_USRFLAG7 AS 'Commissionable', AC2.CU_USRFLAG8 AS 'Automated Invoice', AC2.CU_USRFLAG9 AS '% Rebate', AC2.CU_USRFLAG10 AS 'Fixed Cost', 
AC2.CU_USRCHAR14 AS 'Hills Customer Channel', AC2.CU_USRCHAR15 AS 'Hills Customer Class', AC2.CU_USRNUM3 AS 'Disc 0 = %, 1 = Net',
AC2.CU_USRNUM4 AS 'EOY Set Off %', AC2.CU_USRCHAR16 AS 'Champion Category', AC2.CU_USRCHAR17 AS 'BI Weekly Statement',
--LEFT OUT--
AC.CUSORT AS 'Sub Category', AC.CUUSER2 AS 'Main Category', AC.CUFAX AS 'Fax', AC2.CU_MOBILE_NUMBER As 'Mobile Phone', AC2.CU_CONTACT_TITLE AS 'Title', AC2.CU_CONTACT_INITIALS AS 'Initials', 
AC2.CU_CONTACT_FIRSTNAME AS 'First Name', AC2.CU_CONTACT_SURNAME AS 'Surname', AC2.CU_CONTACT_JOB AS 'Job Title', 
AC.CUCURRENCYCODE AS 'Currency', AC.CU_NOTES AS 'Notes', AD.AD_E_MAIL AS 'Shipping Email Address', AD.AD_INV_ADDRESS AS 'Invoice Address', 
AD.AD_DEL_ADDRESS AS 'Delivery Address', AD.AD_STAT_ADDRESS AS 'Statement Address', AC.CU_PRICE_KEY AS 'Price Key'
FROM SL_ACCOUNTS AC
INNER JOIN SL_ACCOUNTS2 AC2 ON AC.CUCODE=AC2.CUCODE2
INNER JOIN SL_ADDRESSES AD ON AC.CUCODE=AD.AD_ACC_CODE
WHERE AC.CU_DO_NOT_USE = 0
ORDER BY 4