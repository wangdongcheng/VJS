USE vjscl;

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
inner join tmp_import ti on STK_STOCK_2.stkcode2 = ti.[stk code]
;

return;

BEGIN try BEGIN TRAN
UPDATE stk_stock_2
SET
    stk_sell_name1 = [sell price line 1],
    stk_sell_name2 = [sell price line 2],
    stk_sell_name3 = [sell price line 3],
    stk_sell_name4 = [sell price line 4],
    stk_sell_name5 = [sell price line 5],
    stk_sell_name6 = [sell price line 6],
    stk_sell_name7 = [sell price line 7],
    stk_sell_name8 = [sell price line 8],
    stk_sell_name9 = [sell price line 9],
    stk_sell_name10 = [sell price line 10]
FROM
STK_STOCK_2 stk2
inner join tmp_import ti on stk2.stkcode2 = ti.[stk code]
;

COMMIT;

END try BEGIN CATCH
-- Rollback if transaction is active
IF @@TRANCOUNT > 0 ROLLBACK;

-- Output error information
PRINT '==== Stock update operation failed ====';

PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));

PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));

PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR(10));

PRINT 'Error Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'Main Script');

PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(10));

PRINT 'Error Message: ' + ERROR_MESSAGE();

-- Re-throw error (optional)
-- THROW;
END CATCH;