SELECT TOP (1000) [Code]
      ,[Country_of_Origin]
      ,[Commodity_Code]
      ,[Weight_Sell]
      ,[BarcodeOutCase]
      ,[Dimensions]
      ,[Units_Pallet]
      ,[Units_Layer]
      ,[Layers_Pallet]
  FROM [VJSCL].[dbo].[tmp_import]


select 
s.stkcode,
s.stkname,
s.stk_ec_origin,
t.Country_of_Origin,
s.stk_ec_com_code,
t.Commodity_Code,
s.stk_s_weight,
t.Weight_Sell,
s3.STK_USRCHAR7,
t.BarcodeOutCase,
s3.STK_USRCHAR14,
t.Dimensions,
s3.STK_USRNUM6,
t.units_Pallet,
s3.STK_USRNUM7,
t.Units_Layer
from 
STK_STOCK s inner join tmp_import t on s.stkcode = t.code
INNER JOIN STK_STOCK3 S3 ON S.STKCODE = S3.STKCODE3
-- where t.Country_of_Origin is not null and t.Country_of_Origin <> '' and t.Country_of_Origin <> s.stk_ec_origin
-- or t.Commodity_Code is not null and t.Commodity_Code <> '' and t.Commodity_Code <> s.stk_ec_com_code
-- or t.Weight_Sell is not null and t.Weight_Sell <> '' and t.Weight_Sell <> s.stk_s_weight
-- or t.BarcodeOutCase is not null and t.BarcodeOutCase <> '' and t.BarcodeOutCase <> s3.STK_USRCHAR7
-- or t.Dimensions is not null and t.Dimensions <> '' and t.Dimensions <> s3.STK_USRCHAR14
-- or t.units_Pallet is not null and t.units_Pallet <> '' and t.units_Pallet <> s3.STK_USRNUM6
-- or t.Units_Layer is not null and t.Units_Layer <> '' and t.Units_Layer <> s3.STK_USRNUM7;



SET XACT_ABORT ON;
BEGIN TRANSACTION;

-- 更新 STK_STOCK
UPDATE s
SET
    s.stk_ec_origin = COALESCE(NULLIF(t.Country_of_Origin, ''), s.stk_ec_origin),
    s.stk_s_weight = COALESCE(NULLIF(t.Weight_Sell, ''), s.stk_s_weight)
FROM STK_STOCK AS s
INNER JOIN tmp_import AS t
    ON s.stkcode = t.code

UPDATE s
SET
    s.stk_ec_com_code = COALESCE(NULLIF(t.Commodity_Code, ''), s.stk_ec_com_code)
FROM STK_STOCK AS s
INNER JOIN tmp_import AS t
    ON s.stkcode = t.code
where datalength(t.Commodity_Code) = 8;


-- 更新 STK_STOCK3
UPDATE s3
SET
    s3.STK_USRCHAR7 = COALESCE(NULLIF(t.BarcodeOutCase, ''), s3.STK_USRCHAR7),
    s3.STK_USRCHAR14 = COALESCE(NULLIF(t.Dimensions, ''), s3.STK_USRCHAR14),
    s3.STK_USRNUM6 = COALESCE(NULLIF(t.units_Pallet, ''), s3.STK_USRNUM6),
    s3.STK_USRNUM7 = COALESCE(NULLIF(t.Units_Layer, ''), s3.STK_USRNUM7)
FROM STK_STOCK3 AS s3
INNER JOIN tmp_import AS t
    ON s3.STKCODE3 = t.code;

COMMIT TRANSACTION;


SELECT
    SCHEMA_NAME(tb.schema_id) AS SchemaName,
    tb.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length AS MaxLengthBytes,
    c.precision AS [Precision],
    c.scale AS Scale,
    c.is_nullable AS IsNullable
FROM sys.tables AS tb
INNER JOIN sys.columns AS c
    ON tb.object_id = c.object_id
INNER JOIN sys.types AS ty
    ON c.user_type_id = ty.user_type_id
WHERE
    (
        tb.name = 'STK_STOCK'
        AND c.name IN (
            'stk_ec_origin',
            'stk_ec_com_code',
            'stk_s_weight'
        )
    )
    OR
    (
        tb.name = 'STK_STOCK3'
        AND c.name IN (
            'STK_USRCHAR7',
            'STK_USRCHAR14',
            'STK_USRNUM6',
            'STK_USRNUM7'
        )
    )
ORDER BY tb.name, c.column_id;