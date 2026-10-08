SELECT
stkcode2,
stk_supstkcde1
FROM
    STK_STOCK_2 stk2
inner join tmp_import ti on stkcode2 = ti.code


-- BEGIN TRANSACTION;
-- update stk_stock_2
-- set STK_SUPSTKCDE1 = ti.supplier_code
-- from stk_stock_2 stk2
-- INNER JOIN tmp_import ti ON stkcode2 = ti.code
-- commit ;

select * from stk_stock_2 where stkcode2 = '30TMS_174807'

select * from stk_stock where stkcode = '30TMS_176685'

select * from stk_stock3 where stkcode3 = '30TMS_176685'