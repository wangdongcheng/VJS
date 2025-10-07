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

select Oh_ORDER_NUMBER,OH_USER_PUTIN , OH_DATE_PUTIN  ,* from vjsp.dbo.ORD_HEADER
where Oh_ORDER_NUMBER = '788771';