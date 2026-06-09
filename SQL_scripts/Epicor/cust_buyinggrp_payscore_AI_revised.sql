WITH base AS (
    SELECT 
        C.CustID,
        C.BuyingGroup_c,
		IH.InvoiceNum,
        IH.InvoiceAmt,
        DATEDIFF(day, IH.DueDate, CD.DatePaid) AS DaysLate,
        IH.InvoiceAmt * DATEDIFF(day, IH.DueDate, CD.DatePaid) AS InvXDays
    FROM [895961].erp.InvcHead IH

    INNER JOIN (
        SELECT DISTINCT ID.InvoiceNum
        FROM [895961].dbo.InvcDtl ID
        INNER JOIN dbo.Part P 
            ON ID.PartNum = P.PartNum
        WHERE P.CommercialBrand != 'POSM'
    ) ID ON IH.InvoiceNum = ID.InvoiceNum

    INNER JOIN (
        SELECT InvoiceNum, MAX(TranDate) AS DatePaid 
        FROM [895961].erp.CashDtl 
        GROUP BY InvoiceNum
    ) CD ON IH.InvoiceNum = CD.InvoiceNum

    INNER JOIN [895961].dbo.Customer C 
        ON IH.CustNum = C.CustNum

    WHERE 
        IH.InvoiceBal = 0 
        AND IH.InvoiceAmt != 0 
        AND IH.CreditMemo = 0 
        AND C.GroupCode NOT IN ('G009','G017')
        AND CD.DatePaid >= DATEFROMPARTS(YEAR(GETDATE()),1,1)
        AND CD.DatePaid < DATEFROMPARTS(YEAR(GETDATE())+1,1,1)
),

cust_aggr AS (
    SELECT 
        CustID,
        BuyingGroup_c,
        SUM(InvXDays) * 1.0 / NULLIF(SUM(InvoiceAmt),0) AS PayscoreCY
    FROM base
    GROUP BY CustID, BuyingGroup_c
),

bg_aggr AS (
    SELECT 
        BuyingGroup_c,
        SUM(InvXDays) * 1.0 / NULLIF(SUM(InvoiceAmt),0) AS PayscoreCY
    FROM base
    GROUP BY BuyingGroup_c
)

SELECT 
    c.CustID,
    cust.Name AS CustName,
    c.BuyingGroup_c,
    c.PayscoreCY AS Customer_PayscoreCY,
    g.PayscoreCY AS Buyinggroup_PayscoreCY
FROM cust_aggr c
LEFT JOIN bg_aggr g
    ON c.BuyingGroup_c = g.BuyingGroup_c
INNER JOIN [895961].dbo.Customer cust 
    ON c.CustID = cust.CustID
ORDER BY c.BuyingGroup_c, c.CustID;