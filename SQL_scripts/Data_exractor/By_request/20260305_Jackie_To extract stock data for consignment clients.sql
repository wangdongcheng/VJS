use vjsp;

SELECT
    CASE oh.oh_type
        WHEN 'C' THEN 'CRN'
        WHEN 'O' THEN 'INV'
    END AS OrderType,
    sl.cucode AS CustomerCode,
    sl.cuname AS CustomerName,
    st.st_header_ref AS InvoiceNum,
    oh.oh_order_number AS OrderNum,
    oh.oh_date AS OrderDate,
    st.st_date AS InvoiceDate,
    od.od_stock_code AS StockCode,
    stk.stkname AS StockName,
    CASE oh.oh_type
        WHEN 'C' THEN od.OD_QTYORD * -1
        ELSE od.OD_QTYORD
    END AS Quantity,
    loc.LOC_USERSORT2 AS LotNumber
    -- od_usrchar1 --, stk_bin_number FloorNumber
FROM
    ord_header oh
    INNER JOIN ord_detail od ON oh.oh_order_number = od.od_order_number
    INNER JOIN stk_stock stk ON stk.stkcode = od.od_stock_code
    -- INNER JOIN ord_detail2 ON od_primary = OD_PRIMARY_2
    INNER JOIN sl_pl_nl_detail spn ON spn.det_order_link = od_primary
    INNER JOIN sl_transactions st ON st.st_header_key = det_header_key
    INNER JOIN sl_accounts sl ON sl.cucode = st.st_copycust
    LEFT OUTER JOIN STK_LOCATION loc ON od.OD_LOCATN = loc.LOC_CODE AND
    od.OD_STOCK_CODE = loc.LOC_STOCK_CODE
WHERE
    oh.oh_account LIKE '95%'
ORDER BY
    sl.cucode,
    st.st_date,
    st.st_header_ref,
    stk.stkname;