USE VJSCL;

select 
sa.cucode,
sa.cuuser3,
ti.[New Sort Key - Document],
sa.cu_terms,
ti.[New Payment Terms],
sa.CU_DUE_DAYS,
ti.[New Due Days],
sa.CU_A_P_DAYS,
ti.[New Ant# Days]
from sl_accounts sa
inner join vjscl.dbo.tmp_import ti on sa.cucode = ti.[Customer Code]
-- where sa.cuuser3 != ti.[New Sort Key - Document] OR
--       sa.cu_terms != ti.[New Payment Terms] OR
--       sa.cu_due_days != ti.[New Due Days] OR
--       sa.cu_a_p_days != ti.[New Ant# Days]
;


return;

BEGIN try BEGIN TRAN

update SL_ACCOUNTS
set cuuser3 = [New Sort Key - Document],
    cu_terms = [New Payment Terms],
    CU_DUE_DAYS = [New Due Days],
    CU_A_P_DAYS = [New Ant# Days]
from sl_accounts sa
inner join vjscl.dbo.tmp_import ti on sa.cucode = ti.[Customer Code]
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

