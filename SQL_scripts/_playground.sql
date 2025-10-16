use SVBeauty;
select count(cuuser1) as cnt,
 cuuser1
 from sl_accounts
 GROUP BY cuuser1;

 select * from SL_ACCOUNTS
 where cuname like '%falco%';

 select st_user1,* from vjsp.dbo.SL_TRANSACTIONS
 where ST_HEADER_REF = '749496';

select top 100 * from SL_PL_NL_DETAIL
-- where DET_HEADER_REF = '749496';

select top 100 OD_STOCK_CODE, * from vjscl.dbo.ORD_DETAIL
where OD_ORDER_NUMBER = '739015';

select top 100 stk_sort_key, * from vjscl.dbo.STK_STOCK
where stk_sort_key like '%actiph%';
where STKCODE = '30JEY_2006512UX';

select pl2.sucode2,pl.suname, pl.SU_ADDRESS_USER1,pl.SUPOSTCODE,pl2.su_usrchar1, pl2.su_usrchar2, pl2.su_usrchar5,* 
from vjscl.dbo.pl_accounts pl left outer join vjscl.dbo.pl_accounts2 pl2 on pl.SUCODE = pl2.sucode2
order by 1;


select stk.STKCODE,stk.stk_physical,stk.STK_QTYPRINTED,stk.STK_RESERVE_OUT,*
from vjscl.dbo.stk_stock stk
where 
stk.stkcode IN (
 '30FIO_56904570T',
 '308in1_02281ux'
)
-- stk.STK_RESERVE_OUT > 0
-- stk.STK_WO_UNALLOC_QUANTITY > 0
;



