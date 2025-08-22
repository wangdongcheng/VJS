-- Script for SelectTopNRows command from SSMS
USE Salestime_SVB;

SELECT
    OL.Orderid AS 'ST_OrdNo',
    OH_ORDER_NUMBER AS 'AccOrdNo.',
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
    ol.DiscountAmount AS ST_Disc,
    OD_T_DISCVAL AS Acc_Disc,
    OH_DISC_TOTAL_P AS Acc_OverallDisc,
    ol.DateCreated,
    OH_DATE_PUTIN AS 'Access Entry Date',
    OH_BATCH_FLAG AS 'Batch Status'
FROM
    Orders O
    INNER JOIN OrderLines OL ON OL.Orderid = O.Id
    LEFT JOIN SVBeauty.dbo.ORD_HEADER2 oh2 ON oh2.OH_USRCHAR1 = o.Id
    LEFT JOIN SVBeauty.dbo.ORD_HEADER OH ON OH.OH_PRIMARY = OH2.OH_PRIMARY_2
    LEFT JOIN SVBeauty.dbo.ORD_DETAIL OD ON OD.OD_ORDER_NUMBER = OH.OH_ORDER_NUMBER AND
    OD.OD_TYPE = OH.OH_TYPE AND
    OD.OD_STOCK_CODE = OL.StockCode AND
    od.OD_LOCATN = ol.LocationCode AND
    OD_DIMENSION3 = ol.Id
    LEFT JOIN SVBeauty.dbo.STK_STOCK S ON S.STKCODE = OD.OD_STOCK_CODE
    LEFT JOIN DiscountLines dl ON dl.id = ol.discountlineids
WHERE
    OH_ORDER_NUMBER = '48125'
    --where ol.Orderid = '1044784'
    --AND DefaultRep = ''
ORDER BY
    StockCode;