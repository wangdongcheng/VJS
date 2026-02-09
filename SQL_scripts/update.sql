USE VJSCL;

-- SELECT
-- OH_ORDER_NUMBER,
-- OH_USER3
-- from ORD_HEADER
-- where OH_ORDER_NUMBER = '827255';
-- return;
BEGIN try BEGIN TRAN
UPDATE ORD_HEADER
SET
    oh_user3 = 'INVOICE'
WHERE
    OH_ORDER_NUMBER = '827255';

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