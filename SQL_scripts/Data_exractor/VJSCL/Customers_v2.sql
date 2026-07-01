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
    ac.CU_DATE_PUTIN AS 'Info. - Created On',
    ac.CU_DATE_EDITED AS 'Info. - Last Changed',
    ac.CU_DATE_INV AS 'Info. - Last Invoiced',
    ac.CU_DATE_PAY AS 'Info. - Last Payment',
    ac.CU_USERDATE1 AS 'Info. - Next Contact',
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
    ac.cusort AS 'Sort Key - Sub Category',
    ac.cuuser1 AS 'Sort Key - Default Rep',
    ac.cuuser2 AS 'Sort Key - Main Category',
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
    ac.CU_WEB_PASSWORD AS 'Comms - High Risk Customer',
    ac2.CU_ISDN_NUMBER AS 'Comms - ISDN',
    ac2.CU_OUR_ACCOUNT_CODE AS 'Comms - Our Account code',
    ac2.CU_EDI_ANA AS 'Comms - ANA/EAN Location Code',
    ac2.CU_EDI_CUSTIDN AS 'Comms - Delivery Location Code',
    --- Custom fields tab
    ac2.cu_usrflag1 AS 'Custom - Do Not Load',
    AC2.CU_USRCHAR1 AS 'Custom - ID Card No',
    AC2.CU_USRCHAR2 AS 'Custom - Co Reg No',
    AC2.CU_USRCHAR8 AS 'Custom - Contract Detail',
    AC2.CU_USRCHAR9 AS 'Custom - Pet/PersC/Food',
    AC2.CU_USRCHAR11 AS 'Custom - Det/HouseH/Niv',
    AC2.CU_USRCHAR5 AS 'Custom - BDF Cus Rank',
    AC2.CU_USRCHAR6 AS 'Custom - H&D Cus Rank',
    ac2.CU_USRCHAR7 AS 'Custom - Cust Short Desc',
    AC2.CU_USRFLAG2 AS 'Custom - FocusReview',
    AC2.CU_USRFLAG3 AS 'Custom - NotShowDiscount',
    AC2.CU_USRFLAG4 AS 'Custom - Strictly Cash',
    AC2.CU_USRFLAG5 AS 'Custom - MarketingOptOut',
    ac2.CU_USRNUM1 AS 'Custom - BDF Cus Target',
    AC2.CU_USRCHAR10 AS 'Custom - Director 1',
    ac2.CU_USRNUM2 AS 'Custom - H&D Cus Target',
    AC2.CU_USRCHAR12 AS 'Custom - Director 2',
    AC2.CU_USRCHAR13 AS 'Custom - Phone Marketing',
    AC2.CU_USRFLAG6 AS 'Custom - Bad Debts',
    AC2.CU_USRFLAG7 AS 'Custom - Commissionable',
    AC2.CU_USRFLAG8 AS 'Custom - Automated Invoice',
    AC2.CU_USRFLAG9 AS 'Custom - %Rebate',
    AC2.CU_USRFLAG10 AS 'Custom - Fixed Cost',
    AC2.CU_USRNUM3 AS 'Custom - Disc 0 = %, 1 = Net',
    AC2.CU_USRCHAR14 AS 'Custom - Hills_C_CHANNEL',
    AC2.CU_USRCHAR15 AS 'Custom - Hills_C_CLASS',
    AC2.CU_USRNUM4 AS 'Custom - EOY Set Off %',
    AC2.CU_USRCHAR16 AS 'Custom - Champion Categ',
    AC2.CU_USRCHAR17 AS 'Custom - Bi-Weekly Stmt?'
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
    [vjsclcasesunits].[dbo].[sl_accounts] ac
    INNER JOIN [vjsclcasesunits].[dbo].[sl_accounts2] ac2 ON ac.cucode = ac2.cucode2
WHERE
    ac.cucode = '30aab001';