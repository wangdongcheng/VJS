-- ========================================
-- PRE-UPDATE COMPREHENSIVE COMPARISON
-- ========================================

PRINT '==== PRE-UPDATE COMPREHENSIVE DATA COMPARISON ====';

SELECT 
    T.[Stock Code],
    
    -- Current Values from Database Tables
    S.STK_SORT_KEY3 AS [Current_Supplier],
    S2.STK_SUPSTKCDE1 AS [Current_Supplier_Code],
    S.STK_EC_SUP_UNIT AS [Current_Units_Per_Case],
    S.STK_P_WEIGHT AS [Current_Weight],
    S.STK_P_WGHT_NAME AS [Current_Weight_Unit],
    S3.STK_USRFLAG2 AS [Current_Flag],
    S3.STK_USRNUM1 AS [Current_Min_Order],
    S3.STK_USRNUM7 AS [Current_Layer],
    S3.STK_USRNUM6 AS [Current_Full_Pallet],
    S3.STK_USRNUM4 AS [Current_Min_Coverage],
    S3.STK_USRNUM5 AS [Current_Max_Coverage],
    S3.STK_USRNUM8 AS [Current_CBM],
    
    -- New Values from Excel Sheet
    T.[Supplier code] AS [New_Supplier_Code],
    T.[Units per case] AS [New_Units_Per_Case],
    T.[Weight value] AS [New_Weight],
    T.[Weight name] AS [New_Weight_Unit],
    1 AS [New_Flag],
    T.[Minimum Order] AS [New_Min_Order],
    ISNULL(T.[Layer], 0) AS [New_Layer],
    ISNULL(T.[Full Pallet], 0) AS [New_Full_Pallet],
    ISNULL(T.[Min Stock Coverage], 0) AS [New_Min_Coverage],
    ISNULL(T.[Max Stock Coverage], 0) AS [New_Max_Coverage],
    ISNULL(T.[CBM / Unit], 0) AS [New_CBM],
    
    -- Overall Update Status
    CASE 
        WHEN S2.STK_SUPSTKCDE1 != T.[Supplier code] 
             OR S.STK_EC_SUP_UNIT != T.[Units per case] 
             OR S.STK_P_WEIGHT != T.[Weight value] 
             OR S.STK_P_WGHT_NAME != T.[Weight name]
             OR S3.STK_USRFLAG2 != 1
             OR S3.STK_USRNUM1 != T.[Minimum Order]
             OR S3.STK_USRNUM7 != ISNULL(T.[Layer], 0)
             OR S3.STK_USRNUM6 != ISNULL(T.[Full Pallet], 0)
             OR S3.STK_USRNUM4 != ISNULL(T.[Min Stock Coverage], 0)
             OR S3.STK_USRNUM5 != ISNULL(T.[Max Stock Coverage], 0)
             OR S3.STK_USRNUM8 != ISNULL(T.[CBM / Unit], 0)
             OR S2.STK_SUPSTKCDE1 IS NULL
             OR S.STK_EC_SUP_UNIT IS NULL 
             OR S.STK_P_WEIGHT IS NULL 
             OR S.STK_P_WGHT_NAME IS NULL
             OR S3.STK_USRFLAG2 IS NULL
             OR S3.STK_USRNUM1 IS NULL
        THEN 'WILL UPDATE' 
        ELSE 'NO CHANGE' 
    END AS [Update_Status]
    
FROM [dbo].[Sheet1$] T
INNER JOIN STK_STOCK S ON S.STKCODE = T.[Stock Code]
INNER JOIN STK_STOCK_2 S2 ON S2.STKCODE2 = T.[Stock Code]
INNER JOIN STK_STOCK3 S3 ON S3.STKCODE3 = T.[Stock Code]
ORDER BY T.[Stock Code];

-- -- Declare variables to track affected rows
DECLARE @UpdatedRows1 INT = 0, @UpdatedRows2 INT = 0, @UpdatedRows3 INT = 0;

-- Begin error handling and transaction
BEGIN TRY
    -- Start consolidated transaction
    BEGIN TRAN

        -- Update STK_STOCK_2 table: supplier code
        -- UPDATE STK_STOCK_2 
        -- SET STK_SUPSTKCDE1 = [Supplier code] 
        -- FROM STK_STOCK_2 S2 
        -- INNER JOIN [dbo].[Sheet1$] T ON S2.STKCODE2 = T.[Stock Code];
        
        SET @UpdatedRows1 = @@ROWCOUNT;
        PRINT 'Updated STK_STOCK_2 table: ' + CAST(@UpdatedRows1 AS VARCHAR(10)) + ' rows affected';

        -- Update STK_STOCK table: packaging units and weight information
        UPDATE STK_STOCK 
        SET STK_EC_SUP_UNIT = [Units per case]
            -- STK_P_WEIGHT = [Weight value], 
            -- STK_P_WGHT_NAME = [Weight name] 
        FROM STK_STOCK S 
        INNER JOIN [dbo].[Sheet1$] T ON S.STKCODE = T.[Stock Code];
        
        SET @UpdatedRows2 = @@ROWCOUNT;
        PRINT 'Updated STK_STOCK table: ' + CAST(@UpdatedRows2 AS VARCHAR(10)) + ' rows affected';

        -- Update STK_STOCK3 table: inventory strategy and logistics parameters
        UPDATE STK_STOCK3 
        SET STK_USRFLAG2 = 1,
            STK_USRNUM1 = [Minimum Order],
            -- STK_USRNUM7 = ISNULL([Layer], 0),
            STK_USRNUM6 = ISNULL([Full Pallet], 0),
            STK_USRNUM4 = ISNULL([Min Stock Coverage], 0),
            STK_USRNUM5 = ISNULL([Max Stock Coverage], 0)
            -- STK_USRNUM8 = ISNULL([CBM / Unit], 0)
        FROM STK_STOCK3 S3 
        INNER JOIN [dbo].[Sheet1$] T ON S3.STKCODE3 = T.[Stock Code];
        
        SET @UpdatedRows3 = @@ROWCOUNT;
        PRINT 'Updated STK_STOCK3 table: ' + CAST(@UpdatedRows3 AS VARCHAR(10)) + ' rows affected';

        -- Commit transaction
        COMMIT;
        
        PRINT '==== Stock update operation completed successfully ====';
        PRINT 'Total updated records: ' + CAST((@UpdatedRows1 + @UpdatedRows2 + @UpdatedRows3) AS VARCHAR(10));

-- ========================================
-- POST-UPDATE COMPREHENSIVE COMPARISON
-- ========================================

-- PRINT '==== POST-UPDATE COMPREHENSIVE DATA VERIFICATION ====';

-- SELECT 
--     T.[Stock Code],
    
--     -- Updated Values from Database Tables
--     S2.STK_SUPSTKCDE1 AS [Updated_Supplier_Code],
--     S.STK_EC_SUP_UNIT AS [Updated_Units_Per_Case],
--     S.STK_P_WEIGHT AS [Updated_Weight],
--     S.STK_P_WGHT_NAME AS [Updated_Weight_Unit],
--     S3.STK_USRFLAG2 AS [Updated_Flag],
--     S3.STK_USRNUM1 AS [Updated_Min_Order],
--     S3.STK_USRNUM7 AS [Updated_Layer],
--     S3.STK_USRNUM6 AS [Updated_Full_Pallet],
--     S3.STK_USRNUM4 AS [Updated_Min_Coverage],
--     S3.STK_USRNUM5 AS [Updated_Max_Coverage],
--     S3.STK_USRNUM8 AS [Updated_CBM],
    
--     -- Expected Values from Excel Sheet
--     T.[Supplier code] AS [Expected_Supplier_Code],
--     T.[Units per case] AS [Expected_Units_Per_Case],
--     T.[Weight value] AS [Expected_Weight],
--     T.[Weight name] AS [Expected_Weight_Unit],
--     1 AS [Expected_Flag],
--     T.[Minimum Order] AS [Expected_Min_Order],
--     ISNULL(T.[Layer], 0) AS [Expected_Layer],
--     ISNULL(T.[Full Pallet], 0) AS [Expected_Full_Pallet],
--     ISNULL(T.[Min Stock Coverage], 0) AS [Expected_Min_Coverage],
--     ISNULL(T.[Max Stock Coverage], 0) AS [Expected_Max_Coverage],
--     ISNULL(T.[CBM / Unit], 0) AS [Expected_CBM],
    
--     -- Overall Verification Status
--     CASE 
--         WHEN S2.STK_SUPSTKCDE1 = T.[Supplier code] 
--              AND S.STK_EC_SUP_UNIT = T.[Units per case] 
--              AND S.STK_P_WEIGHT = T.[Weight value] 
--              AND S.STK_P_WGHT_NAME = T.[Weight name]
--              AND S3.STK_USRFLAG2 = 1
--              AND S3.STK_USRNUM1 = T.[Minimum Order]
--              AND S3.STK_USRNUM7 = ISNULL(T.[Layer], 0)
--              AND S3.STK_USRNUM6 = ISNULL(T.[Full Pallet], 0)
--              AND S3.STK_USRNUM4 = ISNULL(T.[Min Stock Coverage], 0)
--              AND S3.STK_USRNUM5 = ISNULL(T.[Max Stock Coverage], 0)
--              AND S3.STK_USRNUM8 = ISNULL(T.[CBM / Unit], 0)
--         THEN 'MATCH' 
--         ELSE 'MISMATCH' 
--     END AS [Verification_Status]
    
-- FROM [dbo].[Sheet1$] T
-- INNER JOIN STK_STOCK S ON S.STKCODE = T.[Stock Code]
-- INNER JOIN STK_STOCK_2 S2 ON S2.STKCODE2 = T.[Stock Code]
-- INNER JOIN STK_STOCK3 S3 ON S3.STKCODE3 = T.[Stock Code]
-- ORDER BY T.[Stock Code];

-- PRINT '==== UPDATE VERIFICATION COMPLETED ====';

-- -- Summary of verification results
-- SELECT 
--     [Verification_Status],
--     COUNT(*) AS [Record_Count]
-- FROM (
--     SELECT 
--         CASE 
--             WHEN S2.STK_SUPSTKCDE1 = T.[Supplier code] 
--                  AND S.STK_EC_SUP_UNIT = T.[Units per case] 
--                  AND S.STK_P_WEIGHT = T.[Weight value] 
--                  AND S.STK_P_WGHT_NAME = T.[Weight name]
--                  AND S3.STK_USRFLAG2 = 1
--                  AND S3.STK_USRNUM1 = T.[Minimum Order]
--                  AND S3.STK_USRNUM7 = ISNULL(T.[Layer], 0)
--                  AND S3.STK_USRNUM6 = ISNULL(T.[Full Pallet], 0)
--                  AND S3.STK_USRNUM4 = ISNULL(T.[Min Stock Coverage], 0)
--                  AND S3.STK_USRNUM5 = ISNULL(T.[Max Stock Coverage], 0)
--                  AND S3.STK_USRNUM8 = ISNULL(T.[CBM / Unit], 0)
--             THEN 'MATCH' 
--             ELSE 'MISMATCH' 
--         END AS [Verification_Status]
--     FROM [dbo].[Sheet1$] T
--     INNER JOIN STK_STOCK S ON S.STKCODE = T.[Stock Code]
--     INNER JOIN STK_STOCK_2 S2 ON S2.STKCODE2 = T.[Stock Code]
--     INNER JOIN STK_STOCK3 S3 ON S3.STKCODE3 = T.[Stock Code]
-- ) AS VerificationSummary
-- GROUP BY [Verification_Status];

-- PRINT '==== VERIFICATION SUMMARY COMPLETED ====';

        
END TRY
BEGIN CATCH
    -- Rollback if transaction is active
    IF @@TRANCOUNT > 0
        ROLLBACK;
    
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