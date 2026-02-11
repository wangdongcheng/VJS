USE vjscl;

-- Sales out
SELECT
    stkcode,
    DET_ACCOUNT CustCode,
    STK_SUPSTKCDE1 AS SupplierCode,
    CASE
        WHEN det_type = 'CRN' THEN det_quantity * -1
        ELSE DET_QUANTITY
    END AS Qty,
    CASE
        WHEN det_type = 'CRN' THEN (DET_QUANTITY * STK_S_WEIGHT) * -1
        ELSE DET_QUANTITY * STK_S_WEIGHT
    END AS 'TotalWeightSold',
    CASE
        WHEN det_type = 'CRN' THEN ((DET_QUANTITY * STK_S_WEIGHT) * 2.20462262) * -1
        ELSE (DET_QUANTITY * STK_S_WEIGHT) * 2.20462262
    END AS 'TotalLBSSold',
    STK_S_WGHT_NAME AS 'WeightName'
FROM
    sl_pl_nl_detail
    INNER JOIN stk_stock ON stkcode = det_stock_code
    INNER JOIN ORD_DETAIL ON DET_ORDER_LINK = OD_PRIMARY AND
    DET_STOCK_CODE = OD_STOCK_CODE AND
    DET_QUANTITY = OD_QTYINVD
    INNER JOIN ORD_HEADER ON OD_ORDER_NUMBER = OH_ORDER_NUMBER
    INNER JOIN stk_stock_2 ON stkcode = stkcode2
WHERE
    stk_sort_key3 = '30 HILLS PET NUTRI.' AND
    DET_ORIGIN = 'SO' AND
    STK_S_WGHT_NAME = 'KG' AND
    det_date BETWEEN DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) -1, 0) AND DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)  -1;

-- det_date BETWEEN '2026-01-01 00:00:00' AND '2026-01-31 00:00:00';
-- Sales out YTD
SELECT
    stkcode,
    DET_ACCOUNT CustCode,
    STK_SUPSTKCDE1 AS SupplierCode,
    CASE
        WHEN det_type = 'CRN' THEN det_quantity * -1
        ELSE DET_QUANTITY
    END AS Qty,
    CASE
        WHEN det_type = 'CRN' THEN (DET_QUANTITY * STK_S_WEIGHT) * -1
        ELSE DET_QUANTITY * STK_S_WEIGHT
    END AS 'TotalWeightSold_YTD',
    CASE
        WHEN det_type = 'CRN' THEN ((DET_QUANTITY * STK_S_WEIGHT) * 2.20462262) * -1
        ELSE (DET_QUANTITY * STK_S_WEIGHT) * 2.20462262
    END AS 'TotalLBSSold_YTD',
    STK_S_WGHT_NAME AS 'WeightName'
FROM
    sl_pl_nl_detail
    INNER JOIN stk_stock ON stkcode = det_stock_code
    INNER JOIN ORD_DETAIL ON DET_ORDER_LINK = OD_PRIMARY AND
    DET_STOCK_CODE = OD_STOCK_CODE AND
    DET_QUANTITY = OD_QTYINVD
    INNER JOIN ORD_HEADER ON OD_ORDER_NUMBER = OH_ORDER_NUMBER
    INNER JOIN stk_stock_2 ON stkcode = stkcode2
WHERE
    stk_sort_key3 = '30 HILLS PET NUTRI.' AND
    DET_ORIGIN = 'SO' AND
    STK_S_WGHT_NAME = 'KG' AND
    det_date BETWEEN CONCAT(
        YEAR(
            DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) -1, 0)
        ),
        '0101'
    ) AND DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)  -1;