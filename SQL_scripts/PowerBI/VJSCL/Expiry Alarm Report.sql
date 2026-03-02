DECLARE @Division TABLE (VALUE VARCHAR(100));
declare @Executive TABLE (VALUE VARCHAR(100));
declare @CategManager TABLE (VALUE VARCHAR(100));


INSERT INTO @Division(VALUE)
SELECT DISTINCT STK_USRCHAR2
FROM STK_STOCK3
WHERE STK_USRFLAG3 = 0 AND STK_USRCHAR2 != '';

insert into @Executive(VALUE)
SELECT DISTINCT
      [Executive Number]+' | '+[Full Name] as [Exec]
  FROM [Spot].[dbo].[Executives];

insert into @CategManager(VALUE)
SELECT DISTINCT
      [Category Number]+' | '+[Full Name] as [CategManager]
  FROM [Spot].[dbo].[CategoryManagers];


SELECT
S3.STK_USRCHAR2 AS [Division],
S3.STK_USRCHAR16 AS [Exec],
S3.STK_USRCHAR18 AS [CategManager],
S.STKCODE AS [Stock_Code],
S.STKNAME AS [Stock_Name],
S.STK_SORT_KEY AS [Brand],
sl2.LOC_CODE2 [Lot_No],
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
INNER JOIN [Spot].[dbo].[CategoryManagers] C ON S3.STK_USRCHAR18=C.[Category Number]
LEFT OUTER JOIN dbo.STK_LOCATION SL ON S.STKCODE = SL.LOC_STOCK_CODE
LEFT OUTER JOIN dbo.STK_LOCATION2 SL2 ON SL.LOC_PRIMARY = SL2.LOC_PRIMARY2
LEFT JOIN (
	select DET_STOCK_CODE, sum(case when det_type = 'CRN' then det_quantity*-1 else DET_QUANTITY end)/4 as [4M_AVG] 
	from SL_PL_NL_DETAIL
	where det_date between cast(getdate()-122 as date) and cast(getdate()-1 as date) and det_type in ('INV','CRN') AND DET_LEDGER = 'SL'
	group by DET_STOCK_CODE) SLS
 ON SLS.DET_STOCK_CODE=S.STKCODE
WHERE sl2.LOC_SOPCHECK = 0 
AND loc_physical > 0
AND datediff (dd, dbo.dateonly(getdate()), loc_userdate1 ) <= S.STK_EC_KILOS AND S3.STK_USRFLAG3=0
AND S3.STK_USRCHAR2 IN (SELECT VALUE FROM @Division) AND (S3.STK_USRCHAR16+' | '+EX.[Full Name]) IN (SELECT VALUE FROM @Executive) AND (S3.STK_USRCHAR18+' | '+C.[Full Name]) IN (SELECT VALUE FROM @CategManager)