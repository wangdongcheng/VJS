SELECT
    pl.sucode AS 'Main - Code',
    pl.suname AS 'Main - Name',
    pl.su_on_stop AS 'Main - On Stop',
    pl.suaddress AS 'Main - Address',
    pl.SU_ADDRESS_USER1 AS 'Main - Town',
    pl.suphone AS 'Main - Phone',
    pl.su_address_user2 AS 'Main - County',
    pl.sufax AS 'Main - Fax',
    pl.supostcode AS 'Main - Postcode',
    pl.su_country AS 'Main - Country',
    pl.su_email AS 'Main - Email',
    pl.sucurrencycode AS 'Main - Currency',
    pl.su_MULTI_CURR AS 'Main - Any Currency',
    pl.suturnoverytd AS 'Main - T/o YTD',
    pl.subalance AS 'Main - Balance',
    --- info dialog
    pl.sU_DATE_PUTIN AS 'Info. - Created On',
    pl.sU_DATE_EDITED AS 'Info. - Last Changed',
    pl.sU_DATE_INV AS 'Info. - Last Invoiced',
    pl.sU_DATE_PAY AS 'Info. - Last Payment',
    pl2.sU_LEVEL AS 'Info. - Level',
    pl.su_do_not_use AS 'Info. - Inactive',
    sc.spc_cucode AS 'Info. - Customer Code',
    --- VAT dialog
    pl.sU_ANALYSIS AS 'VAT - Purch. Analysis',
    pl.su_tax_code AS 'VAT - VAT',
    pl.su_bank_analys AS 'VAT - Bank Analysis',
    CASE
        WHEN pl.su_vat_reg_no <> '' THEN 'MT' + pl.su_vat_reg_no
        ELSE pl.su_vat_reg_no
    END AS 'VAT - VAT Registration',
    pl.su_company_reg_number AS 'VAT - Company Reg. No.',
    --- Sort Key tab
    pl.SUSORT as 'Sort Key - Sort Key',
    pl.SUUSER1 as 'Sort Key - User Sort 1',
    pl.suuser2 as 'Sort Key - User Sort 2',
    pl.suuser3 as 'Sort Key - Inv Date YYYYMMDD',
    pl.SU_METHOD_OF_PAYMENT as 'Sort Key - Preferred Payment Method',
    --- Notes tab
    pl.SU_NOTES as 'Notes - Notes',
    --- Contact tab
    pl.sUCONTACT AS 'Contact - Contact',
    pl2.sU_CONTACT_TITLE AS 'Contact - Title',
    pl2.sU_CONTACT_INITIALS AS 'Contact - Initials',
    pl2.sU_CONTACT_SURNAME AS 'Contact - Surname',
    pl2.sU_CONTACT_FIRSTNAME AS 'Contact - First Name',
    pl.sUSALUTE AS 'Contact - Salute',
    pl2.sU_CONTACT_JOB AS 'Contact - Job Title',
    pl2.sU_MOBILE_NUMBER AS 'Contact - Other Phone',
    --- Bank tab
    pl.sU_BANK_SORT AS 'Bank - Sort Code',
    pl.sU_BANK_AC_NO AS 'Bank - Account No.',
    pl.sU_BANK_AC_NAME AS 'Bank - Account Name',
    pl.sU_BANK_BACSREF AS 'Bank - BACS Reference',
    pl.sU_BANK_BANKNAME AS 'Bank - Bank Name',
    pl2.sU_IBAN_NO AS 'Bank - IBAN Number',
    pl.SU_SWIFT_CODE AS 'Bank - SWIFT/BIC Code',
    --- Comms tab
    pl2.SU_WEBSITE_ADDRESS AS 'Comms - Internet',
    pl2.sU_ISDN_NUMBER AS 'Comms - ISDN',
    pl2.SU_OUR_ACCOUNT_CODE AS 'Comms - Our Account code',
    pl2.SU_EDI_ANA AS 'Comms - ANA/EAN Location Code',
    pl2.SU_EDI_SUPPIDN AS 'Comms - Delivery Location Code',
    --- Custom fields tab
    pl2.SU_USRCHAR1 as 'Custom - Street Name',
    pl2.SU_USRCHAR2 as 'Custom - Building No.',
    pl2.SU_USRCHAR5 as 'Custom - Building Name',
    --- Addresses dialog
    AD.pl_AD_CODE AS 'Addresses - Code',
    pl.sU_DEL_ADD_CDE AS 'Addresses - Default Address Code',
    ad.pl_AD_CONTACT AS 'Addresses - Contact',
    AD.pl_AD_ADDRESS AS 'Addresses - Address',
    AD.pl_AD_ADDRESS_USER1 AS 'Addresses - Town',
    AD.pl_ad_address_user2 AS 'Addresses - County',
    AD.pl_AD_POSTCODE AS 'Addresses - Postcode',
    ad.pl_AD_COUNTRY AS 'Addresses - Country',
    AD.pl_AD_EMAIL AS 'Addresses - E-mail',
    ad.pl_ad_cc_email AS 'Addresses - CC E-mail',
    ad.pl_AD_ANALYSIS AS 'Addresses - Purchase Analysis',
    AD.pl_ad_phone AS 'Addresses - Phone',
    ad.pl_ad_mobile AS 'Addresses - Mobile',
    ad.pl_ad_fax AS 'Addresses - Fax',
    CASE
        WHEN ad.pl_ad_inv_add = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Order',
    CASE
        WHEN ad.pl_ad_del_add = 1 OR
        ad.pl_ad_del_address_2 = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Delivery',
    CASE
        WHEN ad.pl_ad_stat_add = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Statement',
    CASE
        WHEN ad.pl_ad_rem_add = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Remittance',
    ad.pl_AD_DO_NOT_USE AS 'Addresses - No Longer Use',
    ad.pl_AD_PRIMARY AS 'Address Primary ID'
FROM
    PL_ACCOUNTS pl
    INNER JOIN PL_ACCOUNTS2 pl2 ON pl.sucode = pl2.sucode2
    INNER JOIN pl_ADDRESSES AD ON pl.sucode = AD.pl_AD_ACCCODE
    LEFT OUTER JOIN SDK_SL_PL_CONTRA_RECS sc ON pl.sucode = sc.spc_sucode
ORDER BY
    pl.suname;

RETURN;

SELECT
    *
FROM
    svbeautytest.dbo.PL_ACCOUNTS pl
    INNER JOIN svbeautytest.dbo.PL_ACCOUNTS2 pl2 ON pl.sucode = pl2.sucode2
WHERE
    pl.sucode = '10kab001';