USE vjscl;

PRINT 'caution! update operation, comment RETURN to confirm the execution of the script';

RETURN;

BEGIN TRY 
BEGIN TRANSACTION;

UPDATE STK_STOCK3
SET
    STK_USRNUM5 = 5
WHERE
    STKCODE3 IN (
        '30APP_1046UX',
        '30APP_1328UX',
        '30APP_1331UX',
        '30APP_31051UX',
        '30APP_31075UX',
        '30APP_31099UX',
        '30APP_33611UX',
        '30APP_34731UX',
        '30APP_34755UX',
        '30APP_34793UX',
        '30APP_34816UX',
        '30APP_34830UX',
        '30APP_34878UX',
        '30APP_34892UX',
        '30APP_35257UX',
        '30APP_35646',
        '30APP_35653',
        '30APP_35677',
        '30APP_35790',
        '30APP_35806',
        '30APP_39460',
        '30APP_39644',
        '30APP_4074',
        '30APP_4077',
        '30APP_4520BPC',
        '30APP_4520CC',
        '30APP_4520CPC',
        '30APP_4520LBAC',
        '30APP_8003UX',
        '30APP_8006UX',
        '30APP_8017UX',
        '30APP_8026UX',
        '30APP_8027UX',
        '30APP_8028UX',
        '30APP_8031UX',
        '30APP_8042UX',
        '30APP_8043UX',
        '30APP_8273UX',
        '30APP_8275UX',
        '30APP_8278UX',
        '30APP_91365',
        '30APP_91372',
        '30APP_91389',
        '30APP_91402',
        '30APP_91419',
        '30APP_91426',
        '30APP_91433',
        '30APP_91648',
        '30APP_92096UX',
        '30APP_92102UX',
        '30APP_92119UX',
        '30APP_92126UX',
        '30APP_92133UX',
        '30APP_92140UX',
        '30APP_92157UX',
        '30APP_92164UX',
        '30APP_92171UX',
        '30APP_92188UX',
        '30APP_92195UX',
        '30APP_92201UX',
        '30APP_92218UX',
        '30APP_92225UX',
        '30APP_92232UX',
        '30APP_94205UX',
        '30APP_9504UX',
        '30APP_9509UX',
        '30APP_9602UX',
        '30APP_97275',
        '30APP_97299',
        '30APP_TT3031UX',
        '30APP_TT3032UX',
        '30APP_TT3034UX',
        '30APP_TT3035UX',
        '30APP_TT3036UX',
        '30APP_TT3411UX',
        '30APP_TT3412UX',
        '30APP_TT3413UX',
        '30APP_TT3520UX',
        '30APP_TT3521UX',
        '30APP_TT9020UX',
        '30APP_TT9030UX',
        '30APP_TT9410UX',
        '30APP_TT9420UX',
        '30APP_TT9430UX',
        '30APP_TT9910UX',
        '30APP_TT9920UX',
        '30ENC_1002',
        '30ENC_1003',
        '30ENC_1005',
        '30ENC_1006',
        '30ENC_1008',
        '30ENC_1014',
        '30ENC_3001',
        '30ENC_3005',
        '30ENC_3006',
        '30ENC_4810',
        '30ENC_8101',
        '30ENC_8102',
        '30ENC_8108'
    );

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