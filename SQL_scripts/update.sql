select 
stkcode,
stkname,
STK_SORT_KEY3,
s3.STK_USRNUM5
from STK_STOCK s inner join stk_stock3 s3 on s.stkcode = s3.stkcode3
where STK_SORT_KEY3 = '30 MPM PRODUCTS LTD.' 
-- and stk_usrnum5 = 5
return;

BEGIN try BEGIN TRAN

update stk_stock3 set stk_usrnum5 = 3.5
from stk_stock s inner join stk_stock3 s3 on s.stkcode = s3.stkcode3
where STK_SORT_KEY3 = '30 MPM PRODUCTS LTD.' and stk_usrnum5 = 5;
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