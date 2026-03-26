-- select * from tmp_target;
-- select * from tmp_stretch;
-- return;

BEGIN try BEGIN TRAN

DELETE FROM TGT_STRETCHED
WHERE Sales_Rep IS NULL and brand is null and StretchedTarget is null;


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