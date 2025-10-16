USE vjscl;

select
pl.sucode,
pl.SU_ADDRESS_USER1 'town_old',
ti.town 'town_new'
from PL_ACCOUNTS pl 
inner join tmp_import ti on pl.sucode = ti.supcode
where pl.SU_ADDRESS_USER1 = ti.town;

return;

BEGIN try BEGIN TRAN
UPDATE pl
SET
    pl.supostcode = ti.postcode
FROM
    PL_ACCOUNTS pl
    INNER JOIN tmp_import ti ON pl.sucode = ti.supcode
WHERE
    pl.supostcode <> ti.postcode;

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