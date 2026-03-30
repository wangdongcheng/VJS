USE vjscl;

DECLARE @SalesRep NVARCHAR(100) = 'All';

-- replace getdate() with variable @Now to turn date back to 2025.
DECLARE @Now DATETIME = GETDATE();

IF OBJECT_ID('tempdb..#slplnldetail_thisyear') IS NOT NULL
DROP TABLE #slplnldetail_thisyear;

CREATE TABLE
	#slplnldetail_thisyear (
		detprimary FLOAT,
		det_header_key VARCHAR(20),
		detstock_code VARCHAR(25),
		sales_value FLOAT,
		det_type VARCHAR(3)
	)
INSERT INTO
	#slplnldetail_thisyear
SELECT
	det_primary,
	det_header_key,
	det_stock_code,
	CASE
		WHEN det_type = 'INV' THEN det_nett
		ELSE det_nett * -1
	END AS Sales_Value,
	det_type
FROM
	sl_pl_nl_detail
WHERE
	det_date >= DATEADD(yy, DATEDIFF(yy, 0, @Now), 0) --StartOfThisYr
	AND
	det_date <= @Now AND
	det_type IN ('INV', 'CRN');

IF OBJECT_ID('tempdb..#slplnldetail_lastyear') IS NOT NULL
DROP TABLE #slplnldetail_lastyear;

CREATE TABLE
	#slplnldetail_lastyear (
		detprimary FLOAT,
		det_header_key VARCHAR(20),
		detstock_code VARCHAR(25),
		sales_value FLOAT,
		det_type VARCHAR(3)
	)
INSERT INTO
	#slplnldetail_lastyear
SELECT
	det_primary,
	det_header_key,
	det_stock_code,
	CASE
		WHEN det_type = 'INV' THEN det_nett
		ELSE det_nett * -1
	END AS Sales_Value,
	det_type
FROM
	sl_pl_nl_detail
WHERE
	det_date >= DATEFROMPARTS(YEAR(@Now) -1, 1, 1)
	-- CASE WHEN YEAR(@Now) >= 2026 THEN 2025 ELSE YEAR(@Now) - 1 END,
	-- 1, 1)
	AND
	det_date <= DATEFROMPARTS(
		-- CASE WHEN YEAR(@Now) >= 2026 THEN 2025 ELSE YEAR(@Now) - 1 END,
		YEAR(@Now) - 1,
		MONTH(@Now),
		CASE
			WHEN DAY(@Now) > DAY(
				EOMONTH(
					DATEFROMPARTS(
						--    CASE WHEN YEAR(@Now) >= 2026 THEN 2025 ELSE YEAR(@Now) - 1 END,
						YEAR(@Now) - 1,
						MONTH(@Now),
						1
					)
				)
			) THEN DAY(
				EOMONTH(
					DATEFROMPARTS(
						--    CASE WHEN YEAR(@Now) >= 2026 THEN 2025 ELSE YEAR(@Now) - 1 END,
						YEAR(@Now) - 1,
						MONTH(@Now),
						1
					)
				)
			)
			ELSE DAY(@Now)
		END
	)
	--det_date >= select DATEADD(year,-1, DATEADD(yy, DATEDIFF(yy, 0, @Now), 0))--StartOfLastYr
	--AND det_date <= DATEADD(YEAR, -1, @Now) --LastYrToDate
	AND
	det_type IN ('INV', 'CRN');

IF OBJECT_ID('tempdb..#slplnldetail_halfyear') IS NOT NULL
DROP TABLE #slplnldetail_halfyear;

CREATE TABLE
	#slplnldetail_halfyear (
		detprimary FLOAT,
		det_header_key VARCHAR(20),
		detstock_code VARCHAR(25),
		sales_value FLOAT,
		det_type VARCHAR(3)
	)
INSERT INTO
	#slplnldetail_halfyear
SELECT
	det_primary,
	det_header_key,
	det_stock_code,
	CASE
		WHEN det_type = 'INV' THEN det_nett
		ELSE det_nett * -1
	END AS Sales_Value,
	det_type
FROM
	sl_pl_nl_detail
WHERE
	det_date >= --to amend in H2 once Bernardette gives go ahead - change ELSE '-01-01' to ELSE '-07-01' and replace = '2025-06-30' with the comment
	CAST(
		CAST(YEAR(@Now) AS VARCHAR) + CASE
			WHEN MONTH(@Now) <= 6 THEN '-01-01'
			ELSE '-07-01'
		END --ELSE '-01-01' END 
		AS DATE
	) --StartOfThisHalf
	AND
	det_type IN ('INV', 'CRN') AND
	det_date <= @Now;

--<= @Now; --<= '2025-06-30'; 
WITH
	TargetBrandMap AS (
    -- Mapped brands
    SELECT '30 HIL SP CAT' AS RawBrand, '30 HIL SP' AS ReportBrand
    UNION ALL
    SELECT '30 HIL SP DOG', '30 HIL SP'
    UNION ALL
    SELECT '30 HIL PD CAT', '30 HIL PD'
    UNION ALL
    SELECT '30 HIL PD DOG', '30 HIL PD'

    -- Paul, 30/03/2026, add NIV MIX+
	union all
	select '30 .NIV MEN',			'NIV MIX' union all
	select '30 .NIV BODY', 			'NIV MIX' union all
	select '30 .NIV CREAM', 		'NIV MIX' union all
	select '30 .NIV MINIS', 		'NIV MIX' union all
	select '30 .NIV STYLING', 		'NIV MIX' union all
	select '30 .NIV LIP CARE', 		'NIV MIX' union all
	select '30 .NIV GIFT PACK', 	'NIV MIX' union all
	select '30 .NIV HAND', 			'NIV MIX'


    -- Identity mapping for all other brands
    UNION ALL
    SELECT brand AS RawBrand, brand AS ReportBrand
    FROM SPOT.dbo.TGT_BRANDS
    WHERE brand NOT IN (
        '30 HIL SP CAT', '30 HIL SP DOG', 
        '30 HIL PD CAT', '30 HIL PD DOG',
		'30 .NIV MEN', 		
		'30 .NIV BODY', 		
		'30 .NIV CREAM', 	
		'30 .NIV MINIS', 	
		'30 .NIV STYLING', 	
		'30 .NIV LIP CARE', 	
		'30 .NIV GIFT PACK', 
		'30 .NIV HAND'
    )
	),
	BT AS (
		SELECT DISTINCT
			t.sales_rep AS salesrep,
			tbm.RawBrand,
			tbm.ReportBrand,
			b.BusinessType
		FROM
			SPOT.dbo.TGT_TARGETS t
			INNER JOIN TargetBrandMap tbm ON t.brand = tbm.ReportBrand
			INNER JOIN SPOT.dbo.TGT_BRANDS b ON b.brand = tbm.RawBrand
		WHERE
			RIGHT(qtr, 4) = YEAR(@Now)
	)
SELECT
	CurrHalfTgts.SalesRep,
	CurrHalfTgts.Brand,
	FinalSales.Sales_LYTD AS SalesToDate_LastYear,
	FinalSales.Sales_HYTD AS SalesToDate_For_Half,
	ISNULL(CurrHalfTgts.SalesTarget, 0) AS SalesTarget_For_Half,
	- ISNULL(CurrHalfTgts.SalesTarget, 0) + ISNULL(FinalSales.Sales_YTD, 0) AS DiffTargetvsActual_Half,
	ISNULL(StretchedTargets.StretchedTarget, 0) AS SalesTarget_Stretched,
	FinalSales.Sales_YTD AS SalesToDate_Cumulative,
	FinalSales.Sales_YTD - ISNULL(StretchedTargets.StretchedTarget, 0) AS DiffStretchedTargetvsActual,
	--ISNULL(CumuSlsTgts.SalesTarget_Cumul,0) as SalesTarget_Cumulative,
	CASE
		WHEN (
			DATEDIFF(DAY, @Now, CurrHalfTgts.HALF_DATE_TO) / 7
		) = 0 THEN 0
		ELSE (
			- ISNULL(CurrHalfTgts.SalesTarget, 0) + ISNULL(FinalSales.Sales_HYTD, 0)
		) / (
			DATEDIFF(DAY, @Now, CurrHalfTgts.HALF_DATE_TO) / 7
		) --WeeksLeft
	END AS AmtToSell_PerWeek,
	CASE
		WHEN - ISNULL(CurrHalfTgts.SalesTarget, 0) + ISNULL(FinalSales.Sales_HYTD, 0) > 0 THEN 0
		ELSE (
			(
				- ISNULL(CurrHalfTgts.SalesTarget, 0) + ISNULL(FinalSales.Sales_HYTD, 0)
			) * -1
		) / CAL.DaysLeft
	END AS AVGTSalesPerDay,
	CASE
		WHEN ISNULL(YearCAL.WorkDaysInYear, 0) = 0 THEN 0
		ELSE ROUND(
			ISNULL(StretchedTargets.StretchedTarget, 0) / YearCAL.WorkDaysInYear,
			2
		)
	END AS StretchedTarget_PerDay
FROM
	--sales targets for the current half
	(
		SELECT
			TGT_Inner.sales_rep AS salesrep,
			TGT_Inner.brand,
			TGT_Inner.[Target] AS SalesTarget,
			TGT_Half.HALF_DATE_FROM,
			TGT_Half.HALF_DATE_TO,
			TGT_Half.HALF_DESC
		FROM
			SPOT.[dbo].[TGT_TARGETS] TGT_Inner
			INNER JOIN SPOT.[dbo].[TGT_HALVES] TGT_Half ON TGT_Inner.QTR = TGT_Half.HALF_DESC
		WHERE
			TGT_Half.HALF_DATE_FROM = CAST(
				CAST(YEAR(@Now) AS VARCHAR) + CASE
					WHEN MONTH(@Now) <= 6 THEN '-01-01'
					ELSE '-07-01'
				END AS DATE
			) --Start of Current Half-Year
	) CurrHalfTgts
	INNER JOIN (
		SELECT
			COUNT(fullDate) + 1 AS DaysLeft
		FROM
			[Spot].[dbo].[CalendarTbl]
		WHERE
			holiday = 0 AND
			isBusDay = 1 AND
			fullDate BETWEEN @Now AND CAST(
				CASE
					WHEN MONTH(@Now) <= 6 THEN CAST(YEAR(@Now) AS VARCHAR) + '-06-30'
					ELSE CAST(YEAR(@Now) AS VARCHAR) + '-12-31'
				END AS DATE
			)
	) CAL ON 1 = 1
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
	LEFT OUTER JOIN (
		SELECT
			SalesSummary.SalesRep,
			SalesSummary.reportbrand AS SortKey,
			CAST(
				SUM(
					CASE
						WHEN Yr = 'SalesCurrentYear' THEN SalesSummary.Sales_Value
						ELSE 0
					END
				) AS DECIMAL(10, 2)
			) AS Sales_YTD,
			CAST(
				SUM(
					CASE
						WHEN Yr = 'SalesLastYear' THEN SalesSummary.Sales_Value
						ELSE 0
					END
				) AS DECIMAL(10, 2)
			) AS Sales_LYTD,
			CAST(
				SUM(
					CASE
						WHEN Yr = 'SalesHalfYear' THEN SalesSummary.Sales_Value
						ELSE 0
					END
				) AS DECIMAL(10, 2)
			) AS Sales_HYTD
		FROM
			(
				--Year To Date
				SELECT
					SalesRep,
					bt.reportbrand,
					'SalesCurrentYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_thisyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key AND
					st_user1 = bt.salesrep
				WHERE
					bt.BusinessType = 'Brand' --and st_user1 like CASE WHEN @SalesRep='All' THEN '%' ELSE @SalesRep END 
					AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesCurrentYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_thisyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key1 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'SubCategory' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesCurrentYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_thisyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.RawBrand = stk_sort_key3 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'Supplier' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesCurrentYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_thisyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key2 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'Type' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
					-- end year to date
				UNION ALL
				-- last year 
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesLastYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_lastyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'Brand' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesLastYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_lastyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key1 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'SubCategory' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesLastYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_lastyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key3 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'Supplier' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesLastYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_lastyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key2 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'Type' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				-- half year sales 
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesHalfYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_halfyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'Brand' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesHalfYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_halfyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key1 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'SubCategory' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesHalfYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_halfyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key3 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'Supplier' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
				UNION ALL
				SELECT
					SalesRep AS SalesRep,
					bt.reportbrand,
					'SalesHalfYear' AS Yr,
					Sales_Value
				FROM
					#slplnldetail_halfyear
					INNER JOIN stk_stock ON detstock_code = stkcode
					INNER JOIN stk_stock3 ON stkcode = stkcode3 /*added to exclude certain items from target sales*/
					INNER JOIN sl_transactions ON det_header_key = st_header_key
					INNER JOIN bt ON bt.rawbrand = stk_sort_key2 AND
					st_user1 = bt.salesrep
				WHERE
					BusinessType = 'Type' AND
					st_user1 LIKE CASE
						WHEN @SalesRep = 'All' THEN '%'
						ELSE @SalesRep
					END AND
					stk_usrflag7 = 0 /*12/10/2021 - certin products marked 1 with this flag need to be excluded*/
					-- end half year sales to date
			) SalesSummary
		GROUP BY
			SalesRep,
			SalesSummary.reportbrand
	) FinalSales ON FinalSales.SalesRep = CurrHalfTgts.salesrep AND
	FinalSales.SortKey = CurrHalfTgts.brand
	LEFT JOIN SPOT.dbo.TGT_STRETCHED StretchedTargets ON CurrHalfTgts.SalesRep = StretchedTargets.Sales_Rep AND
	CurrHalfTgts.Brand = StretchedTargets.Brand AND
	StretchedTargets.Year = YEAR(@Now)
	LEFT JOIN (
		SELECT
			COUNT(fullDate) AS WorkDaysInYear
		FROM
			[Spot].[dbo].[CalendarTbl]
		WHERE
			holiday = 0 AND
			isBusDay = 1 AND
			fullDate BETWEEN CAST(CAST(YEAR(@Now) AS VARCHAR) + '-01-01' AS DATE) AND CAST(CAST(YEAR(@Now) AS VARCHAR) + '-12-31' AS DATE)
	) YearCAL ON 1 = 1
WHERE
	CurrHalfTgts.SalesRep LIKE CASE
		WHEN @SalesRep = 'All' THEN '%'
		ELSE @SalesRep
	END
ORDER BY
	1