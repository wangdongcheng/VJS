declare @DateFrom datetime = '1/1/2025',
        @DateTo DATETIME = '8/31/2025';

print @DateFrom;
print CONCAT(year(@DateFrom),'-',month(@DateFrom),'-',day(@DateFrom));
print @DateTo;
PRINT CONCAT(year(@DateTo),'-',month(@DateTo),'-',day(@DateTo));

SELECT
	'Staff Feeding Scheme' AS 'Activity',
    det_date,
    MONTH(DET_DATE) AS [Month],
    DET_HEADER_REF AS InvoiceNumber,
    DET_ACCOUNT AS CustCode,
	STK_SUPSTKCDE1 AS Code,
    STKCODE AS VJStockCode,
    STKNAME AS Description,
    DET_QUANTITY AS Qty,
	DET_UNIT_PRICE AS OriginalInvUnitPrice,
	DET_UNIT_PRICE-DET_L_DISCOUNT-DET_T_DISCOUNT AS DiscountedInvPrice,
	(DET_L_DISCOUNT/nullif((DET_QUANTITY * DET_UNIT_PRICE),0))*100 AS '% Discount',
	DET_COSTPRICE/0.865 AS SupplierPricePerUnit
FROM SL_PL_NL_DETAIL
INNER JOIN STK_STOCK ON STKCODE = DET_STOCK_CODE
INNER JOIN STK_STOCK_2 S2 ON DET_STOCK_CODE=S2.STKCODE2
WHERE STK_SORT_KEY3 = '30 HILLS PET NUTRI.' AND DET_ORIGIN = 'SO' AND DET_TYPE = 'INV' 
AND DET_DATE BETWEEN CONCAT(year(@DateFrom),'-',month(@DateFrom),'-',day(@DateFrom))
AND CONCAT(year(@DateTo),'-',month(@DateTo),'-',day(@DateTo))
	AND DET_ACCOUNT = '30VCS001'

select top 1 CONCAT(year(@DateFrom),'-',month(@DateFrom),'-',day(@DateFrom),'and',year(@DateTo),'-',month(@DateTo),'-',day(@DateTo)) as 'Date Range';    

select STKCODE as 'Stock Code',
stkname as 'Stock Name',
stk_p_weight as 'Duty' 
from stk_stock 
where stk_p_weight != 0 and STKCODE like '30euk_%' order by stkcode;


select top 100 cu_usrflag3,* from sl_accounts2 where cu_usrflag3 = 0;


select distinct cuuser1 from sl_accounts order by cuuser1;


select top 100 
DOH_VAT_CODE1,doh_vat_net1,doh_vat_value1,
DOH_VAT_CODE2,doh_vat_net2,doh_vat_value2,
DOH_VAT_CODE3,doh_vat_net3,doh_vat_value3,
DOH_VAT_CODE4,doh_vat_net4,doh_vat_value4,
DOH_VAT_CODE5,doh_vat_net5,doh_vat_value5,
* from doc_order_header 
where 
DOH_DOC_NUMBER = '392962'
--DOH_VAT_CODE3 != '';


select * from SYS_VATCONTROL

