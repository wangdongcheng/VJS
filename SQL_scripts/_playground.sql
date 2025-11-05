use vjscl;





select 
stkcode2,
STK_SELL_NAME1,
STK_SELL_NAME2,
STK_SELL_NAME3,
STK_SELL_NAME4,
STK_SELL_NAME5,
STK_SELL_NAME6,
STK_SELL_NAME7,
STK_SELL_NAME8,
STK_SELL_NAME9,
STK_SELL_NAME10
from STK_STOCK_2
where 
(upper(STK_SELL_NAME1) = 'EACH' or
upper(STK_SELL_NAME2) = 'EACH' or
upper(STK_SELL_NAME3) = 'EACH' or
upper(STK_SELL_NAME4) = 'EACH' or
upper(STK_SELL_NAME5) = 'EACH' or
upper(STK_SELL_NAME6) = 'EACH' or
upper(STK_SELL_NAME7) = 'EACH' or
upper(STK_SELL_NAME8) = 'EACH' or
upper(STK_SELL_NAME9) = 'EACH' or
upper(STK_SELL_NAME10) = 'EACH' ) and
stkcode2 = '30ENS_4637';




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

select top 100 cu_terms, *
from sl_accounts;

select oh.OH_ORDER_NUMBER, sl.cu_terms, oh.oh_user3
from ORD_HEADER oh
INNER JOIN SL_ACCOUNTS sl ON oh.OH_ACCOUNT = sl.CUCODE
where 
lower(rtrim(ltrim(oh.oh_user3))) not in ('invoice', 'credit note', 'cash sale', 'cash');


SELECT DISTINCT LOWER(LTRIM(RTRIM(oh.oh_user3))) AS cleaned_value
FROM ORD_HEADER oh;

-- 'cash', 'cash sale',' invoice', 'credit note'


select distinct sd.DET_HEADER_REF
from SL_PL_NL_DETAIL sd
INNER JOIN 
stk_stock3 stk3
on sd.DET_STOCK_CODE = stk3.stkcode3
where stk3.STK_USRFLAG8 = 1;

select top 100 cucode2, *
from vjscl.dbo.sl_accounts2
where CU_USRFLAG4 = 1;

select top 100 *
from vjscl.dbo.ORD_DETAIL
where OD_PRIMARY = '808819';

select 
s.stk_sort_key as 'Brand',
s.stk_sort_key1 as 'Sub Category',
s.stk_sort_key2 as 'Type',
s.stk_sort_key3 as 'Supplier'
from vjscl.dbo.stk_stock s
where stkcode = '308in1_01505';

select * from SYS_DATAINFO;

SELECT STK_STOCK3.STK_USRCHAR5 from stk_stock3
where stkcode3 = '30nuv_30689'



If {ORD_DETAIL.OD_ENTRY_TYPE}='S' and {SYS_DATAINFO.COMP_VATNUMBER} = "15923434" 
then {ORD_DETAIL.OD_STOCK_CODE} else
//If  then
 //{ORD_DETAIL.OD_STOCK_CODE} else
//If {ORD_DETAIL.OD_ENTRY_TYPE}='P' then
// {ORD_DETAIL.OD_PRICE_CODE} else
If {ORD_DETAIL.OD_ENTRY_TYPE}='T' then
{ORD_DETAIL.OD_DETAIL}
else {ORD_DETAIL.OD_STOCK_CODE}

// The above formula is used to decide what should appear in the Detail A section of the template.
// e.g If the detail line is for a Stock item you would probably want the stock code to appear on the first line
// whereas if it is a text line item you would want the detail to appear on the first line.


If {ORD_DETAIL.OD_ENTRY_TYPE}='S' and {SYS_DATAINFO.COMP_VATNUMBER} = "15923434" 
then {STK_STOCK3.STK_USRCHAR5} else
//If  then
 //{ORD_DETAIL.OD_STOCK_CODE} else
//If {ORD_DETAIL.OD_ENTRY_TYPE}='P' then
// {ORD_DETAIL.OD_PRICE_CODE} else
If {ORD_DETAIL.OD_ENTRY_TYPE}='T' then
{ORD_DETAIL.OD_DETAIL}
else {ORD_DETAIL.OD_STOCK_CODE};

// The above formula is used to decide what should appear in the Detail A section of the template.
// e.g If the detail line is for a Stock item you would probably want the stock code to appear on the first line
// whereas if it is a text line item you would want the detail to appear on the first line.