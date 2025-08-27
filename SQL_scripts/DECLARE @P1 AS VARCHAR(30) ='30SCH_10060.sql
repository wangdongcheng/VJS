DECLARE @P1 AS VARCHAR(30) ='30SCH_100601IGO',
        @P2 AS VARCHAR(30) ='WHK260825B',
        @P3 AS VARCHAR(30) ='WHK260825B';

SELECT
    Movement_Primary,
    Origin,
    Tran_Date,
    Tran_Year,
    Period,
    Year_Label,
    Year_No,
    CASE Exclude_From_Weighted_Value
        WHEN 0 THEN 0
        ELSE 1
    END,
    Stock_Code,
    Reference,
    Order_Ref,
    Order_Detail_Link,
    Serial_Number,
    Serialised,
    Cost_Header,
    Cost_Centre,
    Detail,
    Price_Adjustment_Flag,
    Analysis,
    Customer_or_Supplier_Code,
    Tran_Type,
    Direction,
    CASE Direction
        WHEN'I'THEN Quantity
        ELSE Quantity * -1
    END signedQuantity,
    CASE Direction
        WHEN'I'THEN Total_Quantity
        ELSE Total_Quantity * -1
    END signedTotalQuantity,
    CASE Quantity
        WHEN 0 THEN 0
        ELSE Cost_Price
    END CostPrice,
    Weighted_Value Weighted_Value,
    CASE Direction
        WHEN'I'THEN Cost_Value
        ELSE Cost_Value * -1
    END CostValue
FROM
    (
        SELECT
            Order_Header_Link,
            Movement_Primary,
            Stock_Code,
            Tran_Date,
            Tran_Year,
            Period,
            Period_Sort,
            Year_Label,
            Year_No,
            Year_Link,
            CASE Exclude_From_Weighted_Value
                WHEN 0 THEN 0
                ELSE 1
            END Exclude_From_Weighted_Value,
            Reference,
            Order_Ref,
            Order_Detail_Link,
            Origin,
            Serial_Number,
            Serialised,
            Cost_Header,
            Cost_Centre,
            Detail,
            Price_Adjustment_Flag,
            Sub_Analysis,
            Analysis,
            Direction,
            Quantity,
            Total_Quantity,
            Cost_Price,
            Weighted_Value,
            Cost_Value,
            Base2_Cost_Price,
            Base2_Cost_Value,
            Order_Account,
            Delivery_Account,
            Invoice_Account,
            Customer_or_Supplier_Code,
            Tran_Type
        FROM
            VJSCL.dbo.AA_STK_MOVEMENT_VIEW
    ) AS STK_TRANSACTIONS
WHERE
    Stock_Code = @P1 AND
    Sub_Analysis = @P2 AND
    Order_Header_Link ='S762301'AND
    Sub_Analysis = @P3
ORDER BY
    Movement_Primary



        SELECT
            Order_Header_Link,
            Movement_Primary,
            Stock_Code,
            Tran_Date,
            Tran_Year,
            Period,
            Period_Sort,
            Year_Label,
            Year_No,
            Year_Link,
            CASE Exclude_From_Weighted_Value
                WHEN 0 THEN 0
                ELSE 1
            END Exclude_From_Weighted_Value,
            Reference,
            Order_Ref,
            Order_Detail_Link,
            Origin,
            Serial_Number,
            Serialised,
            Cost_Header,
            Cost_Centre,
            Detail,
            Price_Adjustment_Flag,
            Sub_Analysis,
            Analysis,
            Direction,
            Quantity,
            Total_Quantity,
            Cost_Price,
            Weighted_Value,
            Cost_Value,
            Base2_Cost_Price,
            Base2_Cost_Value,
            Order_Account,
            Delivery_Account,
            Invoice_Account,
            Customer_or_Supplier_Code,
            Tran_Type
        FROM
            VJSCL.dbo.AA_STK_MOVEMENT_VIEW
            where stock_code = '30SCH_100601IGO'    
            AND Sub_Analysis = 'WHK260825B'