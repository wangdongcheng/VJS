USE Salestime_scl
SELECT
    OL.Orderid AS 'ST_OrdNo',
    OH_ORDER_NUMBER AS 'AccOrdNo.',
    ol.DateCreated,
    o.Status,
    o.TotalAmount,
    ol.id AS ST_LineID,
    od.od_dimension3 AS AccDim3,
    DefaultRep,
    CustomerCode,
    LocationCode,
    OD_LOCATN AS 'Access WH',
    ol.StockCode,
    S.STKNAME,
    StockCondition,
    CAST(TargetQtyFrom AS DECIMAL) AS TargetQtyFrom,
    CAST(TargetQtyTo AS DECIMAL) AS TargetQtyTo,
    dl.DiscountType,
    CAST(VALUE AS DECIMAL) AS 'Percentage',
    CAST(ol.TotalUnitQuantity AS DECIMAL) AS 'ST_Qty',
    od.OD_QTYPRINTED AS 'Acc_Qty_P',
    od.OD_QTYINVD AS 'Acc_Qty',
    CAST(ol.Price AS DECIMAL(10, 2)) AS 'ST_Price',
    OD.OD_UNITCST AS 'Acc_Price',
    CAST(ol.NetAmount AS DECIMAL(10, 2)) AS 'ST_NetAmt',
    OD.OD_NETT AS 'Acc_NetAmt',
    CAST(ol.NetAmount AS DECIMAL(10, 2)) - OD.OD_NETT AS Discount,
    OH_DATE_PUTIN AS 'Access Entry Date',
    OH_BATCH_FLAG AS 'Batch Status'
FROM
    Orders O
    INNER JOIN OrderLines OL ON OL.Orderid = O.Id
    -- The LEFT JOIN keyword returns all records from the left table (Orders), and the matched records from the right table (OrderLines).
    LEFT JOIN VJSCL.dbo.ORD_HEADER2 oh2 ON oh2.OH_USRCHAR1 = o.Id
    LEFT JOIN VJSCL.dbo.ORD_HEADER OH ON OH.OH_PRIMARY = OH2.OH_PRIMARY_2
    LEFT JOIN VJSCL.dbo.ORD_DETAIL OD ON OD.OD_ORDER_NUMBER = OH.OH_ORDER_NUMBER AND
    OD.OD_TYPE = OH.OH_TYPE AND
    OD.OD_STOCK_CODE = OL.StockCode AND
    LEFT(od.OD_LOCATN, 3) = ol.LocationCode AND
    OD_DIMENSION3 = ol.Id
    LEFT JOIN VJSCL.dbo.STK_STOCK S ON S.STKCODE = OD.OD_STOCK_CODE
    LEFT JOIN DiscountLines dl ON dl.id = CASE
        WHEN CHARINDEX(',', ol.discountlineids) = 0 THEN ol.discountlineids
        ELSE SUBSTRING(
            ol.discountlineids,
            0,
            CHARINDEX(',', ol.discountlineids)
        )
    END
WHERE
    CustomerCode = '30KRI001' --and Price = 0
    --WHERE OL.StockCode = '30FIO_568549' 
    -- and OH_ORDER_NUMBER  in ( '799187', '771060')
    -- and ol.Orderid = '1286140'
    --and DefaultRep = '30 JOANNE SCHEMBRI'
ORDER BY
    DATECREATED DESC