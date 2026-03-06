USE vjscl;
-- select * from tmp_import;

BEGIN try BEGIN TRAN

UPDATE STK_STOCK
set STK_EC_SUP_UNIT = ti.[To Update: Units per Case]
from stk_stock stk
inner join tmp_import ti on stk.STKCODE = ti.[Inventory ID]
where [To Update: Units per Pallet] is NOT NULL;


update STK_STOCK3
set STK_USRNUM6 = ti.[To Update: Units per Pallet],
STK_USRNUM7 = ti.[To Update: Units per Layer],
STK_USRNUM1 = ti.[To Update: PO Min Qty],
STK_USRFLAG2 = ti.[To Update: Order Process],
STK_USRNUM4 = ti.[To Update: Min Stock Coverage],
STK_USRNUM5 = ti.[To Update: Max Stock Coverage]
from stk_stock3 stk3
inner join tmp_import ti on stk3.STKCODE3 = ti.[Inventory ID]
where [To Update: Units per Pallet] is NOT NULL;


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