USE vjscl;

WITH
    cus_pre AS (
        SELECT
            ac.cucode,
            CASE
                WHEN ac.CU_COUNTRY <> '' THEN ac.CU_COUNTRY
                ELSE ac.cu_country_code
            END AS 'Country'
        FROM
            sl_accounts ac
    )
SELECT
    ac.cucode AS 'Customer Code',
    ac.cuname AS 'Customer Name',
    ac.CUADDRESS + ', ' + ac.CU_ADDRESS_USER1 + ', ' + cp.Country + ', ' + ac.CUPHONE + ', ' + ac.cufax AS 'Company Address + Town + Country + Phone + Fax',
    ad_del.ad_address + ', ' + ad_del.AD_ADDRESS_USER1 AS 'Delivery Address + Town',
    AC.CU_EMAIL AS 'Email Address',
    'MT' + ac.CU_VAT_REG_NO AS 'VAT No.',
    AC2.CU_CONTACT_TITLE + ', ' + AC2.CU_CONTACT_FIRSTNAME + AC2.CU_CONTACT_SURNAME + ', ' + AC2.CU_MOBILE_NUMBER + ', ' + ', ' + AC2.CU_CONTACT_JOB + ', ' + AC2.CU_CONTACT_INITIALS AS 'Contact Details',
    AC2.CU_USRCHAR1 AS 'ID Card No.',
    AC2.CU_USRCHAR2 AS 'Company Reg. No.'
FROM
    sl_accounts ac
    INNER JOIN cus_pre cp ON ac.cucode = cp.cucode
    INNER JOIN SL_ACCOUNTS2 AC2 ON AC.CUCODE = AC2.CUCODE2
    INNER JOIN SL_ADDRESSES ad_del ON ac.cucode = ad_del.AD_ACC_CODE AND
    ad_del.AD_DEL_ADDRESS = 1
ORDER BY
    1;

-- SELECT
--     *
-- FROM
--     SL_ADDRESSES
-- WHERE
--     AD_ACC_CODE = '30csl006' AND
--     ad_del_address = 1;