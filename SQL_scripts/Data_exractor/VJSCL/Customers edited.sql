USE vjscl;

SELECT
    -- 'VJSCL' AS 'Company',
    -- '' AS 'Reason for Sample',
    AC.CUCODE AS 'Customer Code',
    AC.CUNAME AS 'Customer Name',
    AC.CUUSER1 AS 'Default salesrep Code',
    -- '' AS 'Sales Manager',
    AC.CU_EMAIL AS 'Email on Customer Page',
    -- '' AS 'Web',
    AC.CUPHONE AS 'Phone on Customer Page',
    AC.CUPOSTCODE AS 'Postal Code on Customer Page',
    AC.CUFAX AS 'Fax on Customer Page',
    -- '' AS 'PHone2',
    AC.CUADDRESS AS 'Address on Customer Page',
    -- '' AS 'Billing Address L2',
    AC.CU_ADDRESS_USER1 AS 'Town/City on Customer Page',
    AC.CU_ADDRESS_USER2 AS 'County on Customer Page',
    AC.CU_COUNTRY_CODE AS 'Country Code on Customer Page',
    -- address page details
    AD.AD_CODE AS 'Address Code',
    AD.AD_ADDRESS AS 'Address on Address Page',
    -- '' AS 'Shipping Address L2',
    AD.AD_ADDRESS_USER1 AS 'Town/City City on Address Page',
    AD.ad_address_user2 AS 'County on Address Page',
    AD.AD_POSTCODE AS 'Postal Code on Address Page',
    AD.AD_E_MAIL AS 'Email Address on Address Page',
    ISNULL(ad.ad_cc_email, '') AS 'CC Email on Address Page',
    AD.ad_phone AS 'Phone on Address Page',
    ad.ad_mobile AS 'Mobile on Address Page',
    ad.ad_fax AS 'Fax on Address Page',
    ISNULL(ad.ad_delivery_route, '') AS 'Delivery Route',
    CASE
        WHEN ad.ad_inv_address = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Invoice',
    CASE
        WHEN ad.ad_del_address = 1 OR
        ad.ad_del_address_2 = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Delivery',
    CASE
        WHEN ad.ad_stat_address = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Statement',
    ad.SL_AD_PRIMARY AS 'Address Primary ID',
    -- '' AS 'Distribution Zone',
    -- '1' AS 'Individual Pick',
    CASE
        WHEN AC.CU_TERMS = 'CASH' OR
        AC.CU_TERMS = 'CASH SALE' THEN 'COD'
        WHEN UPPER(LTRIM(RTRIM(AC.CU_TERMS))) LIKE '% DAYS' THEN CONCAT(
            CASE
                WHEN LEN(
                    LEFT(
                        AC.CU_TERMS,
                        CHARINDEX(' ', AC.CU_TERMS + ' ') - 1
                    )
                ) = 1 THEN '0'
                ELSE ''
            END,
            LEFT(
                AC.CU_TERMS,
                CHARINDEX(' ', AC.CU_TERMS + ' ') - 1
            ),
            'D'
        )
        ELSE AC.CU_TERMS
    END AS 'Terms',
    AC.CU_CREDIT_LIMIT AS 'Credit Limit Amount',
    AC.CUUSER3 AS 'Pay Method',
    AC.CU_VAT_REG_NO AS 'Tax Registration ID',
    CASE
        WHEN AC.CU_COUNTRY_CODE = 'MT' THEN 'LOCVAT'
        ELSE 'EUVAT'
    END AS 'Tax Zone',
    CASE
        WHEN AC.CUSORT LIKE '%PHARMA%' THEN 'Yes'
        ELSE ''
    END AS 'License to Sell Pharma Items',
    -- '' AS 'License Expiry Date',
    -- 'C092000' AS 'AR Account',
    --CUSTOM FIELDS TO FOLLOW--
    AC2.CU_USRFLAG1 AS 'Do Not Load',
    AC2.CU_USRCHAR1 AS 'ID Card No.',
    AC2.CU_USRCHAR2 AS 'Company Registration No.',
    AC2.CU_USRCHAR8 AS 'Contract Detail',
    AC2.CU_USRCHAR9 AS 'Pet Food Rep',
    AC2.CU_USRCHAR11 AS 'Main Div Rep',
    AC2.CU_USRCHAR5 AS 'BDF Customer Rank',
    AC2.CU_USRCHAR6 AS 'H&D Customer Rank',
    AC2.CU_USRFLAG2 AS 'Focus Review',
    AC2.CU_USRFLAG3 AS 'Not Show Discount',
    AC2.CU_USRFLAG4 AS 'Strictly Cash',
    AC2.CU_USRFLAG5 AS 'Marketing Opt Out',
    ISNULL(AC2.CU_USRCHAR10, '') AS 'Director 1',
    ISNULL(AC2.CU_USRCHAR12, '') AS 'Director 2',
    ISNULL(AC2.CU_USRCHAR13, '') AS 'Phone Marketing',
    AC2.CU_USRFLAG6 AS 'Bad Debts',
    AC2.CU_USRFLAG7 AS 'Commissionable',
    AC2.CU_USRFLAG8 AS 'Automated Invoice',
    AC2.CU_USRFLAG9 AS '% Rebate',
    AC2.CU_USRFLAG10 AS 'Fixed Cost',
    ISNULL(AC2.CU_USRCHAR14, '') AS 'Hills Customer Channel',
    ISNULL(AC2.CU_USRCHAR15, '') AS 'Hills Customer Class',
    AC2.CU_USRNUM3 AS 'Disc 0 = %, 1 = Net',
    AC2.CU_USRNUM4 AS 'EOY Set Off %',
    ISNULL(AC2.CU_USRCHAR16, '') AS 'Champion Category',
    ISNULL(AC2.CU_USRCHAR17, '') AS 'BI Weekly Statement',
    --LEFT OUT--
    AC.CUSORT AS 'Sub Category',
    AC.CUUSER2 AS 'Main Category',
    AC.CUCONTACT AS 'Main Contact Attention',
    AC2.CU_CONTACT_TITLE AS 'Title',
    AC2.CU_CONTACT_INITIALS AS 'Initials',
    AC2.CU_CONTACT_FIRSTNAME AS 'First Name',
    AC2.CU_CONTACT_SURNAME AS 'Surname',
    AC2.CU_CONTACT_JOB AS 'Job Title',
    AC2.CU_MOBILE_NUMBER AS 'Other Phone',
    AC.CUCURRENCYCODE AS 'Currency',
    AC.CU_NOTES AS 'Notes',
    -- AD.AD_INV_ADDRESS AS 'Invoice Address',
    -- AD.AD_DEL_ADDRESS AS 'Delivery Address',
    -- AD.AD_STAT_ADDRESS AS 'Statement Address',
    AC.CU_PRICE_KEY AS 'Price Key'
FROM
    SL_ACCOUNTS AC
    INNER JOIN SL_ACCOUNTS2 AC2 ON AC.CUCODE = AC2.CUCODE2
    INNER JOIN SL_ADDRESSES AD ON AC.CUCODE = AD.AD_ACC_CODE
WHERE
    AC.CU_DO_NOT_USE = 0 AND
    AD_DO_NOT_USE = 0
ORDER BY
    'Customer Code',
    'Address Code';