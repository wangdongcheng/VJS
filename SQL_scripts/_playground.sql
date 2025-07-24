use VJSPTEST;

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
