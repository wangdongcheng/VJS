SELECT
	-- det_primary,
	-- det_header_key,
	-- det_stock_code,  
    st_user1,
    stk.stk_sort_key1,
    det_date,
  
	sum(CASE
		WHEN det_type = 'INV' THEN det_nett
		ELSE det_nett * -1
	END) AS Sales_Value
	-- det_type
FROM
	sl_pl_nl_detail sd inner join stk_stock stk on sd.DET_STOCK_CODE = stk.stkcode
    INNER JOIN sl_transactions ON det_header_key = st_header_key
WHERE
	det_type IN ('INV', 'CRN') AND
	det_date = cast(GETDATE() AS DATE) AND
    stk.STK_SORT_KEY1 like '30 HIL PD%'
GROUP BY st_user1, stk.stk_sort_key1, det_date;
    



select stkcode,STK_EC_SUP_UNIT,STK_USRNUM1
from STK_STOCK s INNER join stk_stock3 s3 on s3.stkcode3 = s.stkcode
where stkcode in (
'30SCH_11400UX',
'30SCH_16401UX',
'30SCH_101104UX',
'30SCH_101202UX',
'30SCH_13403UX',
'30SCH_101205UX',
'30SCH_101209UX',
'30SCH_14406UX',
'30SCH_14400UX',
'30SCH_14408UX',
'30SCH_101304UX',
'30SCH_14407UX',
'30SCH_14404UX',
'30SCH_15400UX',
'30SCH_101107UX',
'30SCH_101347UX',
'30SCH_101307UX',
'30SCH_101101UX',
'30SCH_101206UX',
'30SCH_101201UX'
)



SELECT top 100
acc.cucode AS 'Customer Code',
acc.cuname AS 'Customer Name', 
det.det_header_ref AS 'Invoice Number',
det.det_stock_code AS 'Stock Code',
stk.stkname AS 'Stock Name',
*
from SL_PL_NL_DETAIL det
inner join sl_accounts acc on det.det_account = acc.cucode
inner join stk_stock stk on det.det_stock_code = stk.stkcode
where acc.cucode like '95%'
and acc.cu_do_not_use = 0
and det.det_header_ref in ('556541')
order by acc.cucode, det.det_header_ref;



return;

SELECT
    S3.STKCODE3 AS 'Stock Code',
    STK_SORT_KEY AS 'Brand',
    STK_SORT_KEY1 AS 'Sub Category',
    S.STK_SORT_KEY2 AS 'Type',
    ISNULL(S3.STK_USRCHAR18, '') AS 'Categ Manager'
FROM
    STK_STOCK3 s3
    INNER JOIN STK_STOCK S ON s3.STKCODE3 = S.STKCODE
WHERE
    S.STK_DO_NOT_USE = 0 AND
    s3.STK_USRCHAR18 IS NULL OR
    s3.STK_USRCHAR18 = ''
ORDER BY
    1;

RETURN;

SELECT
    *
FROM
    ORD_HEADER
WHERE
    OH_ORDER_NUMBER = '827255';

SELECT
    det.DET_HEADER_REF,
    stk.stkcode,
    stk.stkname,
    det.*
FROM
    sl_pl_nl_detail det
    INNER JOIN stk_stock stk ON det.det_stock_code = stk.stkcode
WHERE
    (
        det_header_ref = '680038' AND
        stkname = '*136354 THERMOS COOLER KIDS DUAL LUNCH BOX RAINBOWS'
    ) OR
    (
        det_header_ref = '680038' AND
        stkname = '*167379 THERMOS COOLER KIDS DUAL LUNCH BOX DINASOUR'
    ) OR
    (
        det_header_ref = '684434' AND
        stkname = 'F5000PU THERMOS FUNTAINER FOOD STORAGE PURPLE'
    ) OR
    (
        det_header_ref = '684434' AND
        stkname = 'F500NY THERMOS FUNTAINER FOOD STORAGE NAVY'
    ) OR
    (
        det_header_ref = '691145' AND
        stkname = 'F5004BL THERMOS FUNTAINER FOOD STORAGE BLUE'
    ) OR
    (
        det_header_ref = '680037' AND
        stkname = '150362 THERMOS COOLER CLASSIC 12 CAN BLUE'
    ) OR
    (
        det_header_ref = '673195' AND
        stkname = '150378 THERMOS COOLER CLASSIC 24 CAN BLUE'
    ) OR
    (
        det_header_ref = '680037' AND
        stkname = '150378 THERMOS COOLER CLASSIC 24 CAN BLUE'
    );

SELECT
    stkcode2,
    stk_sellprice3,
    stk_sellprice6
FROM
    STK_STOCK_2
WHERE
    stkcode2 IN (
        '30TMS_150378',
        '30TMS_150362',
        '30TMS_150378',
        '30TMS_28006',
        '30TMS_50006',
        '30TMS_F500NY',
        '30TMS_F5000PU',
        '30TMS_F5004BL',
        '30TMS_158009',
        '30TMS_176656'
    )
    -- SELECT
    -- *
    -- from SL_TRANSACTIONS
    -- where ST_ALOC_POINTER = '30pis200';
    -- SELECT
    --     sad.AD_ACC_CODE AS 'Customer Code',
    --     sa.cuname AS 'Customer Name',
    --     sad.AD_CODE AS 'Address Code',
    --     sa.CU_ADDRESS_USER2 AS 'County in Customer',
    --     sa.cu_address_user1 as 'Town/City in Customer',
    --     sad.ad_address_user2 as 'County in Address',
    --     sad.ad_address_user1 AS 'Town/City in Address',
    --     sad.ad_address AS 'Current Address',
    --     -- '' AS 'New Town/City',
    --     CASE
    --         WHEN sad.ad_inv_address = 1 THEN 'Yes'
    --         ELSE ''
    --     END AS 'Address for Invoice',
    --     CASE
    --         WHEN sad.ad_del_address = 1 OR
    --         sad.ad_del_address_2 = 1 THEN 'Yes'
    --         ELSE ''
    --     END AS 'Address for Delivery',
    --     CASE
    --         WHEN sad.ad_stat_address = 1 THEN 'Yes'
    --         ELSE ''
    --     END AS 'Address for Statement',
    --     sad.SL_AD_PRIMARY AS 'Primary ID'
    -- FROM
    --     SL_ADDRESSES sad
    --     LEFT OUTER JOIN sl_accounts sa ON sad.AD_ACC_CODE = sa.cucode
    -- WHERE
    --     sa.cu_do_not_use = 0 AND
    --     sad.AD_DO_NOT_USE = 0
    --     -- ( sa.cu_address_user2 <> sad.ad_address_user2 OR
    --     --     sa.cu_address_user2 = '' OR
    --     --     sa.cu_address_user1 = '' OR
    --     --     sad.ad_address_user2 = '' OR
    --     --     sad.ad_address_user1 = '') 
    -- ORDER BY
    --     1,
    --     3;
SELECT
    cucode AS 'Customer Code',
    cuname AS 'Customer Name',
    cuuser3 AS 'Current Sort Key - Document',
    '' AS 'New Sort Key - Document',
    cu_terms AS 'Current Payment Terms',
    '' AS 'New Payment Terms',
    CU_DUE_DAYS AS 'Current Due Days',
    '' AS 'New Due Days',
    CASE
        WHEN CU_DUEDATE_TYPE = 0 THEN 'From Invoice Date'
        WHEN CU_DUEDATE_TYPE = 1 THEN 'End of following month'
        WHEN CU_DUEDATE_TYPE = 2 THEN 'Day of following month'
        ELSE 'Days after end of the month'
    END AS 'Due Days from',
    CU_A_P_DAYS AS 'Current Ant. Days',
    '' AS 'New Ant. Days',
    CASE
        WHEN CU_ANT_DAYS_FROM_DATES_OPT = 0 THEN 'From Invoice Date'
        ELSE 'From Due Date'
    END AS 'Ant. Days From'
FROM
    sl_accounts
WHERE
    cu_do_not_use = 0
ORDER BY
    1;

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
SELECT
    *
FROM
    tmp_import;

SELECT
    CONCAT(
        YEAR(
            DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) -1, 0)
        ),
        '0101'
    )
SELECT
    DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) -1