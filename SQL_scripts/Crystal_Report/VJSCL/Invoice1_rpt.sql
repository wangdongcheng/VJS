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
    "SYS_VATCONTROL"."VAT_RATE",
    "SYS_VATCONTROL2"."VAT_RATE",
    "SYS_VATCONTROL3"."VAT_RATE",
    "SYS_VATCONTROL4"."VAT_RATE",
    "SL_ACCOUNTS"."CU_VAT_REG_NO",
    "SL_ADDRESSES"."AD_ADDRESS",
    "SL_ADDRESSES"."AD_ADDRESS_USER1",
    "SL_ADDRESSES"."AD_ADDRESS_USER2",
    "SL_ADDRESSES"."AD_POSTCODE",
    "SYS_DATAINFO"."HOME_CURR_SYMBL",
    "DOC_ORDER_DETAIL"."DOD_VAT_BASE1",
    "SL_ADDRESSES"."AD_ACCOUNTNAME",
    "DOC_ORDER_DETAIL"."DOD_UNITCST_DOC",
    "SYS_DATAINFO"."COMPANY_NAME",
    "SYS_DATAINFO"."COMP_ADDRESS",
    "SYS_DATAINFO"."COMP_ADDRESS_USER1",
    "SYS_DATAINFO"."COMP_ADDRESS_USER2",
    "SYS_DATAINFO"."COMP_POSTCODE",
    "SYS_DATAINFO"."COMP_VATNUMBER",
    "STK_STOCK_2"."STK_SELLPRICE10",
    "ORD_HEADER"."OH_USER3",
    "ORD_HEADER"."OH_USER1",
    "SL_ADDRESSES2"."AD_ACCOUNTNAME",
    "SL_ADDRESSES2"."AD_ADDRESS",
    "SL_ADDRESSES2"."AD_ADDRESS_USER1",
    "SL_ADDRESSES2"."AD_ADDRESS_USER2",
    "SL_ADDRESSES2"."AD_POSTCODE",
    "SL_ADDRESSES"."AD_PHONE",
    "DOC_ORDER_HEADER"."DOH_DOC_TYPE",
    "SL_ADDRESSES"."AD_MOBILE",
    "SYS_DATAINFO2"."COMP_USERFIELD1",
    "STK_LOCATION"."LOC_USERSORT2",
    "STK_LOCATION2"."LOC_USERDATE1",
    "SL_ACCOUNTS"."CU_TERMS",
    "ORD_DETAIL"."OD_ENTRY_TYPE",
    "ORD_DETAIL"."OD_DETAIL",
    "STK_STOCK3"."STK_USRCHAR5",
    "SYS_DATAINFO2"."STK_SOP_COPY_DESC",
    "SYS_DATAINFO2"."COMP_USERFIELD2",
    "SL_ACCOUNTS2"."CU_BANK_AC_NO",
    "PTL_COPIES"."CC_COPIES",
    "PTL_COPIES"."CC_DESCRIPTION",
    "SL_ACCOUNTS2"."CU_USRFLAG3",
    "SYS_DATAINFO"."COMP_REGNUMBER",
    "SL_ACCOUNTS2"."CU_USRFLAG4",
    "SL_ACCOUNTS"."CUUSER3",
    "SL_ACCOUNTS"."CUCODE",
    "STK_STOCK"."STK_SORT_KEY",
    "ORD_DETAIL"."OD_DIMENSION5",
    "STK_STOCK"."STK_EC_SUP_UNIT",
    "STK_STOCK3"."STK_USRFLAG8",
    "STK_STOCK"."STK_SORT_KEY1",
    "DOC_ORDER_DETAIL"."DOD_MOVEMENT_DETAIL_TEXT",
    "SYS_VATCONTROL"."VAT_CODE",
    "SYS_VATCONTROL2"."VAT_CODE",
    "SYS_VATCONTROL3"."VAT_CODE",
    "SYS_VATCONTROL4"."VAT_CODE",
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
                                                (
                                                    (
                                                        (
                                                            (
                                                                (
                                                                    (
                                                                        (
                                                                            "VJSCL"."dbo"."PTL_COPIES" "PTL_COPIES"
                                                                            INNER JOIN "VJSCL"."dbo"."DOC_ORDER_DETAIL" "DOC_ORDER_DETAIL" ON "PTL_COPIES"."CC_COPIES" <> "DOC_ORDER_DETAIL"."DOD_ORDER_LINK"
                                                                        )
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
                                                    LEFT OUTER JOIN "VJSCL"."dbo"."SYS_VATCONTROL" "SYS_VATCONTROL3" ON "DOC_ORDER_HEADER"."DOH_VAT_CODE3" = "SYS_VATCONTROL3"."VAT_CODE"
                                                )
                                                LEFT OUTER JOIN "VJSCL"."dbo"."SYS_VATCONTROL" "SYS_VATCONTROL4" ON "DOC_ORDER_HEADER"."DOH_VAT_CODE4" = "SYS_VATCONTROL4"."VAT_CODE"
                                            )
                                            LEFT OUTER JOIN "VJSCL"."dbo"."SYS_VATCONTROL" "SYS_VATCONTROL2" ON "DOC_ORDER_HEADER"."DOH_VAT_CODE2" = "SYS_VATCONTROL2"."VAT_CODE"
                                        )
                                        INNER JOIN "VJSCL"."dbo"."SYS_DATAINFO2" "SYS_DATAINFO2" ON "SYS_DATAINFO"."SYS_PRIMARY" = "SYS_DATAINFO2"."SYS_PRIMARY_2"
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
                        )
                        INNER JOIN "VJSCL"."dbo"."SL_ACCOUNTS2" "SL_ACCOUNTS2" ON "SL_ACCOUNTS"."CUCODE" = "SL_ACCOUNTS2"."CUCODE2"
                    )
                    LEFT OUTER JOIN "VJSCL"."dbo"."STK_STOCK" "STK_STOCK" ON "ORD_DETAIL"."OD_STOCK_CODE" = "STK_STOCK"."STKCODE"
                )
                LEFT OUTER JOIN "VJSCL"."dbo"."STK_LOCATION" "STK_LOCATION" ON (
                    "ORD_DETAIL"."OD_LOCATN" = "STK_LOCATION"."LOC_CODE"
                ) AND
                (
                    "ORD_DETAIL"."OD_STOCK_CODE" = "STK_LOCATION"."LOC_STOCK_CODE"
                )
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
    LEFT OUTER JOIN "VJSCL"."dbo"."STK_STOCK3" "STK_STOCK3" ON "STK_STOCK"."STKCODE" = "STK_STOCK3"."STKCODE3"
--- begin add my conditions    
    where 
    -- DOC_ORDER_HEADER.DOH_DOC_NUMBER='686325'
     ord_header.oh_order_number = '815714' 
    --  AND od_stock_code = '30iam_00395'
--- end
ORDER BY
    "PTL_COPIES"."CC_COPIES",
    "DOC_ORDER_HEADER"."DOH_ORDER_LINK",
    "STK_STOCK"."STK_SORT_KEY"