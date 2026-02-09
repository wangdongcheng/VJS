USE vjsp;

-- SELECT
-- *
-- from STK_STOCK4
-- where STKCODE4 = '500AZZAMLODOPINE5X28';
-- return;
SELECT
    stk.stkcode 'Stock Code',
    stk.stkname 'Description',
    stk.STK_RTP_FLAG 'Enable RTP',
    ROUND(stk.STK_BASEPRICE, 2) 'Sell Price',
    ROUND(stk.STK_COSTPRICE, 2) 'Cost Price',
    stk.STK_PHYSICAL + stk.STK_QTYPRINTED 'Stock - Physical',
    stk.STK_RESERVE_OUT 'Stock - Allocated Stock',
    stk.STK_PHYSICAL - stk.STK_RESERVE_OUT 'Stock - Free',
    stk.STK_ORDER_IN 'Stock - Order In',
    stk.STK_AV_VALU 'Stock - Average Value',
    stk.STK_MIN_QTY 'Stock Levels - Minimum',
    stk.STK_MAX_QTY 'Stock Levels - Maximum',
    stk.STK_BIN_NUMBER 'Lead Time',
    stk.STK_SORT_KEY 'SUPPLIER',
    STK.STK_SORT_KEY1 'BRAND',
    STK.STK_SORT_KEY2 'DRUG CLASS',
    STK.STK_SORT_KEY3 'TYPE',
    STK.STK_OLDCODE 'Superseded by Code',
    stk.STK_LEVEL 'Level',
    stk.STK_REVERSE_CHRGE_VAT 'Reverse Charge VAT applies',
    stk.STK_WWW_PUBLISH 'Publish on World Wide Web',
    stk.STK_SPECIAL_PRICE_DATE 'Special Price From',
    stk.STK_NOTES 'Notes',
    stk.STK_EC_KILOS 'Exp Days Alert',
    stk.STK_EC_ORIGIN 'Country of Origin',
    stk.STK_EC_COM_CODE 'Commodity Code',
    stk.STK_EC_SUP_UNIT 'Consumer Units',
    stk.STK_EC_SUP_UNIT_TYPE 'Consumer Unit Type',
    stk.STK_SERVICE 'Service',
    stk.STK_PLACE_OF_SUPPLY_VAT 'Apply Place of Supply VAT Rules',
    stk.STK_P_WEIGHT 'Act. Ing - It Br',
    stk.STK_S_WEIGHT 'Act. Ing - Lot C',
    stk.STK_P_WGHT_NAME 'Description - It Br',
    stk.STK_S_WGHT_NAME 'Description - Lot C',
    stk.STK_BARCODE 'Barcode',
    STK2.STK_SELLPRICE1 'Selling Price 1 - PRICE WITH BONUS',
    STK2.STK_SELLPRICE2 'Selling Price 2 - NET PRICE',
    STK2.STK_SELLPRICE3 'Selling Price 3 - RETAIL LESS 1.5%'
FROM
    stk_stock stk
    INNER JOIN STK_STOCK_2 stk2 ON stk.stkcode = stk2.stkcode2
    INNER JOIN STK_STOCK3 stk3 ON stk.stkcode = stk3.stkcode3
WHERE
    stk.STK_DO_NOT_USE = 0