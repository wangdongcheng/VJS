DECLARE @stktype NVARCHAR(50);

SET
  @stktype = '30 MPM PRODUCTS LTD.';

SELECT
  STKCODE,
  STKNAME,
  STK_USRCHAR12 AS OrderShelfLife,
  STK_USRFLAG8 AS SellOnlyCases,
  STK_USRFLAG1 AS DoNotLoad,
  STK_EC_SUP_UNIT AS UnitsPerCase,
  STK_USRFLAG3 AS Delisted,
  -- NULLIF(S.STK_EC_SUP_UNIT, 0) will return NULL if S.STK_EC_SUP_UNIT is 0.
  -- Division by NULL in SQL does not throw an error; it simply returns NULL.
  -- Then COALESCE(..., 0) replaces that NULL with 0.
  COALESCE(s.stk_order_in / NULLIF(S.STK_EC_SUP_UNIT, 0), 0) AS IncomingOrderedQty,
  CASE
    WHEN S.STK_EC_SUP_UNIT = 0 OR
    S.STK_EC_SUP_UNIT IS NULL THEN 0
    ELSE STK_USRNUM1 / S.STK_EC_SUP_UNIT
  END AS POMinQty,
  S3.STK_USRNUM6 AS UnitsPerPallet,
  S3.STK_USRNUM7 AS UnitsPerLayer
FROM
  STK_STOCK S
  INNER JOIN STK_STOCK3 S3 ON S3.STKCODE3 = S.STKCODE
WHERE
  STK_SORT_KEY3 = @stktype AND
  STK_USRFLAG2 = 1