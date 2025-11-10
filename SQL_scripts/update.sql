USE vjscl;

select distinct
AD_ACC_CODE,
AD_CODE,
ad_address_user1,
ad_inv_address,
ad_del_address,
AD_DEL_ADDRESS_2,
ad_stat_address,
SL_AD_PRIMARY
from SL_ADDRESSES sad
inner join tmp_import ti on sad.AD_ACC_CODE = ti.[Customer Code]
where 
( sad.ad_del_address = 1 or sad.AD_DEL_ADDRESS_2 = 1 )
-- and 
-- sad.AD_ACC_CODE = '30WOL002'
order by 1,2;




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

-- COMMIT;

-- END try BEGIN CATCH
-- -- Rollback if transaction is active
-- IF @@TRANCOUNT > 0 ROLLBACK;

-- -- Output error information
-- PRINT '==== Stock update operation failed ====';

-- PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));

-- PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));

-- PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR(10));

-- PRINT 'Error Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'Main Script');

-- PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(10));

-- PRINT 'Error Message: ' + ERROR_MESSAGE();

-- -- Re-throw error (optional)
-- -- THROW;
-- END CATCH;