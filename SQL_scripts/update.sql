USE vjscl;

-- SELECT
-- sa.cucode,
-- sa.cu_address_user1
-- from
-- sl_accounts sa
-- inner join tmp_import ti on sa.cucode = ti.[Customer Code]
-- ;

-- return;

BEGIN try BEGIN TRAN


update
sl_accounts
set
cu_address_user1 = ti.[NEW Town/City in Customer]
from
sl_accounts sa
inner join tmp_import ti on sa.cucode = ti.[Customer Code]



-- return;

-- BEGIN try BEGIN TRAN
-- UPDATE sl_accounts
-- SET
-- cu_address_user2 = ti.[County],
-- CU_COUNTRY = ti.[Country Code]
-- from 
-- sl_accounts sa
-- INNER JOIN 
-- tmp_import ti on sa.cucode = ti.[Customer Code]
-- ;

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