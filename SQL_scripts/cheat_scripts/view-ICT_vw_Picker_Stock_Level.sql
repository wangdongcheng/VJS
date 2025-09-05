SELECT
    TOP 20 *
FROM
    (
        SELECT DISTINCT
            oh_order_number AS OrderNum,
            st.st_header_ref InvoiceNum,
            cuname AS CustomerName,
            oh_date AS DATE,
            st.st_date InvoiceDate,
            od_stock_code,
            stkname,
            od_date,
            od_usrchar1 --, stk_bin_number FloorNumber
        FROM
            ord_header
            INNER JOIN ord_detail ON oh_order_number = od_order_number
            INNER JOIN stk_stock ON stkcode = od_stock_code
            INNER JOIN ord_detail2 ON od_primary = OD_PRIMARY_2
            INNER JOIN sl_pl_nl_detail spn ON spn.det_order_link = od_primary
            INNER JOIN sl_transactions st ON st.st_header_key = det_header_key
            INNER JOIN sl_accounts sl2 ON sl2.cucode = st.st_copycust
        WHERE
            oh_type = 'O' AND
            oh_date >= '2023-03-01'
    ) z
    INNER JOIN (
        SELECT DISTINCT
            Picker,
            OrderNumber,
            Warehouse,
            Name
        FROM
            [dbo].[ICT_vw_PickersList]
    ) pl ON RIGHT(pl.warehouse, 1) = RIGHT(z.od_usrchar1, 1) AND
    pl.OrderNumber = try_cast(z.OrderNum as nvarchar(100))


