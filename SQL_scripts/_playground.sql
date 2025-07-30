use VJSCL;

DECLARE @stock NVARCHAR(50);
set @stock = '50ABBABBCATH14GX50';


-- select 
-- *
-- from dbo.STK_STOCK
-- where STKCODE like @stock
-- -- where STK_RTP_FLAG = 0
-- -- where STK_S_WEIGHT != 0
-- ;

-- 50ABBABBCATH14GX50,50ABBABBCATH14GX50T
select stk.* , stk2.*, stk3.*, stk4.*
from stk_stock as stk
    LEFT JOIN STK_STOCK_2 as stk2 ON stk.STKCODE = stk2.STKCODE2
    LEFT JOIN STK_STOCK3 as stk3 on stk.STKCODE = stk3.STKCODE3
    LEFT JOIN STK_STOCK4 as stk4 on stk.STKCODE = stk4.STKCODE4
where stkcode like @stock
;



-- SELECT *
-- FROM SL_ADDRESSES
-- WHERE AD_ACC_CODE LIKE '508till001';


select top(1000)CU_PRICE_KEY
from SL_ACCOUNTS;

select top(1000) 
STK_SANALYSIS1,
STK_SANALYSIS2,
STK_SANALYSIS3,
STK_SANALYSIS4,
STK_SANALYSIS5,
STK_SANALYSIS6,
STK_SANALYSIS7,
STK_SANALYSIS8,
STK_SANALYSIS9,
STK_SANALYSIS10,
* 
from vjscl.dbo.STK_STOCK_2

select sucode,su_import_code
from vjscl.dbo.pl_accounts
-- where sucode = '30aca001'


use VJSCL;
SELECT 
AD_CODE,
*
from  SL_ADDRESSES
where ad_acc_code like '30%'
order by AD_ACC_CODE

use vjscl;
select STKCODE2,stk_supstkcde1
from STK_STOCK_2
WHERE STKCODE2 in (
'30VAM_001'
,'30VAM_017PR'
,'30VAM_036'
,'30VAM_037PR'
,'30VAM_045NL'

,'30FIO_568375UX'
,'30FIO_568375UXMH'
,'30FIO_56904570T'
,'30FIO_509218UX'
,'30FIO_567907UX'
,'30FIO_569113UX'
,'30FIO_568929UX'
,'30FIO_569113UXMH'
,'30FIO_567907UXMH'
,'30FIO_509218UXMH'
,'30FIO_567907UXT'
,'30FIO_568373UX'
,'30FIO_568373UXMH'

,'30SEP_225034'
,'30SEP_225024'
,'30SEP_5051'

)

SELECT top(100)
det_stock_code,
DET_pl,
*
from vjscl.dbo.SL_PL_NL_DETAIL
where det_stock_code like '30vam%'
