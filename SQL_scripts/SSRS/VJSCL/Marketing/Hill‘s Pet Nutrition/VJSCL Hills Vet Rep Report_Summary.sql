WITH WorkingDaysCTE AS (
    SELECT 
        CAST(WorkingDays AS FLOAT) / CAST(WorkedDays AS FLOAT) AS WorkedDaysRatio
    FROM 
        (SELECT COUNT(fulldate) AS WorkingDays
         FROM [Spot].[dbo].[calendarTbl]
         WHERE isbusday = 1 AND YEAR(fulldate) = YEAR(GETDATE()) AND holiday = 0) AS TotalWorkingDays,
        (SELECT COUNT(fulldate) AS WorkedDays
         FROM [Spot].[dbo].[calendarTbl]
         WHERE isbusday = 1 AND YEAR(fulldate) =  YEAR(GETDATE()) AND holiday = 0 AND 
               fulldate BETWEEN DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1) AND GETDATE()) AS TotalWorkedDaysTillDate
)
SELECT 
	CU_USRCHAR15 as HillsClass,
	cuname AS CustomerDescription,
    STK_SORT_KEY AS StockBrand,
	ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(DATEADD(YEAR, -2, GETDATE()))
                   THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                   ELSE 0 END), 0) AS 'LY-2_Sales',
    ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(DATEADD(YEAR, -1, GETDATE()))
                   THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                   ELSE 0 END), 0) AS LY_Sales,
    ROUND(SUM(CASE WHEN det_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1) AND DATEADD(YEAR, -1, GETDATE())
                   THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                   ELSE 0 END), 0) AS LYTD_Sales,
    ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(GETDATE())
                   THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                   ELSE 0 END), 0) AS YTD_Sales,
	ROUND(ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(GETDATE())
                   THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                   ELSE 0 END), 0)
	*
	wd.WorkedDaysRatio,2) as 'FCST Y Sales',
    ROUND(CASE 
        WHEN 
            ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(GETDATE())
                           THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                           ELSE 0 END), 0) = 0 
        THEN 0 
        ELSE
            ((ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(GETDATE())
                            THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                            ELSE 0 END), 0)
            -
            ROUND(SUM(CASE WHEN det_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1) AND DATEADD(YEAR, -1, GETDATE())
                           THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                           ELSE 0 END), 0))
            /
            NULLIF(ROUND(SUM(CASE WHEN det_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1) AND DATEADD(YEAR, -1, GETDATE())
                                  THEN CASE WHEN det_type = 'CRN' THEN det_nett * -1 ELSE det_nett END 
                                  ELSE 0 END), 0), 0))
    END,2) AS GrowthPercentageSales,
	wd.WorkedDaysRatio,
	ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(DATEADD(YEAR, -2, GETDATE()))
                   THEN CASE WHEN det_type = 'CRN' THEN (DET_QUANTITY * -1) ELSE DET_QUANTITY END 
                   ELSE 0 END), 0) AS 'LY-2_QTY',
    ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(DATEADD(YEAR, -1, GETDATE()))
                   THEN CASE WHEN det_type = 'CRN' THEN (DET_QUANTITY * -1) ELSE DET_QUANTITY END 
                   ELSE 0 END), 0) AS LY_QTY,
    ROUND(SUM(CASE WHEN det_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1) AND DATEADD(YEAR, -1, GETDATE())
                   THEN CASE WHEN det_type = 'CRN' THEN (DET_QUANTITY * -1) ELSE DET_QUANTITY END 
                   ELSE 0 END), 0) AS LYTD_QTY,
    ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(GETDATE())
                   THEN CASE WHEN det_type = 'CRN' THEN (DET_QUANTITY * -1) ELSE DET_QUANTITY END 
                   ELSE 0 END), 0) AS YTD_QTY,
	ROUND(ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(GETDATE())
                   THEN CASE WHEN det_type = 'CRN' THEN (DET_QUANTITY * -1) ELSE DET_QUANTITY END 
                   ELSE 0 END), 0)
	*
	wd.WorkedDaysRatio,2) as 'FCST Y QTY',
	ROUND(CASE 
        WHEN 
            ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(GETDATE())
                           THEN CASE WHEN det_type = 'CRN' THEN DET_QUANTITY * -1 ELSE DET_QUANTITY END 
                           ELSE 0 END), 0) = 0 
        THEN 0 
        ELSE
            ((ROUND(SUM(CASE WHEN YEAR(det_date) = YEAR(GETDATE())
                            THEN CASE WHEN det_type = 'CRN' THEN DET_QUANTITY * -1 ELSE DET_QUANTITY END 
                            ELSE 0 END), 0)
            -
            ROUND(SUM(CASE WHEN det_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1) AND DATEADD(YEAR, -1, GETDATE())
                           THEN CASE WHEN det_type = 'CRN' THEN DET_QUANTITY * -1 ELSE DET_QUANTITY END 
                           ELSE 0 END), 0))
            /
            NULLIF(ROUND(SUM(CASE WHEN det_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1) AND DATEADD(YEAR, -1, GETDATE())
                                  THEN CASE WHEN det_type = 'CRN' THEN DET_QUANTITY * -1 ELSE DET_QUANTITY END 
                                  ELSE 0 END), 0), 0))
    END,2) AS GrowthPercentageQty
FROM SL_PL_NL_DETAIL d
INNER JOIN STK_STOCK s ON d.DET_STOCK_CODE = s.stkcode
INNER JOIN SL_ACCOUNTS a ON d.DET_ACCOUNT = a.cucode
INNER JOIN SL_ACCOUNTS2 a2 on d.DET_ACCOUNT = a2.CUCODE2
CROSS JOIN WorkingDaysCTE wd
WHERE a2.CU_USRCHAR14 = 'VET' and s.STK_SORT_KEY = '30 HILLS PET'-- AND CUNAME IN (@CustomerName)
GROUP BY cuuser2, cusort, a2.CU_USRCHAR15, cuname, stk_sort_key, wd.WorkedDaysRatio
ORDER BY StockBrand