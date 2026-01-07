use vjscl;
DECLARE @DateFrom DATETIME = '2025-10-01',
 @DateTo DATETIME = '2026-01-31';

select top 100percent
		case when [DiscountName] is null then 'No Discount in ST' else DiscountName end as 'DiscountName'
	  ,[Month]
      ,[InvoiceNumber]
      ,[TranDate]
	  ,[CustCode]
      ,[ProductCode]
      ,[Product]
      ,[Qty]
      ,SellPrice
	  ,TradeDiscountValue
	  ,CashDiscountValue
	  ,[SalesValue]
      ,case when NetValueBeforeDiscount = 0 then 0 else (round((TradeDiscountValue/NetValueBeforeDiscount),2))*100 end as DiscountPercent
	  ,[pod_unitcst] as SupplierPrice
	  ,case when NetValueBeforeDiscount = 0 then 0 else round((TradeDiscountValue/NetValueBeforeDiscount),2)  * ([pod_unitcst]*qty) end as ToClaim
	  ,OH_INTERNL_NOTE as Remarks
	  ,OH_DESCRIPTION as InternalRemarks
	  ,DeliveryAddress

from

(
select Month(det_date) Month, det_header_ref InvoiceNumber, det_date TranDate, DET_ACCOUNT CustCode, stkcode ProductCode, stkname Product, det_quantity Qty, det_primary, det_unit_price SellPrice,
det_nett SalesValue, DET_L_DISCOUNT TradeDiscountValue, DET_T_DISCOUNT CashDiscountValue, (det_quantity*det_unit_price) NetValueBeforeDiscount, DET_DIMENSION3, OH_INTERNL_NOTE, OH_DESCRIPTION,
A.AD_ADDRESS AS DeliveryAddress
from sl_pl_nl_detail
inner join stk_stock on stkcode = det_stock_code
inner join ORD_DETAIL on DET_ORDER_LINK=OD_PRIMARY and DET_STOCK_CODE=OD_STOCK_CODE and DET_QUANTITY=OD_QTYINVD
inner join ORD_HEADER on OD_ORDER_NUMBER=OH_ORDER_NUMBER
INNER JOIN SL_ADDRESSES A ON oh_del_add=A.AD_CODE and det_account=a.ad_acc_code
where stk_sort_key3 = '30 MORANDO SPA' and DET_ORIGIN = 'SO' 
and det_type = 'INV' 
and det_date between @DateFrom and @DateTo
)hills

left outer join

	(
	select pod_stock_code, pod_unitcst 
	from pop_detail 
	inner join
		(
		select pod_stock_code podstockcode, max(pod_primary) podprimary 
		from pop_detail 
		where pod_stock_code LIKE '30MOR%' 
		group by pod_stock_code
		)z on pod_primary = podprimary 
	)supplierprice on hills.ProductCode = pod_stock_code

left outer join

	(
	select distinct orderlineid, d.discountname
	from SalesTime_scl..OrderLinesDiscountLines oldl
	inner join SalesTime_scl..Discounts d on d.id=oldl.discountid
	where oldl.stockcode LIKE '30MOR%'
	)salestime on hills.det_dimension3 = orderlineid

where TranDate between @DateFrom and @DateTo
order by 2,3,7