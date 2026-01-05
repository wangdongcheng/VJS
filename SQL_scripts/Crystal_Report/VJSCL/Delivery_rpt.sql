select STK_SORT_KEY,
    stk_sort_key1,
    stk_sort_key2,
    stk_s_weight,
    STK_SUPSTKCDE1,
    stkname,
    stkcode
from ord_detail
INNER JOIN stk_stock ON ord_detail.OD_STOCK_CODE = stk_stock.STKCODE
INNER JOIN stk_stock_2 on ord_detail.OD_STOCK_CODE = stk_stock_2.STKCODE2
where Od_ORDER_NUMBER = '821622'
    order by STK_SORT_KEY,
    stk_sort_key1,
    stk_sort_key2,
    stk_s_weight,
    STK_SUPSTKCDE1
    ;
return;
SELECT
    "ORD_HEADER"."OH_ORDER_REF",
    "ORD_HEADER"."OH_ACCOUNT",
    "ORD_HEADER"."OH_ORDER_NUMBER",
    "ORD_HEADER"."OH_DEL_METHOD",
    "DOC_ORDER_HEADER"."DOH_DOC_DATE",
    "ORD_DETAIL"."OD_ENTRY_TYPE",
    "ORD_DETAIL"."OD_PRICE_CODE",
    "ORD_DETAIL"."OD_DETAIL",
    "STK_STOCK"."STKNAME",
    "DOC_ORDER_HEADER"."DOH_ORDER_LINK",
    "DOC_ORDER_DETAIL"."DOD_QUANTITY",
    "SYS_DATAINFO2"."STK_SOP_COPY_DESC",
    "SL_ACCOUNTS"."CUNAME",
    "SL_ADDRESSES"."AD_ADDRESS",
    "SL_ADDRESSES"."AD_ADDRESS_USER1",
    "SL_ADDRESSES"."AD_ADDRESS_USER2",
    "SL_ADDRESSES"."AD_POSTCODE",
    "ORD_DETAIL"."OD_SERIALNO",
    "ORD_DETAIL"."OD_QTYORD",
    "ORD_DETAIL"."OD_LOCATN",
    "DOC_ORDER_DETAIL"."DOD_HEADER_LINK",
    "SL_ADDRESSES"."AD_ACCOUNTNAME",
    "STK_STOCK"."STK_BIN_NUMBER",
    "STK_LOCATION2"."LOC_USERDATE1",
    "STK_STOCK3"."STK_USRCHAR5",
    "SL_ADDRESSES"."AD_DELIVERY_ROUTE",
    "STK_STOCK"."STK_SORT_KEY",
    "STK_STOCK"."STK_EC_SUP_UNIT",
    "SYS_DATAINFO"."COMPANY_NAME",
    "STK_STOCK"."STKCODE",
    "STK_LOCATION"."LOC_CODE",
    "STK_STOCK"."STK_S_WEIGHT",
    "STK_STOCK"."STK_SORT_KEY1",
    "STK_STOCK"."STK_SORT_KEY2",
    "STK_STOCK_2"."STK_SUPSTKCDE2",
    "STK_STOCK_2"."STK_SUPSTKCDE1",
    "STK_STOCK3"."STK_USRFLAG4",
    "ORD_HEADER"."OH_INTERNL_NOTE"
FROM
    (
        (
            (
                (
                    (
                        (
                            (
                                (
                                    (
                                        (
                                            (
                                                "VJSCL"."dbo"."DOC_ORDER_DETAIL" "DOC_ORDER_DETAIL"
                                                INNER JOIN "VJSCL"."dbo"."DOC_ORDER_HEADER" "DOC_ORDER_HEADER" ON "DOC_ORDER_DETAIL"."DOD_HEADER_LINK" = "DOC_ORDER_HEADER"."DOH_PRIMARY"
                                            )
                                            INNER JOIN "VJSCL"."dbo"."ORD_DETAIL" "ORD_DETAIL" ON "DOC_ORDER_DETAIL"."DOD_ORDER_LINK" = "ORD_DETAIL"."OD_PRIMARY"
                                        )
                                        INNER JOIN "VJSCL"."dbo"."ORD_HEADER" "ORD_HEADER" ON "DOC_ORDER_HEADER"."DOH_ORDER_LINK" = "ORD_HEADER"."OH_PRIMARY"
                                    )
                                    INNER JOIN "VJSCL"."dbo"."SYS_DATAINFO" "SYS_DATAINFO" ON "DOC_ORDER_HEADER"."DOH_SYS_LINK" = "SYS_DATAINFO"."SYS_PRIMARY"
                                )
                                INNER JOIN "VJSCL"."dbo"."SL_ACCOUNTS" "SL_ACCOUNTS" ON "ORD_HEADER"."OH_ACCOUNT" = "SL_ACCOUNTS"."CUCODE"
                            )
                            INNER JOIN "VJSCL"."dbo"."SL_ADDRESSES" "SL_ADDRESSES" ON (
                                "ORD_HEADER"."OH_ACCOUNT" = "SL_ADDRESSES"."AD_ACC_CODE"
                            ) AND
                            (
                                "ORD_HEADER"."OH_DEL_ADD" = "SL_ADDRESSES"."AD_CODE"
                            )
                        )
                        INNER JOIN "VJSCL"."dbo"."SYS_DATAINFO2" "SYS_DATAINFO2" ON "SYS_DATAINFO"."SYS_PRIMARY" = "SYS_DATAINFO2"."SYS_PRIMARY_2"
                    )
                    LEFT OUTER JOIN "VJSCL"."dbo"."STK_LOCATION" "STK_LOCATION" ON (
                        "ORD_DETAIL"."OD_LOCATN" = "STK_LOCATION"."LOC_CODE"
                    ) AND
                    (
                        "ORD_DETAIL"."OD_STOCK_CODE" = "STK_LOCATION"."LOC_STOCK_CODE"
                    )
                )
                LEFT OUTER JOIN "VJSCL"."dbo"."STK_STOCK" "STK_STOCK" ON "ORD_DETAIL"."OD_STOCK_CODE" = "STK_STOCK"."STKCODE"
            )
            LEFT OUTER JOIN "VJSCL"."dbo"."STK_LOCATION2" "STK_LOCATION2" ON (
                "STK_LOCATION"."LOC_CODE" = "STK_LOCATION2"."LOC_CODE2"
            ) AND
            (
                "STK_LOCATION"."LOC_STOCK_CODE" = "STK_LOCATION2"."LOC_STOCKCODE2"
            )
        )
        LEFT OUTER JOIN "VJSCL"."dbo"."STK_STOCK_2" "STK_STOCK_2" ON "STK_STOCK"."STKCODE" = "STK_STOCK_2"."STKCODE2"
    )
    INNER JOIN "VJSCL"."dbo"."STK_STOCK3" "STK_STOCK3" ON "STK_STOCK_2"."STKCODE2" = "STK_STOCK3"."STKCODE3"
    where "ORD_HEADER"."OH_ORDER_NUMBER" = '821556'
    order by STK_SORT_KEY,
    stk_sort_key1,
    stk_sort_key2,
    stk_s_weight,
    STK_SUPSTKCDE1
    ;