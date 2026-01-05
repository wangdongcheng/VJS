use vjscl;
DECLARE @SalesRep NVARCHAR(100) = 'All';
DECLARE @Now DATETIME = '2025-12-31';

IF OBJECT_ID('tempdb..#slplnldetail_thisyear') IS NOT NULL DROP TABLE #slplnldetail_thisyear;
create table #slplnldetail_thisyear (detprimary float,det_header_key varchar(20), detstock_code varchar(25),sales_value float,det_type varchar(3))

insert into #slplnldetail_thisyear
select det_primary, det_header_key, det_stock_code, case when det_type = 'INV' then det_nett else det_nett*-1 end as Sales_Value, det_type
from sl_pl_nl_detail
where det_date >= DATEADD(yy, DATEDIFF(yy, 0, @Now), 0) --StartOfThisYr
AND det_date <= @Now and det_type in ('INV','CRN');

IF OBJECT_ID('tempdb..#slplnldetail_lastyear') IS NOT NULL DROP TABLE #slplnldetail_lastyear;
create table #slplnldetail_lastyear (detprimary float,det_header_key varchar(20), detstock_code varchar(25),sales_value float,det_type varchar(3))

insert into #slplnldetail_lastyear
select det_primary, det_header_key, det_stock_code, case when det_type = 'INV' then det_nett else det_nett*-1 end as Sales_Value ,det_type
from sl_pl_nl_detail
where det_date >= DATEFROMPARTS(
                    CASE WHEN YEAR(@Now) >= 2026 THEN 2024 ELSE YEAR(@Now) - 1 END,
                    1, 1)
  AND det_date <= DATEFROMPARTS(
                    CASE WHEN YEAR(@Now) >= 2026 THEN 2024 ELSE YEAR(@Now) - 1 END,
                    MONTH(@Now),
                    CASE
                      WHEN DAY(@Now) >
                           DAY(EOMONTH(DATEFROMPARTS(
                               CASE WHEN YEAR(@Now) >= 2026 THEN 2024 ELSE YEAR(@Now) - 1 END,
                               MONTH(@Now), 1)))
                      THEN DAY(EOMONTH(DATEFROMPARTS(
                               CASE WHEN YEAR(@Now) >= 2026 THEN 2024 ELSE YEAR(@Now) - 1 END,
                               MONTH(@Now), 1)))
                      ELSE DAY(@Now)
                    END)
--det_date >= select DATEADD(year,-1, DATEADD(yy, DATEDIFF(yy, 0, @Now), 0))--StartOfLastYr
--AND det_date <= DATEADD(YEAR, -1, @Now) --LastYrToDate
and det_type in ('INV','CRN');

if OBJECT_ID('tempdb..#slplnldetail_halfyear') IS NOT NULL DROP TABLE #slplnldetail_halfyear;
create table #slplnldetail_halfyear (detprimary float,det_header_key varchar(20), detstock_code varchar(25),sales_value float,det_type varchar(3))

insert into #slplnldetail_halfyear
select det_primary, det_header_key, det_stock_code, case when det_type = 'INV' then det_nett else det_nett*-1 end as Sales_Value,det_type
from sl_pl_nl_detail
where det_date >= --to amend in H2 once Bernardette gives go ahead - change ELSE '-01-01' to ELSE '-07-01' and replace = '2025-06-30' with the comment
CAST(
        CAST(YEAR(@Now) AS VARCHAR) + 
        CASE WHEN MONTH(@Now) <= 6 THEN '-01-01' ELSE '-07-01' END --ELSE '-01-01' END 
        AS DATE
    ) --StartOfThisHalf
AND det_type in ('INV','CRN') AND det_date <= '2025-12-31'; --<= @Now; --<= '2025-06-30'; 

WITH TargetBrandMap AS (
    -- Mapped brands
    SELECT '30 HIL SP CAT' AS RawBrand, '30 HIL SP' AS ReportBrand
    UNION ALL
    SELECT '30 HIL SP DOG', '30 HIL SP'
    UNION ALL
    SELECT '30 HIL PD CAT', '30 HIL PD'
    UNION ALL
    SELECT '30 HIL PD DOG', '30 HIL PD'
    
    -- Identity mapping for all other brands
    UNION ALL
    SELECT brand AS RawBrand, brand AS ReportBrand
    FROM SPOT.dbo.TGT_BRANDS
    WHERE brand NOT IN (
        '30 HIL SP CAT', '30 HIL SP DOG', 
        '30 HIL PD CAT', '30 HIL PD DOG'
    )
),

BT AS (
    SELECT DISTINCT 
        t.sales_rep AS salesrep,
        tbm.RawBrand,
        tbm.ReportBrand,
        b.BusinessType
    FROM SPOT.dbo.TGT_TARGETS t
    INNER JOIN TargetBrandMap tbm ON t.brand = tbm.ReportBrand
    INNER JOIN SPOT.dbo.TGT_BRANDS b ON b.brand = tbm.RawBrand
    WHERE RIGHT(qtr, 4) = YEAR(@Now)
)


SELECT
CurrHalfTgts.SalesRep,

CurrHalfTgts.Brand,

FinalSales.Sales_LYTD as SalesToDate_LastYear,

FinalSales.Sales_HYTD as SalesToDate_For_Half,

ISNULL(CurrHalfTgts.SalesTarget,0) as SalesTarget_For_Half,

-ISNULL(CurrHalfTgts.SalesTarget,0)+ISNULL(FinalSales.Sales_YTD,0) as DiffTargetvsActual_Half,

ISNULL(StretchedTargets.StretchedTarget, 0) AS SalesTarget_Stretched,

FinalSales.Sales_YTD as SalesToDate_Cumulative,

FinalSales.Sales_YTD - ISNULL(StretchedTargets.StretchedTarget, 0) AS DiffStretchedTargetvsActual,

--ISNULL(CumuSlsTgts.SalesTarget_Cumul,0) as SalesTarget_Cumulative,

CASE
	WHEN (DATEDIFF(day, @Now, CurrHalfTgts.HALF_DATE_TO) / 7) = 0 THEN 0 
	ELSE
	(-ISNULL(CurrHalfTgts.SalesTarget,0)+ISNULL(FinalSales.Sales_HYTD, 0)) / 
	(DATEDIFF(day, @Now, CurrHalfTgts.HALF_DATE_TO) / 7) --WeeksLeft
END AS AmtToSell_PerWeek,

CASE WHEN -ISNULL(CurrHalfTgts.SalesTarget,0)+ISNULL(FinalSales.Sales_HYTD,0) > 0 THEN 0 
	ELSE ((-ISNULL(CurrHalfTgts.SalesTarget,0)+ISNULL(FinalSales.Sales_HYTD,0))*-1)/CAL.DaysLeft  END AS AVGTSalesPerDay,

CASE 
	WHEN ISNULL(YearCAL.WorkDaysInYear, 0) = 0 THEN 0
	ELSE ROUND(ISNULL(StretchedTargets.StretchedTarget, 0) / YearCAL.WorkDaysInYear, 2)
END AS StretchedTarget_PerDay

FROM
--sales targets for the current half
(select TGT_Inner.sales_rep  as salesrep, TGT_Inner.brand, TGT_Inner.[Target] as SalesTarget, TGT_Half.HALF_DATE_FROM, TGT_Half.HALF_DATE_TO, TGT_Half.HALF_DESC
from SPOT.[dbo].[TGT_TARGETS] TGT_Inner
inner join SPOT.[dbo].[TGT_HALVES] TGT_Half on TGT_Inner.QTR=TGT_Half.HALF_DESC
where TGT_Half.HALF_DATE_FROM = CAST(
        CAST(YEAR(@Now) AS VARCHAR) + 
        CASE WHEN MONTH(@Now) <= 6 THEN '-01-01' ELSE '-07-01' END 
        AS DATE
		)--Start of Current Half-Year
) CurrHalfTgts

INNER JOIN
	(SELECT COUNT(fullDate)+1 as DaysLeft
	FROM [Spot].[dbo].[CalendarTbl]
	WHERE holiday = 0 and isBusDay = 1 and fullDate between @Now and CAST(
            CASE 
                WHEN MONTH(@Now) <= 6 THEN CAST(YEAR(@Now) AS VARCHAR) + '-06-30'
                ELSE CAST(YEAR(@Now) AS VARCHAR) + '-12-31'
            END AS DATE
        )) CAL
	ON 1=1

--LEFT OUTER JOIN 
----Cumulative Sales Target for the Year
--(select TGT_InnerCumul.SALES_REP  as salesrep, TGT_InnerCumul.BRAND, sum(TGT_InnerCumul.[TARGET]) as SalesTarget_Cumul
--from SPOT.[dbo].[TGT_TARGETS] TGT_InnerCumul
--inner join SPOT.[dbo].[TGT_HALVES] TGT_Cumul_Half on TGT_InnerCumul.QTR=TGT_Cumul_Half.HALF_DESC
--where HALF_DATE_FROM <= CAST(
--        CAST(YEAR(@Now) AS VARCHAR) + 
--        CASE WHEN MONTH(@Now) <= 6 THEN '-01-01' ELSE '-07-01' END 
--        AS DATE
--    )--StartOfThisHalf
--AND RIGHT (QTR,4) = YEAR(@Now)
--group by sales_rep, brand) CumuSlsTgts
--on CurrHalfTgts.SalesRep=CumuSlsTgts.salesrep and CurrHalfTgts.brand = CumuSlsTgts.brand 

LEFT OUTER JOIN
(

select SalesSummary.SalesRep, SalesSummary.reportbrand as SortKey, 
cast(sum(case when Yr = 'SalesCurrentYear' then SalesSummary.Sales_Value else 0 end) as decimal(10,2) ) as Sales_YTD,
cast(sum(case when Yr = 'SalesLastYear' then SalesSummary.Sales_Value else 0 end) as decimal(10,2) ) as Sales_LYTD,
cast(sum(case when Yr = 'SalesHalfYear' then SalesSummary.Sales_Value else 0 end) as decimal(10,2) ) as Sales_HYTD
from 

	(

 --Year To Date

	select 
	SalesRep,
	bt.reportbrand,
	'SalesCurrentYear' as Yr,
	Sales_Value
	from #slplnldetail_thisyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key and st_user1= bt.salesrep
	where 
	bt.BusinessType = 'Brand' --and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
	
		union all

	select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesCurrentYear' as Yr,
	Sales_Value
	from #slplnldetail_thisyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key1 and st_user1= bt.salesrep
	where
	BusinessType = 'SubCategory' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

		union all 

	select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesCurrentYear' as Yr,
	Sales_Value
	from #slplnldetail_thisyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.RawBrand = stk_sort_key3 and st_user1= bt.salesrep
	where  	
	BusinessType = 'Supplier' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

		union all

	select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesCurrentYear' as Yr,
	Sales_Value
	from #slplnldetail_thisyear  
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key2 and st_user1= bt.salesrep
	where  	
	BusinessType = 'Type' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

-- end year to date

		union all

-- last year 

	select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesLastYear' as Yr,
	Sales_Value
	from #slplnldetail_lastyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key and st_user1= bt.salesrep
	where 
	BusinessType = 'Brand' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

		union all

	select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesLastYear' as Yr,
	Sales_Value
	from #slplnldetail_lastyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key1 and st_user1= bt.salesrep
	where
	BusinessType = 'SubCategory' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

		union all

	select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesLastYear' as Yr,
	Sales_Value
	from #slplnldetail_lastyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key3 and st_user1= bt.salesrep
	where  	
	BusinessType = 'Supplier' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
	
	union all

	select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesLastYear' as Yr,
	Sales_Value
	from #slplnldetail_lastyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key2 and st_user1= bt.salesrep
	where  	
	BusinessType = 'Type' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

UNION ALL

-- half year sales 

	select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesHalfYear' as Yr,
	Sales_Value
	from #slplnldetail_halfyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key and st_user1= bt.salesrep
	where 
	BusinessType = 'Brand' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
	
union all

select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesHalfYear' as Yr,
	Sales_Value
	from #slplnldetail_halfyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key1 and st_user1= bt.salesrep
	where 
	BusinessType = 'SubCategory' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

union all

select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesHalfYear' as Yr,
	Sales_Value
	from #slplnldetail_halfyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key3 and st_user1= bt.salesrep
	where 
	BusinessType = 'Supplier' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

union all

select 
	SalesRep as SalesRep,
	bt.reportbrand,
	'SalesHalfYear' as Yr,
	Sales_Value
	from #slplnldetail_halfyear 
	inner join stk_stock on detstock_code = stkcode
	inner join stk_stock3 on stkcode = stkcode3 /*added to exclude certain items from target sales*/
	inner join sl_transactions on det_header_key = st_header_key
	inner join bt on bt.rawbrand = stk_sort_key2 and st_user1= bt.salesrep
	where 
	BusinessType = 'Type' and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
	and stk_usrflag7 = 0  /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/

-- end half year sales to date
	)SalesSummary

	group by SalesRep, SalesSummary.reportbrand

)FinalSales
on FinalSales.SalesRep=CurrHalfTgts.salesrep and FinalSales.SortKey = CurrHalfTgts.brand

LEFT JOIN SPOT.dbo.TGT_STRETCHED StretchedTargets
    ON CurrHalfTgts.SalesRep = StretchedTargets.Sales_Rep
   AND CurrHalfTgts.Brand = StretchedTargets.Brand
   AND StretchedTargets.Year = YEAR(@Now)

LEFT JOIN (
	SELECT COUNT(fullDate) AS WorkDaysInYear
	FROM [Spot].[dbo].[CalendarTbl]
	WHERE holiday = 0 
	  AND isBusDay = 1
	  AND fullDate BETWEEN 
		CAST(CAST(YEAR(@Now) AS VARCHAR) + '-01-01' AS DATE) AND 
		CAST(CAST(YEAR(@Now) AS VARCHAR) + '-12-31' AS DATE)
) YearCAL ON 1 = 1

where CurrHalfTgts.SalesRep like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 

order by 1