-- select * from [Spot].[dbo].[TGT_TARGETS]
--  where SALES_REP = '30 NADESH O''BRIEN';
-- select * from [Spot].[dbo].[TGT_STRETCHED]
--  where Sales_Rep = '30 NADESH O''BRIEN';

BEGIN try BEGIN TRAN

update [Spot].[dbo].[TGT_TARGETS]
set SALES_REP = '30 NADESH OBRIEN'
where SALES_REP = '30 NADESH O''BRIEN';

update [Spot].[dbo].[TGT_STRETCHED]
set Sales_Rep = '30 NADESH OBRIEN'
where Sales_Rep = '30 NADESH O''BRIEN';
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