USE vjscl;

-- BEGIN try BEGIN TRAN
-- update stk_stock3
-- set
-- STK_USRCHAR6 = ''
select 
stkcode3,
stk_usrchar6
from stk_stock3
where stkcode3 IN (
'30DELIVERYCHARGE',
'30MHFREE',
'30MHFREE1',
'30NIV_00040',
'30NIV_00041',
'30NIV_00042',
'30NIV_00044',
'30NIV_00045',
'30NIV_00047',
'30NIV_00048',
'30NIV_00051',
'30NIV_00053',
'30NIV_0010',
'30NIV_0011',
'30NIV_0012',
'30NIV_0013',
'30NIV_0014',
'30NIV_0015',
'30NIV_0016',
'30NIV_00243',
'30NIV_004',
'30NIV_005',
'30NIV_006',
'30NIV_007',
'30NIV_008',
'30NIV_009',
'30NIV_009PR',
'30NIV_01339',
'30NIV_01461',
'30NIV_01504',
'30NIV_01571',
'30NIV_01592',
'30NIV_01597',
'30NIV_04500',
'30NIV_05162',
'30NIV_05165',
'30NIV_05279',
'30NIV_05379',
'30NIV_05518',
'30NIV_05520',
'30NIV_05521',
'30NIV_05531',
'30NIV_05623',
'30NIV_081287B',
'30NIV_10005',
'30NIV_10404',
'30NIV_11001',
'30NIV_11003',
'30NIV_11012',
'30NIV_11200901',
'30NIV_11200902',
'30NIV_14911',
'30NIV_1589',
'30NIV_16050VSS',
'30NIV_5168OD',
'30NIV_5190',
'30NIV_81293',
'30NIV_8408903',
'30NIV_8408904',
'30NIV_8408907',
'30NIV_90019',
'30NIV_90040',
'30NIV_90050',
'30NIV_93044',
'30NIV_93325',
'30NIV_93435',
'30NIV_93747',
'30NIV_93802',
'30NIV_93911',
'30NIV_94111',
'30NIV_94113',
'30NIV_94157',
'30NIV_94158',
'30NIV_94159',
'30NIV_95121',
'30NIV_CUFF',
'30NIV_FLAG1',
'30NIV_FLAG2',
'30NIV_STD01L',
'30NIV_STD030',
'30NIV_STD03I',
'30NIV_STD99913',
'30NIV_STN008',
'30NIV_STN022',
'30NSL_LA04',
'30SAM_84719',
'30SMP_011000',
'30SMP_048536',
'30SMP_081441',
'30SMP_093501',
'30SMP_81339B',
'30SCH_100548IGO',
'30SCH_100561IGO',
'30SCH_100564IGO',
'30SCH_100565IGO',
'30SCH_100566IGO'


) 


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
































-- SELECT
--     sad.AD_ACC_CODE AS 'Customer Code',
--     sa.cuname AS 'Customer Name',
--     sad.AD_CODE AS 'Address Code',
--     sa.CU_ADDRESS_USER2 AS 'Current County',
--     sad.ad_address_user1 AS 'Current Town/City',
--     '' AS 'New Town/City',
--     CASE
--         WHEN sad.ad_inv_address = 1 THEN 'Yes'
--         ELSE ''
--     END AS 'Address for Invoice',
--     CASE
--         WHEN sad.ad_del_address = 1 OR
--         sad.ad_del_address_2 = 1 THEN 'Yes'
--         ELSE ''
--     END AS 'Address for Delivery',
--     CASE
--         WHEN sad.ad_stat_address = 1 THEN 'Yes'
--         ELSE ''
--     END AS 'Address for Statement',
--     sad.SL_AD_PRIMARY AS 'Primary ID'
-- FROM
--     SL_ADDRESSES sad
--     LEFT OUTER JOIN sl_accounts sa ON sad.AD_ACC_CODE = sa.cucode
-- WHERE
--     sa.cu_do_not_use = 0 AND
--     sad.AD_DO_NOT_USE = 0
--     -- and 
--     -- sad.AD_ACC_CODE = '30WOL002'
-- ORDER BY
--     1,
--     3;
-- SELECT
--     cucode AS 'Customer Code',
--     cuname AS 'Customer Name',
--     cuuser3 AS 'Current Sort Key - Document',
--     '' AS 'New Sort Key - Document',
--     cu_terms AS 'Current Payment Terms',
--     '' AS 'New Payment Terms',
--     CU_DUE_DAYS AS 'Current Due Days',
--     '' AS 'New Due Days',
--     CASE
--         WHEN CU_DUEDATE_TYPE = 0 THEN 'From Invoice Date'
--         WHEN CU_DUEDATE_TYPE = 1 THEN 'End of following month'
--         WHEN CU_DUEDATE_TYPE = 2 THEN 'Day of following month'
--         ELSE 'Days after end of the month'
--     END AS 'Due Days from',
--     CU_A_P_DAYS AS 'Current Ant. Days',
--     '' AS 'New Ant. Days',
--     CASE
--         WHEN CU_ANT_DAYS_FROM_DATES_OPT = 0 THEN 'From Invoice Date'
--         ELSE 'From Due Date'
--     END AS 'Ant. Days From'
-- FROM
--     sl_accounts
-- WHERE
--     cu_do_not_use = 0
-- ORDER BY
--     1;