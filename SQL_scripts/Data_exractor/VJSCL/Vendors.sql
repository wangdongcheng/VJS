SELECT 'VJSCL' AS 'Company', '' AS 'Reason for Sample', PL.SUCODE AS 'Vendor ID', PL.SUNAME AS 'Description', PL.SU_COUNTRY_CODE AS 'Country Code', 
'1/0' AS 'Is Landed Cost Vender', PL.SUUSER1 AS 'Vendor Category/Class', PL.SUSORT AS 'Vendor Category/Class', PL.SU_TERMS AS 'Terms', 
PL.SUCURRENCYCODE AS 'Currency ID', PL.SUADDRESS AS 'Address L1', '' AS 'Address L2', PL.SU_ADDRESS_USER1 AS 'City', PL.SU_COUNTRY AS 'Country', 
PL.SUPOSTCODE AS 'Postal Code', PL.SUCONTACT AS 'Attention', PL.SU_EMAIL AS 'Email', '' AS 'Web', PL.SUPHONE AS 'Phone1', '' AS 'Phone2',
CASE WHEN PL.SU_COUNTRY_CODE = 'MT' THEN 'SEPA' ELSE 'Direct Deposit' END AS 'Pay Method', '' 'Payment By', 
CASE WHEN PL.SU_IMPORT_CODE = 'O' THEN 'NEUVAT'
	WHEN PL.SU_IMPORT_CODE = 'E' THEN 'EUVAT'
	WHEN PL.SU_IMPORT_CODE = 'U' THEN 'LOCVAT' END AS 'Tax Zone',
PL.SU_COUNTRY_CODE+PL.SU_VAT_REG_NO AS 'Tax Registration ID', 'C102000' AS 'AP Acccount',
--LEFT OUT--
PL.SUFAX AS 'Fax', PL.SU_NOTES AS 'Notes', 
--PL.SU_BANK_SORT AS 'Sort Code', 
PL.SU_BANK_AC_NO AS 'Account No.', 
PL.SU_BANK_AC_NAME 'Account Name', PL.SU_BANK_BACSREF AS 'BACS Reference', PL.SU_BANK_BANKNAME AS 'Bank Name', PL.SU_SWIFT_CODE AS 'Swift Code', 
PL2.SU_IBAN_NO AS 'IBAN No.', PL.SU_COMPANY_REG_NUMBER AS 'Company Reg. No', 
PL2.SU_CONTACT_TITLE AS 'Title', PL2.SU_CONTACT_INITIALS AS 'Initials', 
PL2.SU_CONTACT_FIRSTNAME AS 'First Name', PL2.SU_CONTACT_SURNAME AS 'Surname', PL2.SU_CONTACT_JOB AS 'Job Title'
FROM PL_ACCOUNTS PL
INNER JOIN PL_ACCOUNTS2 PL2 ON PL.SUCODE=PL2.SUCODE2
INNER JOIN (SELECT DISTINCT PT_COPYSUPP
FROM PL_TRANSACTIONS PL
INNER JOIN PL_ACCOUNTS PA ON PL.PT_COPYSUPP=PA.SUCODE
WHERE YEAR(PT_DATE) > '2020' AND PL.PT_TRANTYPE IN ('PAY', 'INV')) SUP ON PL.SUCODE=SUP.PT_COPYSUPP
WHERE SU_DO_NOT_USE = 0




SELECT
sucode as [Supplier Code],
SUNAME as [Supplier Name],
supostcode as [Postcode],
SU_ADDRESS_USER1 as [Town],
su_usrchar1 as [Street Name],
su_usrchar2 as [Building No.],
su_usrchar5 as [Building Name],
su_iban_no as [IBAN Number]
from PL_ACCOUNTS pa inner join
pl_accounts2 pa2 on pa.sucode=pa2.sucode2
where SU_DO_NOT_USE = 0
order by 1
;