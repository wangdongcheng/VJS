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
