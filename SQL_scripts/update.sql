USE vjscl;

select
stkcode,
stkname
FROM
stk_stock stk
inner join 
tmp_import ti on stk.stkcode = ti.[stock code]
-- where 
-- stk.stkname <> ti.[description]
;

-- return;

BEGIN try BEGIN TRAN
UPDATE stk
SET
    stk.STKNAME = ti.[description]
FROM
stk_stock stk
inner join 
tmp_import ti on stk.stkcode = ti.[stock code]
where 
stk.stkname <> ti.[description]
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