USE vjscl;
SELECT
STKCODE3,
STK_USRCHAR8,
loc_code
from STK_STOCK3 stk3
INNER JOIN tmp_import ti on stk3.STKCODE3 = ti.stkcode
where stk_usrchar8 != ti.[loc_code]
;

return;

BEGIN try BEGIN TRAN

update STK_STOCK3
set stk_usrchar8 = ti.[loc_code]
from stk_stock3 stk3 inner join tmp_import ti on stk3.STKCODE3 = ti.stkcode
where stk_usrchar8 != ti.[loc_code];


commit;

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