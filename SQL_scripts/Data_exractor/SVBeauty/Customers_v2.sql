SELECT
    ac.cucode AS 'Main - Code',
    ac.cuname AS 'Main - Name',
    ac.cu_on_stop AS 'Main - On Stop',
    ac.cuaddress AS 'Main - Address',
    ac.cu_address_user1 AS 'Main - Town',
    ac.cuphone AS 'Main - Phone',
    ac.cu_address_user2 AS 'Main - County',
    ac.cufax AS 'Main - Fax',
    ac.cupostcode AS 'Main - Postcode',
    ac.cu_country AS 'Main - Country',
    ac.cu_email AS 'Main - Email',
    ac.cucurrencycode AS 'Main - Currency',
    ac.CU_MULTI_CURR AS 'Main - Any Currency',
    ac.cuturnoverytd AS 'Main - T/o YTD',
    ac.cubalance AS 'Main - Balance',
    --- info dialog
    cast(ac.CU_DATE_PUTIN AS DATE) AS 'Info. - Created On',
    cast(ac.CU_DATE_EDITED AS DATE) AS 'Info. - Last Changed',
    cast(ac.CU_DATE_INV AS DATE) AS 'Info. - Last Invoiced',
    cast(ac.CU_DATE_PAY AS DATE) AS 'Info. - Last Payment',
    cast(ac.CU_USERDATE1 AS DATE) AS 'Info. - Next Contact',
    ac2.CU_LEVEL AS 'Info. - Level',
    ac.cu_do_not_use AS 'Info. - Inactive',
    ac2.CU_STOCK_ALLOCATION_PRIORITY AS 'Info. - Stock Allocation Priority',
    ac.CU_DO_NOT_EMAIL_FROM_ACLOUD AS 'Info. - Don''t E-mail from Workspace',
    ac2.cu_head_office AS 'Info. - Head Office',
    ac2.cu_head_office_code AS 'Info. - Head Office Account',
    ac2.cu_head_office_defdeladdr AS 'Info. - Use Head Office default Delivery Address',
    ac2.cu_head_office_definvaddr AS 'Info. - Use Head Office default Invoice Address',
    ac.cu_buying_group_flag AS 'Info. - Buying Group',
    sc.spc_sucode AS 'Info. - Supplier Code',
    --- Terms dialog
    te.slt_code AS 'Terms - Code',
    ac.cu_terms AS 'Terms - Terms',
    ac.CU_DUE_DAYS AS 'Terms - Due Days',
    CASE
        WHEN ac.CU_DUEDATE_TYPE = 0 THEN 'From Invoice Date'
        WHEN ac.CU_DUEDATE_TYPE = 1 THEN 'End of following month'
        WHEN ac.CU_DUEDATE_TYPE = 2 THEN 'Day of following month'
        ELSE 'Days after end of the month'
    END AS 'Terms - Due Days from',
    ac.CU_A_P_DAYS AS 'Terms - Ant. Days',
    CASE
        WHEN ac.CU_ANT_DAYS_FROM_DATES_OPT = 0 THEN 'From Invoice Date'
        ELSE 'From Due Date'
    END AS 'Terms - Ant. Days From',
    --- VAT dialog
    ac.CU_ANALYSIS AS 'VAT - Sales Analysis',
    ac.cu_tax_code AS 'VAT - VAT',
    ac.cu_bank_analys AS 'VAT - Bank Analysis',
    CASE
        WHEN ac.cu_vat_reg_no <> '' THEN 'MT' + ac.cu_vat_reg_no
        ELSE ac.cu_vat_reg_no
    END AS 'VAT - VAT Reg No',
    ac.cu_company_reg_number AS 'VAT - Company Reg. No.',
    --- Sort Key tab
    ac.cusort AS 'Sort Key - Channel',
    ac.cuuser1 AS 'Sort Key - Sales Rep',
    ac.cuuser2 AS 'Sort Key - SubChannel',
    ac.cuuser3 AS 'Sort Key - Document',
    --- Notes tab
    ac.cu_notes AS 'Notes - Notes',
    --- Contact tab   
    ac.CUCONTACT AS 'Contact - Contact',
    ac2.CU_CONTACT_TITLE AS 'Contact - Title',
    ac2.CU_CONTACT_INITIALS AS 'Contact - Initials',
    ac2.CU_CONTACT_SURNAME AS 'Contact - Surname',
    ac2.CU_CONTACT_FIRSTNAME AS 'Contact - First Name',
    ac.CUSALUTE AS 'Contact - Salute',
    ac2.CU_CONTACT_JOB AS 'Contact - Job Title',
    ac2.CU_MOBILE_NUMBER AS 'Contact - Other Phone',
    --- Bank tab
    ac2.CU_BANK_SORT AS 'Bank - Sort Code',
    ac2.CU_BANK_AC_NO AS 'Bank - Account No.',
    ac2.CU_BANK_AC_NAME AS 'Bank - Account Name',
    ac2.CU_BANK_BACSREF AS 'Bank - BACS Reference',
    ac2.CU_BANK_BANKNAME AS 'Bank - Bank Name',
    ac2.CU_IBAN_NO AS 'Bank - IBAN Number',
    ac.CU_BIC_CODE AS 'Bank - SWIFT/BIC Code',
    --- Comms tab
    ac2.CU_WEBSITE_ADDRESS AS 'Comms - Internet',
    ac.CU_WEB_PASSWORD AS 'Comms - AccessWebPassword',
    ac2.CU_ISDN_NUMBER AS 'Comms - ISDN',
    ac2.CU_OUR_ACCOUNT_CODE AS 'Comms - Our Account code',
    ac2.CU_EDI_ANA AS 'Comms - ANA/EAN Location Code',
    ac2.CU_EDI_CUSTIDN AS 'Comms - Delivery Location Code',
    --- Custom fields tab
    ac2.CU_USRNUM1 as 'Custom - global Discount',
    ac2.CU_USRFLAG1 as 'Custom - Display Barcode',
    ac2.CU_USRCHAR14 as 'Custom - Customer Group',
    ac2.CU_USRFLAG2 as 'Custom - Do Not Load',
    ac2.CU_USRFLAG3 as 'Custom - MarketingOptOut',
    ac2.CU_USRFLAG4 as 'Custom - No Commission',
    ac2.CU_USRFLAG6 as 'Custom - Remove Overdues',
    ac2.CU_USRFLAG5 as 'Custom - Omit Trish Odue'
FROM
    sl_accounts ac
    INNER JOIN sl_accounts2 ac2 ON ac.cucode = ac2.cucode2
    LEFT OUTER JOIN SDK_SL_PL_CONTRA_RECS sc ON ac.cucode = sc.spc_cucode
    LEFT OUTER JOIN sl_terms te ON ac.CU_TERMS_LINK = te.SLT_PRIMARY
ORDER BY
    2;

RETURN;

SELECT
    *
FROM
    [svbeautytest].[dbo].[sl_accounts] ac
    INNER JOIN [svbeautytest].[dbo].[sl_accounts2] ac2 ON ac.cucode = ac2.cucode2
WHERE
    ac.cucode = '20abc001';