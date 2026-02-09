
select 
*
from STK_STOCK3
where stkcode3 = '50ABBENSPSAVCHIC';
;






return;



select *
from ORD_HEADER
where OH_ORDER_NUMBER = '827255';

select det.DET_HEADER_REF,
stk.stkcode,
stk.stkname,
det.*
from sl_pl_nl_detail det
inner join stk_stock stk ON det.det_stock_code = stk.stkcode
where 
(det_header_ref = '680038' and stkname =	'*136354 THERMOS COOLER KIDS DUAL LUNCH BOX RAINBOWS') or
(det_header_ref = '680038' and stkname =	'*167379 THERMOS COOLER KIDS DUAL LUNCH BOX DINASOUR') or
(det_header_ref = '684434' and stkname =	'F5000PU THERMOS FUNTAINER FOOD STORAGE PURPLE') or
(det_header_ref = '684434' and stkname =	'F500NY THERMOS FUNTAINER FOOD STORAGE NAVY') or
(det_header_ref = '691145' and stkname =	'F5004BL THERMOS FUNTAINER FOOD STORAGE BLUE') or
(det_header_ref = '680037' and stkname =	'150362 THERMOS COOLER CLASSIC 12 CAN BLUE') or
(det_header_ref = '673195' and stkname =	'150378 THERMOS COOLER CLASSIC 24 CAN BLUE') or
(det_header_ref = '680037' and stkname =	'150378 THERMOS COOLER CLASSIC 24 CAN BLUE')
;


select stkcode2,
stk_sellprice3,
stk_sellprice6
from STK_STOCK_2
where stkcode2 in (
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


select * from tmp_import;

select CONCAT(YEAR(DATEADD(month,DATEDIFF(month, 0, GETDATE())-1,0)),'0101')
select DATEADD(month,DATEDIFF(month, 0, GETDATE()),0)-1