use VJSCL;

DECLARE @stock NVARCHAR(50);
set @stock = '50ABBABBCATH14GX50';


-- select 
-- *
-- from dbo.STK_STOCK
-- where STKCODE like @stock
-- -- where STK_RTP_FLAG = 0
-- -- where STK_S_WEIGHT != 0
-- ;

-- 50ABBABBCATH14GX50,50ABBABBCATH14GX50T
select stk.* , stk2.*, stk3.*, stk4.*
from stk_stock as stk
    LEFT JOIN STK_STOCK_2 as stk2 ON stk.STKCODE = stk2.STKCODE2
    LEFT JOIN STK_STOCK3 as stk3 on stk.STKCODE = stk3.STKCODE3
    LEFT JOIN STK_STOCK4 as stk4 on stk.STKCODE = stk4.STKCODE4
where stkcode like @stock
;



-- SELECT *
-- FROM SL_ADDRESSES
-- WHERE AD_ACC_CODE LIKE '508till001';


select top(1000)CU_PRICE_KEY
from SL_ACCOUNTS;

select top(1000) 
STK_SANALYSIS1,
STK_SANALYSIS2,
STK_SANALYSIS3,
STK_SANALYSIS4,
STK_SANALYSIS5,
STK_SANALYSIS6,
STK_SANALYSIS7,
STK_SANALYSIS8,
STK_SANALYSIS9,
STK_SANALYSIS10,
* 
from vjscl.dbo.STK_STOCK_2

select sucode,su_import_code
from vjscl.dbo.pl_accounts
-- where sucode = '30aca001'


use VJSCL;
SELECT 
AD_CODE,
*
from  SL_ADDRESSES
where ad_acc_code like '30%'
order by AD_ACC_CODE

use vjscl;
select STKCODE2,stk_supstkcde1
from STK_STOCK_2
WHERE STKCODE2 in (
'30VAM_001'
,'30VAM_017PR'
,'30VAM_036'
,'30VAM_037PR'
,'30VAM_045NL'

,'30FIO_568375UX'
,'30FIO_568375UXMH'
,'30FIO_56904570T'
,'30FIO_509218UX'
,'30FIO_567907UX'
,'30FIO_569113UX'
,'30FIO_568929UX'
,'30FIO_569113UXMH'
,'30FIO_567907UXMH'
,'30FIO_509218UXMH'
,'30FIO_567907UXT'
,'30FIO_568373UX'
,'30FIO_568373UXMH'

,'30SEP_225034'
,'30SEP_225024'
,'30SEP_5051'

)



SELECT
S3.STK_USRCHAR2 AS [Division],
S3.STK_USRCHAR16 AS [Exec],
S.STKCODE AS [Stock_Code],
S.STKNAME AS [Stock_Name],
S.STK_SORT_KEY AS [Brand],
LOC_CODE2 [Lot_No],
CAST(SL.LOC_PHYSICAL AS DECIMAL(10,0)) AS [Physical],
SL2.LOC_USERDATE1 AS [Expiry_Date],
CONVERT(VARCHAR(10), GETDATE(), 103) AS [Today_Date],
S.STK_EC_KILOS AS Expiry_Days_Alarm,
CASE WHEN DATEDIFF(day, dbo.dateonly(getdate()), SL2.LOC_USERDATE1)<=0 THEN 'Expired!' ELSE DATEDIFF(day, dbo.dateonly(getdate()), SL2.LOC_USERDATE1) END AS Days_to_Expiry,
CAST(SLS.[4M_AVG] AS DECIMAL (18,2)) AS 'AVG_4M',
CASE WHEN CAST(SLS.[4M_AVG] AS DECIMAL (18,2)) = 0 THEN 0 ELSE GETDATE()+(CAST(SL.LOC_PHYSICAL AS DECIMAL(10,0))/CAST(SLS.[4M_AVG] AS DECIMAL (18,2)))*30 END AS 'Calculated End Date'

FROM
dbo.STK_STOCK S
INNER JOIN STK_STOCK3 S3 ON S.STKCOde=S3.STKCODE3
INNER JOIN [Spot].[dbo].[Executives] EX ON S3.STK_USRCHAR16=EX.[Executive Number]
LEFT OUTER JOIN dbo.STK_LOCATION SL ON S.STKCODE = SL.LOC_STOCK_CODE
LEFT OUTER JOIN dbo.STK_LOCATION2 SL2 ON SL.LOC_PRIMARY = SL2.LOC_PRIMARY2
LEFT JOIN (
	select DET_STOCK_CODE, sum(case when det_type = 'CRN' then det_quantity*-1 else DET_QUANTITY end)/4 as [4M_AVG] 
	from SL_PL_NL_DETAIL
	where det_date between cast(getdate()-122 as date) and cast(getdate()-1 as date) and det_type in ('INV','CRN') AND DET_LEDGER = 'SL'
	group by DET_STOCK_CODE) SLS
 ON SLS.DET_STOCK_CODE=S.STKCODE

WHERE LOC_SOPCHECK = 0 
AND loc_physical > 0
AND datediff (dd, dbo.dateonly(getdate()), loc_userdate1 ) <= S.STK_EC_KILOS AND S3.STK_USRFLAG3=0
-- AND S3.STK_USRCHAR2 IN (@Division) AND (S3.STK_USRCHAR16+' | '+EX.[Full Name]) IN (@Executive)


select *
from svbeauty.dbo.sys_lookup_text
-- where txt_origin = 'delroute';



declare @p1 int
set @p1=27185
exec sp_prepexec @p1 output,N'@P1 varchar(25),@P2 varchar(25),@P3 varchar(100)',N'select Movement_Primary,Origin,Tran_Date ,Tran_Year ,Period, Year_Label, Year_No ,case Exclude_From_Weighted_Value when 0 then 0 else 1 end,Stock_Code,Reference,Order_Ref,Order_Detail_Link,Serial_Number,Serialised,Cost_Header,Cost_Centre,Detail,Price_Adjustment_Flag,Analysis,Customer_or_Supplier_Code,Tran_Type ,Direction,case Direction when ''I'' then Quantity else Quantity*-1 end  signedQuantity,case Direction when ''I'' then Total_Quantity else Total_Quantity*-1 end signedTotalQuantity,case Quantity when 0 then 0 else Cost_Price end CostPrice,Weighted_Value Weighted_Value,case Direction when ''I'' then Cost_Value else Cost_Value*-1 end CostValue
from (Select Order_Header_Link,Movement_Primary,Stock_Code,Tran_Date ,Tran_Year,Period,Period_Sort, Year_Label, Year_No, Year_Link, case Exclude_From_Weighted_Value when 0 then 0 else 1 end Exclude_From_Weighted_Value,Reference,Order_Ref,Order_Detail_Link,Origin,Serial_Number,Serialised,Cost_Header,Cost_Centre,Detail,Price_Adjustment_Flag,Sub_Analysis,Analysis,Direction,Quantity,Total_Quantity,Cost_Price,Weighted_Value , Cost_Value, Base2_Cost_Price,Base2_Cost_Value,Order_Account,Delivery_Account,Invoice_Account,Customer_or_Supplier_Code,Tran_Type from VJSCL.dbo.AA_STK_MOVEMENT_VIEW)  as  STK_TRANSACTIONS
where Stock_Code=@P1 and Sub_Analysis=@P2 and Order_Header_Link=''S762301'' and Sub_Analysis = @P3
order by Movement_Primary','30SCH_100601IGO','WHK260825B','WHK260825B'
select @p1

select Movement_Primary,Origin,Tran_Date ,Tran_Year ,Period, Year_Label, Year_No ,case Exclude_From_Weighted_Value when 0 then 0 else 1 end,Stock_Code,Reference,Order_Ref,Order_Detail_Link,Serial_Number,Serialised,Cost_Header,Cost_Centre,Detail,Price_Adjustment_Flag,Analysis,Customer_or_Supplier_Code,Tran_Type ,Direction,case Direction when ''I'' then Quantity else Quantity*-1 end  signedQuantity,case Direction when ''I'' then Total_Quantity else Total_Quantity*-1 end signedTotalQuantity,case Quantity when 0 then 0 else Cost_Price end CostPrice,Weighted_Value Weighted_Value,case Direction when ''I'' then Cost_Value else Cost_Value*-1 end CostValue
from (Select Order_Header_Link,Movement_Primary,Stock_Code,Tran_Date ,Tran_Year,Period,Period_Sort, Year_Label, Year_No, Year_Link, case Exclude_From_Weighted_Value when 0 then 0 else 1 end Exclude_From_Weighted_Value,Reference,Order_Ref,Order_Detail_Link,Origin,Serial_Number,Serialised,Cost_Header,Cost_Centre,Detail,Price_Adjustment_Flag,Sub_Analysis,Analysis,Direction,Quantity,Total_Quantity,Cost_Price,Weighted_Value , Cost_Value, Base2_Cost_Price,Base2_Cost_Value,Order_Account,Delivery_Account,Invoice_Account,Customer_or_Supplier_Code,Tran_Type from VJSCL.dbo.AA_STK_MOVEMENT_VIEW)  as  STK_TRANSACTIONS
where Stock_Code=@P1 and Sub_Analysis=@P2 and Order_Header_Link=''S762301'' and Sub_Analysis = @P3
order by Movement_Primary


select * from vjscl.dbo.STK_STOCK_2
where stkcode2 like '30app%'