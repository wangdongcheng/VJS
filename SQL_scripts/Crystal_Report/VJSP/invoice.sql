-- ============================================================
-- Order Document Query
-- Retrieves order header/detail info with customer, stock,
-- VAT, address, and company data
-- ============================================================
SELECT
    -- Order Identification
    oh.OH_ACCOUNT,
    oh.OH_ORDER_NUMBER,
    doh.DOH_DOC_DATE,
    doh.DOH_DOC_NUMBER,
    doh.DOH_DOC_TYPE,
    doh.DOH_DOC_DUEDATE,
    doh.DOH_ORDER_LINK,
    -- Order Line Details
    od.OD_STOCK_CODE,
    od.OD_TABLECODE,
    od.OD_VATCODE,
    od.OD_ENTRY_TYPE,
    od.OD_DETAIL,
    od.OD_DIMENSION5,
    -- Stock Info
    stk.STKNAME,
    -- Stock Selling Prices / Names
    stk2.STK_SELL_NAME1,
    stk2.STK_SELL_NAME2,
    stk2.STK_SELL_NAME3,
    stk2.STK_SELL_NAME4,
    stk2.STK_SELL_NAME5,
    stk2.STK_SELL_NAME6,
    stk2.STK_SELL_NAME7,
    stk2.STK_SELL_NAME8,
    stk2.STK_SELL_NAME9,
    stk2.STK_SELL_NAME10,
    stk2.STK_SELLPRICE10,
    -- Stock Extended Attributes
    stk3.STK_USRCHAR2,
    stk3.STK_USRCHAR5,
    stk3.STK_USRFLAG2,
    stk3.STK_USRFLAG3,
    -- Document Order Line Financials
    dod.DOD_QUANTITY,
    dod.DOD_LINEDISC_DOC,
    dod.DOD_NET_DOC,
    dod.DOD_TOTDISC_DOC,
    dod.DOD_VAT_DOC,
    dod.DOD_VAT_BASE1,
    dod.DOD_UNITCST_DOC,
    -- Order Header Financials
    oh.OH_CURRENCYCODE,
    oh.OH_DISC_TOTAL_P,
    -- VAT Breakdown (Nets)
    doh.DOH_VAT_NET1,
    doh.DOH_VAT_NET2,
    doh.DOH_VAT_NET3,
    doh.DOH_VAT_NET4,
    doh.DOH_VAT_NET5,
    -- VAT Breakdown (Values)
    doh.DOH_VAT_VALUE1,
    doh.DOH_VAT_VALUE2,
    doh.DOH_VAT_VALUE3,
    doh.DOH_VAT_VALUE4,
    doh.DOH_VAT_VALUE5,
    -- VAT Rates
    vat1.VAT_RATE,
    vat2.VAT_RATE,
    vat3.VAT_RATE,
    vat4.VAT_RATE,
    -- Customer Info
    cust.CUNAME,
    cust.CU_VAT_REG_NO,
    cust.CU_TERMS,
    cust.CU_COUNTRY,
    cust.CUUSER3,
    cust.CUCODE,
    cust.CUSORT,
    -- Customer Extended Attributes
    cust2.CU_BANK_AC_NO,
    cust2.CU_USRFLAG3,
    cust2.CU_USRFLAG4,
    -- Invoice Address
    inv_addr.AD_ACCOUNTNAME,
    inv_addr.AD_ADDRESS,
    inv_addr.AD_ADDRESS_USER1,
    inv_addr.AD_ADDRESS_USER2,
    inv_addr.AD_POSTCODE,
    inv_addr.AD_PHONE,
    inv_addr.AD_MOBILE,
    -- Delivery Address
    del_addr.AD_ACCOUNTNAME,
    del_addr.AD_ADDRESS,
    del_addr.AD_ADDRESS_USER1,
    del_addr.AD_ADDRESS_USER2,
    del_addr.AD_POSTCODE,
    -- Company Info
    sysinfo.HOME_CURR_SYMBL,
    sysinfo.COMPANY_NAME,
    sysinfo.COMP_ADDRESS,
    sysinfo.COMP_ADDRESS_USER1,
    sysinfo.COMP_ADDRESS_USER2,
    sysinfo.COMP_POSTCODE,
    sysinfo.COMP_VATNUMBER,
    sysinfo.COMP_TELEPHONE,
    sysinfo.COMP_FAX,
    sysinfo.COMP_REGNUMBER,
    -- Company Extended Settings
    sysinfo2.COMP_USERFIELD1,
    sysinfo2.COMP_USERFIELD2,
    sysinfo2.STK_SOP_COPY_DESC,
    -- Stock Location
    loc.LOC_USERSORT2,
    -- Stock Location Extended
    loc2.LOC_USERDATE1,
    loc2.LOC_USERFLAG1,
    loc2.LOC_USERFLAG2,
    -- Order Header User Fields
    oh.OH_USER1,
    oh.OH_USER3,
    oh.OH_INTERNL_NOTE,
    -- Print Copies
    pc.CC_COPIES,
    pc.CC_DESCRIPTION
FROM
    VJSP.dbo.PTL_COPIES pc
    -- Document order detail (note: intentional <> join to PTL_COPIES)
    INNER JOIN VJSP.dbo.DOC_ORDER_DETAIL dod ON pc.CC_COPIES <> dod.DOD_ORDER_LINK
    -- Document order header
    INNER JOIN VJSP.dbo.DOC_ORDER_HEADER doh ON dod.DOD_HEADER_LINK = doh.DOH_PRIMARY
    -- Order detail line
    INNER JOIN VJSP.dbo.ORD_DETAIL od ON dod.DOD_ORDER_LINK = od.OD_PRIMARY
    -- Stock master (optional)
    LEFT OUTER JOIN VJSP.dbo.STK_STOCK stk ON od.OD_STOCK_CODE = stk.STKCODE
    -- Stock location (optional)
    LEFT OUTER JOIN VJSP.dbo.STK_LOCATION loc ON od.OD_LOCATN = loc.LOC_CODE AND
    od.OD_STOCK_CODE = loc.LOC_STOCK_CODE
    -- Stock extended pricing/names (optional)
    LEFT OUTER JOIN VJSP.dbo.STK_STOCK_2 stk2 ON stk.STKCODE = stk2.STKCODE2
    -- Stock extended attributes (optional)
    LEFT OUTER JOIN VJSP.dbo.STK_STOCK3 stk3 ON stk.STKCODE = stk3.STKCODE3
    -- Stock location extended (optional)
    LEFT OUTER JOIN VJSP.dbo.STK_LOCATION2 loc2 ON loc.LOC_CODE = loc2.LOC_CODE2 AND
    loc.LOC_STOCK_CODE = loc2.LOC_STOCKCODE2
    -- Order header
    INNER JOIN VJSP.dbo.ORD_HEADER oh ON doh.DOH_ORDER_LINK = oh.OH_PRIMARY
    -- System / company info
    INNER JOIN VJSP.dbo.SYS_DATAINFO sysinfo ON doh.DOH_SYS_LINK = sysinfo.SYS_PRIMARY
    -- VAT code 1 (VJSP)
    LEFT OUTER JOIN VJSP.dbo.SYS_VATCONTROL vat1 ON doh.DOH_VAT_CODE1 = vat1.VAT_CODE
    -- VAT code 2 (VJSCL — different database)
    LEFT OUTER JOIN VJSCL.dbo.SYS_VATCONTROL vat2 ON doh.DOH_VAT_CODE2 = vat2.VAT_CODE
    -- VAT code 3 (VJSP)
    LEFT OUTER JOIN VJSP.dbo.SYS_VATCONTROL vat3 ON doh.DOH_VAT_CODE3 = vat3.VAT_CODE
    -- VAT code 4 (VJSP)
    LEFT OUTER JOIN VJSP.dbo.SYS_VATCONTROL vat4 ON doh.DOH_VAT_CODE4 = vat4.VAT_CODE
    -- Customer account
    INNER JOIN VJSP.dbo.SL_ACCOUNTS cust ON oh.OH_ACCOUNT = cust.CUCODE
    -- Delivery address
    INNER JOIN VJSP.dbo.SL_ADDRESSES del_addr ON oh.OH_ACCOUNT = del_addr.AD_ACC_CODE AND
    oh.OH_DEL_ADD = del_addr.AD_CODE
    -- Invoice address
    INNER JOIN VJSP.dbo.SL_ADDRESSES inv_addr ON oh.OH_ACCOUNT = inv_addr.AD_ACC_CODE AND
    oh.OH_INV_ADD = inv_addr.AD_CODE
    -- Customer extended attributes
    INNER JOIN VJSP.dbo.SL_ACCOUNTS2 cust2 ON cust.CUCODE = cust2.CUCODE2
    -- System / company extended settings
    INNER JOIN VJSP.dbo.SYS_DATAINFO2 sysinfo2 ON sysinfo.SYS_PRIMARY = sysinfo2.SYS_PRIMARY_2
ORDER BY
    pc.CC_COPIES,
    doh.DOH_ORDER_LINK