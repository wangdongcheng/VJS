USE Salestime_scl
SELECT OL.Orderid as 'ST_OrdNo',
    OH_ORDER_NUMBER as 'AccOrdNo.',
    ol.DateCreated,
    o.Status,
    o.TotalAmount,
    ol.id as ST_LineID,
    od.od_dimension3 as AccDim3,
    DefaultRep,
    CustomerCode,
    LocationCode,
    OD_LOCATN as 'Access WH',
    ol.StockCode,
    S.STKNAME,
    StockCondition,
    cast(TargetQtyFrom as decimal) as TargetQtyFrom,
    cast(TargetQtyTo as decimal) as TargetQtyTo,
    dl.DiscountType,
    cast(Value as decimal) as 'Percentage',
    cast(ol.TotalUnitQuantity as decimal) as 'ST_Qty',
    od.OD_QTYPRINTED as 'Acc_Qty_P',
    od.OD_QTYINVD as 'Acc_Qty',
    cast(ol.Price as decimal(10,2)) as 'ST_Price',
    OD.OD_UNITCST as 'Acc_Price',
    cast(ol.NetAmount as decimal(10,2)) as 'ST_NetAmt',
    OD.OD_NETT as 'Acc_NetAmt',
    cast(ol.NetAmount as decimal(10,2)) - OD.OD_NETT as Discount,
    OH_DATE_PUTIN as 'Access Entry Date',
    OH_BATCH_FLAG as 'Batch Status'
from Orders O
    inner join OrderLines OL on OL.Orderid=O.Id
    -- The LEFT JOIN keyword returns all records from the left table (Orders), and the matched records from the right table (OrderLines).
    left join VJSCL..ORD_HEADER2 oh2 on oh2.OH_USRCHAR1=o.Id
    left join VJSCL..ORD_HEADER OH on OH.OH_PRIMARY=OH2.OH_PRIMARY_2
    left join VJSCL..ORD_DETAIL OD on OD.OD_ORDER_NUMBER=OH.OH_ORDER_NUMBER AND OD.OD_TYPE=OH.OH_TYPE and OD.OD_STOCK_CODE=OL.StockCode and left(od.OD_LOCATN,3)=ol.LocationCode and OD_DIMENSION3=ol.Id
    left join VJSCL..STK_STOCK S on S.STKCODE=OD.OD_STOCK_CODE
    left join DiscountLines dl on dl.id = case when CHARINDEX(',',ol.discountlineids) = 0 THEN ol.discountlineids else SUBSTRING(ol.discountlineids,0,CHARINDEX(',',ol.discountlineids)) end
WHERE CustomerCode = '30SLU001' --and Price = 0
--WHERE OL.StockCode = '30FIO_568549' 
and OH_ORDER_NUMBER  in ( '799187', '771060')
-- and ol.Orderid = '1286140'
--and DefaultRep = '30 JOANNE SCHEMBRI'
order by DATECREATED DESC
