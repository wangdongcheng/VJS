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