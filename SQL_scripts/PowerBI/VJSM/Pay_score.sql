SELECT
    T.SalesRep,
    SUM(T.InvXDays) / SUM(T.InvoiceAmt) AS PayscoreCY
FROM
    (
        SELECT
            SR.Name AS SalesRep,
            IH.InvoiceNum,
            IH.InvoiceDate,
            IH.InvoiceAmt,
            IH.DueDate,
            CD.DatePaid,
            MONTH(CD.DatePaid) AS PaymentMonth,
            YEAR(CD.DatePaid) AS PaymentYear,
            DATEDIFF(DAY, IH.DueDate, CD.DatePaid) AS DaysLate,
            (
                IH.InvoiceAmt * DATEDIFF(DAY, IH.DueDate, CD.DatePaid)
            ) AS InvXDays
        FROM
            [895961].erp.InvcHead IH
            INNER JOIN (
                SELECT
                    InvoiceNum,
                    ShipToNum
                FROM
                    [895961].dbo.InvcDtl ID
                    INNER JOIN dbo.Part P ON ID.PartNum = P.PartNum
                WHERE
                    P.CommercialBrand != 'POSM'
                GROUP BY
                    InvoiceNum,
                    ShipToNum
            ) ID ON IH.InvoiceNum = ID.InvoiceNum
            INNER JOIN (
                SELECT
                    InvoiceNum,
                    MAX(TranDate) AS DatePaid
                FROM
                    [895961].erp.CashDtl
                GROUP BY
                    InvoiceNum
            ) CD ON IH.InvoiceNum = CD.InvoiceNum
            INNER JOIN [895961].erp.ShipTo S ON ID.ShipToNum = S.ShipToNum AND
            TerritorySelect = 'SYST'
            INNER JOIN erp.SalesRep SR ON LEFT(IH.SalesRepList, 3) = SR.SalesRepCode
        WHERE
            IH.InvoiceBal = 0 AND
            IH.CreditMemo = 0 AND
            YEAR(CD.DatePaid) = YEAR(GETDATE())
    ) T
WHERE
    T.SalesRep NOT IN (
        'Office',
        'OfficeNew',
        'Van JBX027',
        'WHNew WHNew'
    )
GROUP BY
    T.SalesRep