SELECT
    "ORD_HEADER"."OH_ACCOUNT",
    "ORD_HEADER"."OH_ORDER_NUMBER",
    "DOC_ORDER_HEADER"."DOH_DOC_DATE",
    "ORD_DETAIL"."OD_STOCK_CODE",
    "STK_STOCK"."STKNAME",
    "DOC_ORDER_DETAIL"."DOD_QUANTITY",
    "ORD_DETAIL"."OD_TABLECODE",
    "STK_STOCK_2"."STK_SELL_NAME1",
    "STK_STOCK_2"."STK_SELL_NAME2",
    "STK_STOCK_2"."STK_SELL_NAME3",
    "STK_STOCK_2"."STK_SELL_NAME4",
    "STK_STOCK_2"."STK_SELL_NAME5",
    "STK_STOCK_2"."STK_SELL_NAME6",
    "STK_STOCK_2"."STK_SELL_NAME7",
    "STK_STOCK_2"."STK_SELL_NAME8",
    "STK_STOCK_2"."STK_SELL_NAME9",
    "STK_STOCK_2"."STK_SELL_NAME10",
    "DOC_ORDER_DETAIL"."DOD_LINEDISC_DOC",
    "DOC_ORDER_DETAIL"."DOD_NET_DOC",
    "ORD_HEADER"."OH_CURRENCYCODE",
    "DOC_ORDER_HEADER"."DOH_VAT_CODE1",
    "DOC_ORDER_HEADER"."DOH_VAT_CODE2",
    "DOC_ORDER_HEADER"."DOH_VAT_CODE3",
    "DOC_ORDER_HEADER"."DOH_VAT_CODE4",
    "DOC_ORDER_HEADER"."DOH_VAT_CODE5",
    "DOC_ORDER_HEADER"."DOH_VAT_NET2",
    "DOC_ORDER_HEADER"."DOH_VAT_NET3",
    "DOC_ORDER_HEADER"."DOH_VAT_NET4",
    "DOC_ORDER_HEADER"."DOH_VAT_NET5",
    "DOC_ORDER_HEADER"."DOH_DOC_DUEDATE",
    "ORD_HEADER"."OH_DISC_TOTAL_P",
    "ORD_DETAIL"."OD_VATCODE",
    "DOC_ORDER_HEADER"."DOH_ORDER_LINK",
    "DOC_ORDER_DETAIL"."DOD_VAT_DOC",
    "DOC_ORDER_HEADER"."DOH_VAT_NET1",
    "DOC_ORDER_HEADER"."DOH_VAT_VALUE1",
    "DOC_ORDER_HEADER"."DOH_VAT_VALUE2",
    "DOC_ORDER_HEADER"."DOH_VAT_VALUE3",
    "DOC_ORDER_HEADER"."DOH_VAT_VALUE5",
    "DOC_ORDER_HEADER"."DOH_VAT_VALUE4",
    "DOC_ORDER_DETAIL"."DOD_TOTDISC_DOC",
    "DOC_ORDER_HEADER"."DOH_DOC_NUMBER",
    "SL_ACCOUNTS"."CUNAME",
    "DOC_ORDER_DETAIL"."DOD_NET_BASE2",
    "DOC_ORDER_DETAIL"."DOD_VAT_BASE2",
    "SYS_VATCONTROL"."VAT_RATE",
    "SYS_VATCONTROL2"."VAT_RATE",
    "SYS_VATCONTROL3"."VAT_RATE",
    "SYS_VATCONTROL4"."VAT_RATE",
    "SYS_DATAINFO2"."BASE2_CURR_SYMBOL",
    "SL_ACCOUNTS"."CU_VAT_REG_NO",
    "SL_ADDRESSES"."AD_ADDRESS",
    "SL_ADDRESSES"."AD_ADDRESS_USER1",
    "SL_ADDRESSES"."AD_ADDRESS_USER2",
    "SL_ADDRESSES"."AD_POSTCODE",
    "DOC_ORDER_DETAIL"."DOD_TOTDISC_BASE2",
    "SYS_DATAINFO"."HOME_CURR_SYMBL",
    "ORD_HEADER"."OH_L_DISCVAL",
    "ORD_DETAIL"."OD_SERIALNO",
    "DOC_ORDER_DETAIL"."DOD_VAT_BASE1",
    "SYS_DATAINFO"."HOME_COUNTRY",
    "DOC_ORDER_DETAIL"."DOD_HEADER_LINK",
    "SL_ADDRESSES"."AD_ACCOUNTNAME",
    "DOC_ORDER_DETAIL"."DOD_UNITCST_DOC",
    "SYS_DATAINFO"."COMPANY_NAME",
    "SYS_DATAINFO"."COMP_ADDRESS",
    "SYS_DATAINFO"."COMP_ADDRESS_USER1",
    "SYS_DATAINFO"."COMP_ADDRESS_USER2",
    "SYS_DATAINFO"."COMP_POSTCODE",
    "SYS_DATAINFO"."COMP_VATNUMBER",
    "SYS_DATAINFO"."COMP_TELEPHONE",
    "SYS_DATAINFO"."COMP_FAX",
    "STK_STOCK_2"."STK_SELLPRICE10",
    "ORD_HEADER"."OH_USER1",
    "STK_LOCATION"."LOC_USERSORT2",
    "STK_LOCATION2"."LOC_USERDATE1",
    "ORD_DETAIL"."OD_ENTRY_TYPE",
    "ORD_DETAIL"."OD_DETAIL",
    "ORD_DETAIL"."OD_PRICE_CODE",
    "SYS_DATAINFO2"."STK_SOP_COPY_DESC",
    "SL_ADDRESSES2"."AD_ACCOUNTNAME",
    "SL_ADDRESSES2"."AD_ADDRESS",
    "SL_ADDRESSES2"."AD_ADDRESS_USER1",
    "SL_ADDRESSES2"."AD_ADDRESS_USER2",
    "SL_ADDRESSES2"."AD_POSTCODE",
    "ORD_DETAIL"."OD_DIMENSION5",
    "STK_STOCK3"."STK_USRFLAG8",
    "STK_STOCK"."STK_EC_SUP_UNIT",
    "ORD_DETAIL2"."OD_USRCHAR3",
    "ORD_DETAIL2"."OD_USRCHAR4",
    "ORD_HEADER"."OH_INTERNL_NOTE"
FROM
    (
        (
            "VJSCL"."dbo"."STK_STOCK3" "STK_STOCK3"
            RIGHT OUTER JOIN (
                (
                    (
                        "VJSCL"."dbo"."ORD_DETAIL2" "ORD_DETAIL2"
                        RIGHT OUTER JOIN (
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
                                                        LEFT OUTER JOIN "VJSCL"."dbo"."SYS_VATCONTROL" "SYS_VATCONTROL" ON "DOC_ORDER_HEADER"."DOH_VAT_CODE1" = "SYS_VATCONTROL"."VAT_CODE"
                                                    )
                                                    LEFT OUTER JOIN "VJSCL"."dbo"."SYS_VATCONTROL" "SYS_VATCONTROL2" ON "DOC_ORDER_HEADER"."DOH_VAT_CODE2" = "SYS_VATCONTROL2"."VAT_CODE"
                                                )
                                                LEFT OUTER JOIN "VJSCL"."dbo"."SYS_VATCONTROL" "SYS_VATCONTROL3" ON "DOC_ORDER_HEADER"."DOH_VAT_CODE3" = "SYS_VATCONTROL3"."VAT_CODE"
                                            )
                                            LEFT OUTER JOIN "VJSCL"."dbo"."SYS_VATCONTROL" "SYS_VATCONTROL4" ON "DOC_ORDER_HEADER"."DOH_VAT_CODE4" = "SYS_VATCONTROL4"."VAT_CODE"
                                        )
                                        LEFT OUTER JOIN "VJSCL"."dbo"."SYS_DATAINFO2" "SYS_DATAINFO2" ON "SYS_DATAINFO"."SYS_PRIMARY" = "SYS_DATAINFO2"."SYS_PRIMARY_2"
                                    )
                                    INNER JOIN "VJSCL"."dbo"."SL_ACCOUNTS" "SL_ACCOUNTS" ON "ORD_HEADER"."OH_ACCOUNT" = "SL_ACCOUNTS"."CUCODE"
                                )
                                INNER JOIN "VJSCL"."dbo"."SL_ADDRESSES" "SL_ADDRESSES2" ON (
                                    "ORD_HEADER"."OH_ACCOUNT" = "SL_ADDRESSES2"."AD_ACC_CODE"
                                ) AND
                                (
                                    "ORD_HEADER"."OH_DEL_ADD" = "SL_ADDRESSES2"."AD_CODE"
                                )
                            )
                            INNER JOIN "VJSCL"."dbo"."SL_ADDRESSES" "SL_ADDRESSES" ON (
                                "ORD_HEADER"."OH_ACCOUNT" = "SL_ADDRESSES"."AD_ACC_CODE"
                            ) AND
                            (
                                "ORD_HEADER"."OH_INV_ADD" = "SL_ADDRESSES"."AD_CODE"
                            )
                        ) ON "ORD_DETAIL2"."OD_PRIMARY_2" = "ORD_DETAIL"."OD_PRIMARY"
                    )
                    LEFT OUTER JOIN "VJSCL"."dbo"."STK_STOCK" "STK_STOCK" ON "ORD_DETAIL"."OD_STOCK_CODE" = "STK_STOCK"."STKCODE"
                )
                LEFT OUTER JOIN "VJSCL"."dbo"."STK_LOCATION" "STK_LOCATION" ON (
                    "ORD_DETAIL"."OD_LOCATN" = "STK_LOCATION"."LOC_CODE"
                ) AND
                (
                    "ORD_DETAIL"."OD_STOCK_CODE" = "STK_LOCATION"."LOC_STOCK_CODE"
                )
            ) ON "STK_STOCK3"."STKCODE3" = "STK_STOCK"."STKCODE"
        )
        LEFT OUTER JOIN "VJSCL"."dbo"."STK_STOCK_2" "STK_STOCK_2" ON "STK_STOCK"."STKCODE" = "STK_STOCK_2"."STKCODE2"
    )
    LEFT OUTER JOIN "VJSCL"."dbo"."STK_LOCATION2" "STK_LOCATION2" ON "STK_LOCATION"."LOC_PRIMARY" = "STK_LOCATION2"."LOC_PRIMARY2"
--- begin add my conditions    
    where DOC_ORDER_HEADER.DOH_DOC_NUMBER='127664'
    and ord_header.oh_order_number = '809450'
--- end    
ORDER BY
    "DOC_ORDER_HEADER"."DOH_ORDER_LINK"