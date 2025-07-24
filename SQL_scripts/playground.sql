use vjscl;
DECLARE @stock NVARCHAR(50);
set @stock = '30niv_89057';

select STK_S_WEIGHT,
STK_P_WEIGHT,
STK_S_WGHT_NAME,
STK_P_WGHT_NAME,
*
from vjscl.dbo.stk_stock
where STKCODE = @stock
-- where STK_S_WEIGHT != 0
;