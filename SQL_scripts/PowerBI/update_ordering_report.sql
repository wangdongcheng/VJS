USE vjscl;

PRINT 'caution! update operation, comment RETURN to confirm the execution of the script';
RETURN;

BEGIN TRY 
BEGIN TRANSACTION;

UPDATE STK_LOCATION
SET
    loc_name = 'Satellite Store'
WHERE
    loc_code = 'W10';

-- Display number of affected rows
PRINT 'Update completed, rows affected: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

COMMIT TRANSACTION;

PRINT 'Transaction committed successfully';

END TRY

BEGIN CATCH
-- If error occurs, rollback transaction
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

-- Display error information
PRINT 'Error occurred, transaction rolled back';

PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));

PRINT 'Error message: ' + ERROR_MESSAGE();

PRINT 'Error line: ' + CAST(ERROR_LINE() AS VARCHAR(10));

-- Re-throw error (optional)
-- THROW;
END CATCH;

select * from STK_LOCATION ;