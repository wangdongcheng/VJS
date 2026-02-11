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
    STK2.STK_SELLPRICE3 'Selling Price 3 - RETAIL LESS 1.5%',
    STK2.STK_SELLPRICE4 'Selling Price 4 - RETAIL LESS 2%',
    stk2.STK_SELLPRICE5 'Selling Price 5 - RETAIL LESS 3%',
    stk2.STK_SELLPRICE6 'Selling Price 6 - RETAIL LESS 5%',
    stk2.STK_SELLPRICE7 'Selling Price 7 - SPECIAL PRICE',
    stk2.STK_SELLPRICE8 'Selling Price 8 - TENDER PRICE',
    STK2.STK_SELLPRICE9 'Selling Price 9 - RETAIL +5%',
    STK2.STK_SELLPRICE10 'Selling Price 10 - CONS INCL VAT',
    STK3.STK_USRFLAG1 'Do NOT Load',
    stk3.STK_USRFLAG2 'Dangerous Drug',
    stk3.STK_USRCHAR1 'Sub Category',
    stk3.STK_USRFLAG3 'Fridge',
    stk3.STK_USRNUM1 'Supplier MOQ',
    stk3.STK_USRCHAR2 'CLASSIFICATION',
    STK3.STK_USRCHAR5 'Prescrip Status',
    stk3.STK_USRCHAR6 'Stock Class',
    stk3.STK_USRCHAR10 'BI Security',
    stk3.STK_USRCHAR15 'Brand Manager',
    stk3.STK_USRCHAR7 'Business Unit',
    stk3.STK_USRCHAR16 'Sales in Motion',
    stk3.STK_USRCHAR17 'Stk Analysis 3',
    stk3.STK_USRFLAG4 'Extended Credit',
    stk3.STK_USRFLAG5 'Is Kit',
    stk3.STK_USRFLAG6 'Pat. List Item',
    stk3.STK_USRFLAG8 'Non Saleable',
    stk3.STK_USRFLAG7 'Zero Value',
    stk3.STK_USRFLAG9 'Desig. Wholesal',
    stk3.STK_USRNUM2 'ExpiryDontBlock',
    stk3.STK_USRNUM3 'Commission',
    stk3.STK_USRCHAR18 'Storage Type'
FROM
    stk_stock stk
    INNER JOIN STK_STOCK_2 stk2 ON stk.stkcode = stk2.stkcode2
    INNER JOIN STK_STOCK3 stk3 ON stk.stkcode = stk3.stkcode3
WHERE
    stk.STK_DO_NOT_USE = 0
ORDER BY
    stk.stkname;