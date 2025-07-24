use VJSPTEST;

DECLARE @stock NVARCHAR(50);
set @stock = '50ABBABBCATH14GX50';

select 
STK_BIN_NUMBER,
*
from dbo.STK_STOCK
where STKCODE like @stock
-- where STK_RTP_FLAG = 0
-- where STK_S_WEIGHT != 0
;

-- 50ABBABBCATH14GX50,50ABBABBCATH14GX50T

select * from STK_STOCK3
where STKCODE3 like @stock
;