SELECT
    "ORD_DETAIL"."OD_STOCK_CODE",
    "DOC_ORDER_DETAIL"."DOD_QUANTITY",
    "ORD_HEADER"."OH_ORDER_NUMBER",
    "ORD_DETAIL"."OD_LOCATN",
    "DOC_ORDER_DETAIL"."DOD_BIN_NUMBER",
    "ORD_DETAIL"."OD_DETAIL",
    "STK_LOCATION"."LOC_NAME",
    "DOC_ORDER_DETAIL"."DOD_SUB_GROUP",
    "DOC_ORDER_HEADER"."DOH_OPTION1",
    "SYS_DATAINFO2"."STK_SOP_COPY_DESC",
    "ORD_DETAIL"."OD_ENTRY_TYPE",
    "STK_STOCK"."STKNAME",
    "STK_LOCATION"."LOC_USERSORT2",
    "STK_LOCATION2"."LOC_USERDATE1",
    "STK_STOCK"."STK_BARCODE",
    "SYS_DATAINFO"."COMPANY_NAME",
    "SYS_DATAINFO"."COMP_ADDRESS",
    "SYS_DATAINFO"."COMP_ADDRESS_USER1",
    "SYS_DATAINFO"."COMP_POSTCODE",
    "SYS_DATAINFO"."COMP_ADDRESS_USER2",
    "SYS_DATAINFO"."COMP_VATNUMBER",
    "SYS_DATAINFO2"."COMP_USERFIELD1",
    "SYS_DATAINFO2"."COMP_USERFIELD2",
    "SYS_DATAINFO"."COMP_TELEPHONE",
    "SYS_DATAINFO"."COMP_FAX",
    "SL_ACCOUNTS"."CUNAME",
    "SL_ADDRESSES"."AD_ACCOUNTNAME",
    "SL_ADDRESSES"."AD_ADDRESS",
    "SL_ADDRESSES"."AD_ADDRESS_USER1",
    "SL_ADDRESSES"."AD_ADDRESS_USER2",
    "SL_ADDRESSES"."AD_POSTCODE",
    "SL_ACCOUNTS"."CU_VAT_REG_NO",
    "SL_ADDRESSES"."AD_MOBILE",
    "SL_ADDRESSES"."AD_PHONE",
    "SL_ADDRESSES2"."AD_ACCOUNTNAME",
    "SL_ADDRESSES2"."AD_ADDRESS",
    "SL_ADDRESSES2"."AD_ADDRESS_USER1",
    "SL_ADDRESSES2"."AD_ADDRESS_USER2",
    "SL_ADDRESSES2"."AD_POSTCODE",
    "ORD_HEADER"."OH_ACCOUNT",
    "ORD_HEADER"."OH_DATE"
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
                                            "VJSCL"."dbo"."DOC_ORDER_HEADER" "DOC_ORDER_HEADER"
                                            INNER JOIN "VJSCL"."dbo"."DOC_ORDER_DETAIL" "DOC_ORDER_DETAIL" ON "DOC_ORDER_HEADER"."DOH_PRIMARY" = "DOC_ORDER_DETAIL"."DOD_HEADER_LINK"
                                        )
                                        INNER JOIN "VJSCL"."dbo"."ORD_DETAIL" "ORD_DETAIL" ON "DOC_ORDER_DETAIL"."DOD_ORDER_LINK" = "ORD_DETAIL"."OD_PRIMARY"
                                    )
                                    INNER JOIN "VJSCL"."dbo"."STK_STOCK" "STK_STOCK" ON "ORD_DETAIL"."OD_STOCK_CODE" = "STK_STOCK"."STKCODE"
                                )
                                INNER JOIN "VJSCL"."dbo"."ORD_HEADER" "ORD_HEADER" ON "ORD_DETAIL"."OD_ORDER_NUMBER" = "ORD_HEADER"."OH_ORDER_NUMBER"
                            )
                            LEFT OUTER JOIN "VJSCL"."dbo"."STK_LOCATION" "STK_LOCATION" ON (
                                "ORD_DETAIL"."OD_LOCATN" = "STK_LOCATION"."LOC_CODE"
                            ) AND
                            (
                                "ORD_DETAIL"."OD_STOCK_CODE" = "STK_LOCATION"."LOC_STOCK_CODE"
                            )
                        )
                        INNER JOIN "VJSCL"."dbo"."SL_ACCOUNTS" "SL_ACCOUNTS" ON "ORD_HEADER"."OH_ACCOUNT" = "SL_ACCOUNTS"."CUCODE"
                    )
                    INNER JOIN "VJSCL"."dbo"."SL_ADDRESSES" "SL_ADDRESSES" ON (
                        "ORD_HEADER"."OH_INV_ADD" = "SL_ADDRESSES"."AD_CODE"
                    ) AND
                    (
                        "ORD_HEADER"."OH_ACCOUNT" = "SL_ADDRESSES"."AD_ACC_CODE"
                    )
                )
                INNER JOIN "VJSCL"."dbo"."SL_ADDRESSES" "SL_ADDRESSES2" ON (
                    "ORD_HEADER"."OH_ACCOUNT" = "SL_ADDRESSES2"."AD_ACC_CODE"
                ) AND
                (
                    "ORD_HEADER"."OH_DEL_ADD" = "SL_ADDRESSES2"."AD_CODE"
                )
            )
            INNER JOIN "VJSCL"."dbo"."SYS_DATAINFO" "SYS_DATAINFO" ON "SL_ACCOUNTS"."CU_MULTIADD_FLG" = "SYS_DATAINFO"."SYS_PRIMARY"
        )
        INNER JOIN "VJSCL"."dbo"."SYS_DATAINFO2" "SYS_DATAINFO2" ON "SYS_DATAINFO"."SYS_PRIMARY" = "SYS_DATAINFO2"."SYS_PRIMARY_2"
    )
    INNER JOIN "VJSCL"."dbo"."STK_LOCATION2" "STK_LOCATION2" ON (
        "STK_LOCATION"."LOC_STOCK_CODE" = "STK_LOCATION2"."LOC_STOCKCODE2"
    ) AND
    (
        "STK_LOCATION"."LOC_CODE" = "STK_LOCATION2"."LOC_CODE2"
    )
where oh_account = '30JAN002'    
ORDER BY
    "DOC_ORDER_DETAIL"."DOD_SUB_GROUP",
    "ORD_HEADER"."OH_ORDER_NUMBER"