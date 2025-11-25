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

SELECT
cucode,
cu_address_user1
from 
SL_ACCOUNTS
-- update sl_accounts
-- SET
-- cu_address_user1 = replace(cu_address_user1, ' - GOZO', '')
where cucode IN
(
'30AMP002',
'30AZZ004',
'30BAL003',
'30BAT003',
'30BER002',
'30BOD003',
'30CAS004',
'30CMZ001',
'30CST001',
'30CTO001',
'30FNE001',
'30FON002',
'30GGH001',
'30GHP001',
'30GOZ010',
'30GSU001',
'30GWS001',
'30IMS001',
'30IVY002',
'30JDS002',
'30JJS002',
'30JMM001',
'30JOY001',
'30LAU001',
'30LIG002'
)



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