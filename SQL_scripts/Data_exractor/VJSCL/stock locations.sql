SELECT *
  FROM [VJSCL].[dbo].[STK_LOCATION]
--   where LOC_STOCK_CODE = '308IN1_02250UX'
-- --   where loc_code like 'w__'
-- --   order by loc_code
-- --   where LOC_STOCK_CODE = '308IN1_02250UX' 
-- --   and loc_name <> 'In Warehouse';




-- SELECT DISTINCT
--     S.LOC_STOCK_CODE,
--     st.stkname,
--     STUFF
--     (
--         (
--             SELECT ', ' + CAST(S2.LOC_USERSORT1 AS varchar(max))
--             FROM [VJSCL].[dbo].[STK_LOCATION] AS S2
--             WHERE S2.LOC_STOCK_CODE = S.LOC_STOCK_CODE
          
--             ORDER BY S2.LOC_USERSORT1
--             FOR XML PATH(''), TYPE
--         ).value('.', 'varchar(max)'),
--         1,
--         2,
--         ''
--     ) AS LOC_CODES
-- FROM [VJSCL].[dbo].[STK_LOCATION] AS S
-- inner join stk_stock st on s.LOC_STOCK_CODE = st.STKCODE
-- WHERE S.LOC_NAME <> 'In Warehouse'
-- and st.STK_DO_NOT_USE = 0
-- ORDER BY S.LOC_STOCK_CODE;


SELECT
    LOC_STOCK_CODE,
    MAX(CASE WHEN LOC_USERSORT1 = 'W01' THEN 'Y' ELSE '' END) AS [W01],
    MAX(CASE WHEN LOC_USERSORT1 = 'W02' THEN 'Y' ELSE '' END) AS [W02],
    MAX(CASE WHEN LOC_USERSORT1 = 'W03' THEN 'Y' ELSE '' END) AS [W03],
    MAX(CASE WHEN LOC_USERSORT1 = 'W04' THEN 'Y' ELSE '' END) AS [W04],
    MAX(CASE WHEN LOC_USERSORT1 = 'W05' THEN 'Y' ELSE '' END) AS [W05],
    MAX(CASE WHEN LOC_USERSORT1 = 'W06' THEN 'Y' ELSE '' END) AS [W06],
    MAX(CASE WHEN LOC_USERSORT1 = 'W07' THEN 'Y' ELSE '' END) AS [W07],
    MAX(CASE WHEN LOC_USERSORT1 = 'W08' THEN 'Y' ELSE '' END) AS [W08],
    MAX(CASE WHEN LOC_USERSORT1 = 'W09' THEN 'Y' ELSE '' END) AS [W09],
    MAX(CASE WHEN LOC_USERSORT1 = 'W10' THEN 'Y' ELSE '' END) AS [W10],
    MAX(CASE WHEN LOC_USERSORT1 = 'W11' THEN 'Y' ELSE '' END) AS [W11],
    MAX(CASE WHEN LOC_USERSORT1 = 'W12' THEN 'Y' ELSE '' END) AS [W12],
    MAX(CASE WHEN LOC_USERSORT1 = 'W13' THEN 'Y' ELSE '' END) AS [W13],
    MAX(CASE WHEN LOC_USERSORT1 = 'W14' THEN 'Y' ELSE '' END) AS [W14],
    MAX(CASE WHEN LOC_USERSORT1 = 'W15' THEN 'Y' ELSE '' END) AS [W15],
    MAX(CASE WHEN LOC_USERSORT1 = 'W16' THEN 'Y' ELSE '' END) AS [W16],
    MAX(CASE WHEN LOC_USERSORT1 = 'W69' THEN 'Y' ELSE '' END) AS [W69],
    MAX(CASE WHEN LOC_USERSORT1 = 'W99' THEN 'Y' ELSE '' END) AS [W99],
    MAX(CASE WHEN LOC_USERSORT1 = 'WHK' THEN 'Y' ELSE '' END) AS [WHK],
    MAX(CASE WHEN LOC_USERSORT1 = 'WHR' THEN 'Y' ELSE '' END) AS [WHR],
    MAX(CASE WHEN LOC_USERSORT1 = 'WHX' THEN 'Y' ELSE '' END) AS [WHX],
    MAX(CASE WHEN LOC_USERSORT1 = 'WHY' THEN 'Y' ELSE '' END) AS [WHY],
    MAX(CASE WHEN LOC_USERSORT1 = 'WHZ' THEN 'Y' ELSE '' END) AS [WHZ],
    MAX(CASE WHEN LOC_USERSORT1 = 'WKH' THEN 'Y' ELSE '' END) AS [WKH],
    MAX(CASE WHEN LOC_USERSORT1 = 'WSC' THEN 'Y' ELSE '' END) AS [WSC]
FROM [VJSCL].[dbo].[STK_LOCATION] AS S
inner join stk_stock st on s.LOC_STOCK_CODE = st.STKCODE
where st.STK_DO_NOT_USE = 0
-- and loc_stock_code = '30FFK_S16091'
GROUP BY LOC_STOCK_CODE
ORDER BY LOC_STOCK_CODE;


-- select
-- loc_code,
-- loc_stock_code,
-- LOC_USERSORT1,
-- LOC_USERSORT2
-- from stk_location
-- where LOC_USERSORT1 like 'w%';



SELECT
l.loc_stock_code as 'Stock code',
st.stkname 'Stock name',
l.loc_code 'Location code',
l.loc_name 'Location name',
l.loc_usersort1 'Warehouse',
l.loc_usersort2 'Lot Number',
cast(l2.loc_userdate1 as date) 'Expiry Date'
FROM [VJSCL].[dbo].[STK_LOCATION] AS l
left OUTER join stk_location2 as l2 on l.loc_code = l2.LOC_CODE2
and l.LOC_STOCK_CODE = l2.LOC_STOCKCODE2
inner join stk_stock st on l.LOC_STOCK_CODE = st.STKCODE
where st.STK_DO_NOT_USE = 0
-- and st.stkcode = '308in1_01567'
and l.loc_usersort2 <> ''
ORDER BY l.loc_stock_code,
l.loc_code;