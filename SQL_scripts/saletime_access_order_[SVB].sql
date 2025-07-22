/****** Script for SelectTopNRows command from SSMS  ******/
USE Salestime_SVB
SELECT OL.Orderid as 'ST_OrdNo', OH_ORDER_NUMBER as 'AccOrdNo.', ol.id as ST_LineID, od.od_dimension3 as AccDim3, DefaultRep, CustomerCode, LocationCode, OD_LOCATN as 'Access WH', ol.StockCode, S.STKNAME,
    StockCondition, cast(TargetQtyFrom as decimal) as TargetQtyFrom, cast(TargetQtyTo as decimal) as TargetQtyTo, dl.DiscountType, cast(Value as decimal) as 'Percentage', cast(ol.TotalUnitQuantity as decimal) as 'ST_Qty', od.OD_QTYPRINTED as 'Acc_Qty_P', od.OD_QTYINVD as 'Acc_Qty', cast(ol.Price as decimal(10,2)) as 'ST_Price', OD.OD_UNITCST as 'Acc_Price',
    cast(ol.NetAmount as decimal(10,2)) as 'ST_NetAmt', OD.OD_NETT as 'Acc_NetAmt', ol.DiscountAmount as ST_Disc, OD_T_DISCVAL as Acc_Disc, OH_DISC_TOTAL_P as Acc_OverallDisc, ol.DateCreated, OH_DATE_PUTIN as 'Access Entry Date',
    OH_BATCH_FLAG as 'Batch Status'
from Orders O
    inner join OrderLines OL on OL.Orderid=O.Id
    left join SVBeauty..ORD_HEADER2 oh2 on oh2.OH_USRCHAR1=o.Id
    left join SVBeauty..ORD_HEADER OH on OH.OH_PRIMARY=OH2.OH_PRIMARY_2
    left join SVBeauty..ORD_DETAIL OD on OD.OD_ORDER_NUMBER=OH.OH_ORDER_NUMBER AND OD.OD_TYPE=OH.OH_TYPE and OD.OD_STOCK_CODE=OL.StockCode and od.OD_LOCATN=ol.LocationCode and OD_DIMENSION3=ol.Id
    left join SVBeauty..STK_STOCK S on S.STKCODE=OD.OD_STOCK_CODE
    left join DiscountLines dl on dl.id = ol.discountlineids
where OH_ORDER_NUMBER = '48125'
--where ol.Orderid = '1044784'
--AND DefaultRep = ''
order by StockCode