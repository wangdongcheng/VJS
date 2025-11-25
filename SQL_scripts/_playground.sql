USE vjscl;

SELECT
    sad.AD_ACC_CODE AS 'Customer Code',
    sa.cuname AS 'Customer Name',
    sad.AD_CODE AS 'Address Code',
    sa.CU_ADDRESS_USER2 AS 'County in Customer',
    sa.cu_address_user1 as 'Town/City in Customer',
    sad.ad_address_user2 as 'County in Address',
    sad.ad_address_user1 AS 'Town/City in Address',
    sad.ad_address AS 'Current Address',
    -- '' AS 'New Town/City',
    CASE
        WHEN sad.ad_inv_address = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Invoice',
    CASE
        WHEN sad.ad_del_address = 1 OR
        sad.ad_del_address_2 = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Delivery',
    CASE
        WHEN sad.ad_stat_address = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Statement',
    sad.SL_AD_PRIMARY AS 'Primary ID'
FROM
    SL_ADDRESSES sad
    LEFT OUTER JOIN sl_accounts sa ON sad.AD_ACC_CODE = sa.cucode
WHERE
    sa.cu_do_not_use = 0 AND
    sad.AD_DO_NOT_USE = 0
    -- ( sa.cu_address_user2 <> sad.ad_address_user2 OR
    --     sa.cu_address_user2 = '' OR
    --     sa.cu_address_user1 = '' OR
    --     sad.ad_address_user2 = '' OR
    --     sad.ad_address_user1 = '') 
ORDER BY
    1,
    3;

-- SELECT
--     cucode AS 'Customer Code',
--     cuname AS 'Customer Name',
--     cuuser3 AS 'Current Sort Key - Document',
--     '' AS 'New Sort Key - Document',
--     cu_terms AS 'Current Payment Terms',
--     '' AS 'New Payment Terms',
--     CU_DUE_DAYS AS 'Current Due Days',
--     '' AS 'New Due Days',
--     CASE
--         WHEN CU_DUEDATE_TYPE = 0 THEN 'From Invoice Date'
--         WHEN CU_DUEDATE_TYPE = 1 THEN 'End of following month'
--         WHEN CU_DUEDATE_TYPE = 2 THEN 'Day of following month'
--         ELSE 'Days after end of the month'
--     END AS 'Due Days from',
--     CU_A_P_DAYS AS 'Current Ant. Days',
--     '' AS 'New Ant. Days',
--     CASE
--         WHEN CU_ANT_DAYS_FROM_DATES_OPT = 0 THEN 'From Invoice Date'
--         ELSE 'From Due Date'
--     END AS 'Ant. Days From'
-- FROM
--     sl_accounts
-- WHERE
--     cu_do_not_use = 0
-- ORDER BY
--     1;

-- SELECT
-- sad.AD_ACC_CODE,
-- sad.ad_address_user1,
-- ti.[New Town/City]
-- from 
-- sl_addresses sad
-- inner join tmp_import ti on sad.SL_AD_PRIMARY = ti.[Primary ID]
-- ;

-- SELECT
-- sa.cucode,
-- sad.ad_code,
-- sa.CU_ADDRESS_USER2 as 'invoice county',
-- sad.ad_address_user2 as 'address county'
-- from sl_addresses sad
-- left OUTER JOIN sl_accounts sa on sad.AD_ACC_CODE = sa.cucode
-- where sa.cu_address_user2 <> sad.ad_address_user2 and
--     sa.cu_do_not_use = 0 AND
--     sad.AD_DO_NOT_USE = 0;
