USE [VJSCL]
GO
/****** Object:  Trigger [dbo].[trg_AddBCRSCharge_AfterInsert]    Script Date: 29/05/2026 08:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[trg_AddBCRSCharge_AfterInsert]
ON [dbo].[ORD_DETAIL]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Only continue if water items were added
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE OD_STOCK_CODE = '30ACT_060012000'
    )
    BEGIN
        DECLARE @OrderNumber INT;

        -- Loop through each affected order
        DECLARE cur CURSOR FOR
        SELECT DISTINCT OD_ORDER_NUMBER
        FROM inserted
        WHERE OD_STOCK_CODE = '30ACT_060012000';

        OPEN cur;
        FETCH NEXT FROM cur INTO @OrderNumber;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Run the BCRS procedure for this order
            EXEC usp_AddBCRSChargeToOrder @OrderNumber;

            FETCH NEXT FROM cur INTO @OrderNumber;
        END

        CLOSE cur;
        DEALLOCATE cur;
    END
END;




USE [VJSCL]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddBCRSChargeToOrder]    Script Date: 29/05/2026 09:03:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[usp_AddBCRSChargeToOrder]
    @OrderNumber INT
AS
BEGIN

DECLARE @BCRSCode NVARCHAR(50) = '30BCRS_CHARGE';
DECLARE @WaterCode NVARCHAR(50) = '30ACT_060012000'; -- Adjust if needed
DECLARE @BCRSPerUnit DECIMAL(10, 2) = 0.10;
DECLARE @TotalWaterQty INT;
DECLARE @GrossAmount DECIMAL(10, 2);
DECLARE @NextLineNo INT;
DECLARE @NextPrimary INT;

-- Lookup values from an existing line in the order
DECLARE @Account NVARCHAR(50);
DECLARE @PriceCode NVARCHAR(50);
DECLARE @YearLink INT;
DECLARE @DocType CHAR(1);
DECLARE @Date DATE;
DECLARE @ReqDate DATETIME;
DECLARE @UserPutIn NVARCHAR(50);
DECLARE @OrderRef NVARCHAR(255);
DECLARE @Period INT;
DECLARE @Year NVARCHAR(10);
DECLARE @BatchFlag INT;
DECLARE @BatchRef NVARCHAR(50);
DECLARE @QtyUnit INT;
DECLARE @TableCode NVARCHAR(50);
DECLARE @Dimension2 NVARCHAR(50);

-- STEP 1: Get total water quantity
SELECT @TotalWaterQty = SUM(OD_QTYORD)
FROM ORD_DETAIL
WHERE OD_ORDER_NUMBER = @OrderNumber
  AND OD_STOCK_CODE = @WaterCode;

SELECT TOP 1 @DocType = OD_TYPE
FROM ORD_DETAIL
WHERE OD_ORDER_NUMBER = @OrderNumber;

-- If no water, stop
IF ISNULL(@TotalWaterQty, 0) <= 0
    RETURN;

-- STEP 2: Get defaults from a non-BCRS line
SELECT TOP 1
    @Account = OD_ACCOUNT,
    @PriceCode = OD_PRICE_CODE,
    @YearLink = OD_YEAR_LINK,
    @Date = OD_DATE,
    @ReqDate = OD_REQDATE,
    @UserPutIn = OD_USER_PUTIN,
    @OrderRef = OD_ORDER_REF,
    @Period = OD_PERIOD,
    @Year = OD_YEAR,
    @BatchFlag = OD_BATCH_FLAG,
    @BatchRef = OD_BATCH_REF,
    @QtyUnit = OD_QTYUNIT,
    @TableCode = OD_TABLECODE,
    @Dimension2 = OD_DIMENSION2
FROM ORD_DETAIL
WHERE OD_ORDER_NUMBER = @OrderNumber
  AND OD_STOCK_CODE NOT IN (@BCRSCode);

-- STEP 2B: Skip BCRS for excluded customers
IF @Account IN ('30MHV001', '30MHV002')
BEGIN
    INSERT INTO BCRS_Log (OrderNumber, LogMessage)
    VALUES (@OrderNumber, CONCAT('Skipped - BCRS excluded for account ', @Account));
    RETURN;
END

-- Fallbacks
SET @YearLink = ISNULL(@YearLink, 25);
SET @UserPutIn = ISNULL(@UserPutIn, 'R');
SET @Period = ISNULL(@Period, 4);
SET @Year = ISNULL(@Year, 'O');
SET @BatchFlag = ISNULL(@BatchFlag, 0);
SET @QtyUnit = ISNULL(@QtyUnit, 1);
SET @TableCode = ISNULL(@TableCode, '');
SET @Dimension2 = ISNULL(@Dimension2, '');

-- STEP 3: Calculate BCRS amount
SET @GrossAmount = @TotalWaterQty * @BCRSPerUnit;

-- STEP 4: Check if BCRS line already exists
IF EXISTS (
    SELECT 1 FROM ORD_DETAIL
    WHERE OD_ORDER_NUMBER = @OrderNumber
      AND OD_STOCK_CODE = @BCRSCode
)
BEGIN
    -- STEP 4a: Update existing BCRS line
    UPDATE ORD_DETAIL
    SET OD_QTYORD = @TotalWaterQty,
        OD_QTYRESERVED = @TotalWaterQty,
        OD_NETT = @GrossAmount,
        OD_GROSS = @GrossAmount,
        OD_DETAIL = CONCAT('BCRS Deposit for ', @TotalWaterQty, ' bottles')
    WHERE OD_ORDER_NUMBER = @OrderNumber
      AND OD_STOCK_CODE = @BCRSCode;

    -- STEP 4b: Log update
    INSERT INTO BCRS_Log (OrderNumber, LogMessage)
    VALUES (@OrderNumber, 'BCRS line updated successfully');
END
ELSE
BEGIN
    -- STEP 5a: Generate next OD_PRIMARY
    UPDATE dbo.SYS_SEQCONTRL
    SET CTL_SEQ_NUMBER = CTL_SEQ_NUMBER + 1
    WHERE CTL_TABLE = 'ORD_DETAIL' AND CTL_SEQ_NAME = 'OD_PRIMARY';

    SELECT @NextPrimary = CTL_SEQ_NUMBER
    FROM dbo.SYS_SEQCONTRL
    WHERE CTL_TABLE = 'ORD_DETAIL' AND CTL_SEQ_NAME = 'OD_PRIMARY';

    -- STEP 5b: Get next line number
    SELECT @NextLineNo = ISNULL(MAX(OD_LINE_NUMBER), 0) + 1
    FROM ORD_DETAIL
    WHERE OD_ORDER_NUMBER = @OrderNumber;

    -- STEP 5c: Insert BCRS charge line
    INSERT INTO ORD_DETAIL (
        OD_PRIMARY,
        OD_ORDER_NUMBER,
        OD_LINE_NUMBER,
        OD_STOCK_CODE,
        OD_QTYORD,
        OD_QTYUNIT,
        OD_UNITCST,
        OD_QTYRESERVED,
        OD_NETT,
        OD_VATAMNT,
        OD_GROSS,
        OD_VATCODE,
        OD_VAT_RATE,
        OD_DETAIL,
        OD_TYPE,
        OD_DATE,
        OD_LEDGER,
        OD_ENTRY_TYPE,
        OD_ACCOUNT,
        OD_PRICE_CODE,
        OD_USER_PUTIN,
        OD_DATE_PUTIN,
        OD_YEAR,
        OD_YEAR_LINK,
        OD_REQDATE,
        OD_LAST_ACTION,
        OD_ORDER_REF,
        OD_PERIOD,
        OD_BATCH_FLAG,
        OD_BATCH_REF,
        OD_TABLECODE,
        OD_DIMENSION5,
        OD_DIMENSION2,
        OD_LOCATN,
        OD_ANALYSIS
    )
    VALUES (
        @NextPrimary,
        @OrderNumber,
        @NextLineNo,
        @BCRSCode,
        @TotalWaterQty,
        @QtyUnit,
        0.10,
        @TotalWaterQty,
        @GrossAmount,
        0.00,
        @GrossAmount,
        0,
        0,
        CONCAT('BCRS Deposit for ', @TotalWaterQty, ' bottles'),
        @DocType,
        @Date,
        'SO',
        'S',
        @Account,
        @PriceCode,
        @UserPutIn,
        GETDATE(),
        @Year,
        @YearLink,
        @ReqDate,
        'I',
        @OrderRef,
        @Period,
        @BatchFlag,
        @BatchRef,
        @TableCode,
        0.10,
        @Dimension2,
        'WHK',
        'BCRS CHARGE'
    );

    -- STEP 5d: Log insert
    INSERT INTO BCRS_Log (OrderNumber, LogMessage)
    VALUES (@OrderNumber, 'BCRS line added successfully');
END

-- STEP 6: Update header totals
UPDATE ORD_HEADER
SET
    OH_NETT = (SELECT SUM(OD_NETT) FROM ORD_DETAIL WHERE OD_ORDER_NUMBER = @OrderNumber),
    OH_VAT = (SELECT SUM(OD_VATAMNT) FROM ORD_DETAIL WHERE OD_ORDER_NUMBER = @OrderNumber),
    OH_GROSS = (SELECT SUM(OD_GROSS) FROM ORD_DETAIL WHERE OD_ORDER_NUMBER = @OrderNumber),
    OH_NO_OF_LINES = (SELECT COUNT(*) FROM ORD_DETAIL WHERE OD_ORDER_NUMBER = @OrderNumber)
WHERE OH_ORDER_NUMBER = @OrderNumber;

-- STEP 7: Log header update
INSERT INTO BCRS_Log (OrderNumber, LogMessage)
VALUES (@OrderNumber, 'Header totals updated');

END
