SELECT
	s.STKCODE AS 'Main - Stock code',
	s.STKNAME AS 'Main - Description',
	s.stk_rtp_flag AS 'Main - Enable RTP',
	s.stk_baseprice AS 'Main - Sell Price',
	s.stk_costprice AS 'Main - Cost Price',
	s.stk_physical + s.stk_qtyprinted AS 'Main - Physical',
	-- s.stk_qtyprinted as 'Main - Deliveries to Update',
	s.stk_reserve_out AS 'Main - Allocated Stock',
	0 AS 'Main - Unallocated Orders',
	s.stk_physical - s.stk_reserve_out AS 'Main - Free',
	s.stk_order_in AS 'Main - Order In',
	s.stk_av_valu AS 'Main - Average Value',
	s.stk_min_qty AS 'Main - Minimum',
	s.stk_max_qty AS 'Main - Maximum',
	s.stk_bin_number AS 'Main - Bin Number',
	--- Sort Key tab
	s.stk_sort_key AS 'Sort Key - Main Category',
	s.stk_sort_key1 AS 'Sort Key - Brand Name',
	s.stk_sort_key2 AS 'Sort Key - Type',
	s.stk_sort_key3 AS 'Sort Key - Supplier',
	--- Info dialog
	CAST(s.stk_date_putin AS DATE) AS 'Info - Created On',
	CAST(s.stk_date_edited AS DATE) AS 'Info - Last Changed',
	s.stk_oldcode AS 'Info - Superseded by Code',
	s.stk_level AS 'Info - Level',
	s.stk_reverse_chrge_vat AS 'Info - Reverse Charge VAT applies',
	s.stk_do_not_use AS 'Info - Inactive',
	s.stk_www_publish AS 'Info - Publish on World Wide Web',
	--- EC Info dialog
	s.stk_ec_kilos AS 'EC Info - Net Mass kg',
	s.stk_ec_origin AS 'EC Info - Country of Origin',
	s.stk_ec_com_code AS 'EC Info - Commodity Code',
	s.stk_ec_sup_unit AS 'EC Info - Supplementary Units',
	s.stk_ec_sup_unit_type AS 'EC Info - Type (of Supplementary Units)',
	s.stk_service AS 'EC Info - Service',
	s.stk_place_of_supply_vat AS 'EC Info - Apply Place of Supply VAT Rules',
	--- Profit dialog
	s.STK_SALEVALUE AS 'Profit - Sale Value - Total',
	s.STK_COSTVALUE AS 'Profit - Cost of Sales - Total',
	s.STK_SALEVALUE - s.STK_COSTVALUE AS 'Profit - Profit - Total',
	(s.STK_SALEVALUE - s.STK_COSTVALUE) / NULLIF(s.STK_SALEVALUE, 0) * 100 AS 'Profit - Margin % - Total',
	s.STK_SALEVAL_PTD AS 'Profit - Sale Value - Period',
	s.STK_COSTVAL_PTD AS 'Profit - Cost of Sales - Period',
	s.STK_SALEVAL_PTD - s.STK_COSTVAL_PTD AS 'Profit - Profit - Period',
	(s.STK_SALEVAL_PTD - s.STK_COSTVAL_PTD) / NULLIF(s.STK_SALEVAL_PTD, 0) * 100 AS 'Profit - Margin % - Period',
	s.STK_SALEVAL_YTD AS 'Profit - Sale Value - Year',
	s.STK_COSTVAL_YTD AS 'Profit - Cost of Sales - Year',
	s.STK_SALEVAL_YTD - s.STK_COSTVAL_YTD AS 'Profit - Profit - Year',
	(s.STK_SALEVAL_YTD - s.STK_COSTVAL_YTD) / NULLIF(s.STK_SALEVAL_YTD, 0) * 100 AS 'Profit - Margin % - Year',
	--- Notes tab
	s.stk_notes AS 'Notes - Notes',
	--- Picture tab
	--- Weights tab
	s.stk_p_weight AS 'Weights - Excise EUR',
	s.stk_s_weight AS 'Weights - Excise Sell',
	s.stk_p_wght_name AS 'Weights - Description EUR',
	s.stk_s_wght_name AS 'Weights - Description Sell',
	S.STK_BARCODE AS 'Weights - Barcode',
	--- Custom tab
	s3.STK_USRCHAR10 as 'Custom - Stk Brand Class',
	--continue from here, 20260703_145308 done mark
	s3.stk_usrflag3 AS 'Custom - Delisted',
	s3.stk_usrflag1 AS 'Custom - Do Not Load',
	s3.stk_usrchar2 AS 'Custom - Comp. Division',
	s3.stk_usrchar5 AS 'Custom - Barcode',
	s3.stk_usrnum1 AS 'Custom - PO Min Qty',
	s3.stk_usrnum2 AS 'Custom - Commission',
	s3.stk_usrflag2 AS 'Custom - Order Process',
	s3.stk_usrchar12 AS 'Custom - Order Shelf Life',
	s3.STK_USRCHAR13 AS 'Custom - Sales MOQ (Min Ord Qty)',
	s3.STK_USRFLAG4 AS 'Custom - Pick List Large Bag',
	s3.STK_USRFLAG6 AS 'Custom - Exclude MHV Report',
	s3.STK_USRCHAR6 AS 'Custom - Brand Category',
	s3.STK_USRFLAG5 AS 'Custom - LCS Zero Value',
	s3.STK_USRFLAG7 AS 'Custom - ORI S Breed',
	s3.STK_USRFLAG9 AS 'Custom - Not Used 2',
	s3.STK_USRFLAG8 AS 'Custom - Sell Only cases',
	s3.STK_USRFLAG10 AS 'Custom - Not Used 3',
	s3.STK_USRCHAR7 AS 'Custom - BarcodeOutCase',
	s3.STK_USRCHAR8 AS 'Custom - Warehouse Locat',
	s3.STK_USRCHAR14 AS 'Custom - Dimensions',
	s3.STK_USRCHAR15 AS 'Custom - NotUsed',
	s3.STK_USRNUM3 AS 'Custom - DispUOM',
	s3.STK_USRNUM4 AS 'Custom - MinStkCoverage',
	s3.STK_USRNUM5 AS 'Custom - MaxStkCoverage',
	s3.STK_USRNUM6 AS 'Custom - Units / Pallet',
	s3.STK_USRNUM7 AS 'Custom - Units / Layer',
	s3.STK_USRCHAR16 AS 'Custom - Executive',
	s3.STK_USRCHAR17 AS 'Custom - Champion Categ',
	s3.STK_USRNUM9 AS 'Custom - Weight / Pallet',
	s3.STK_USRCHAR18 AS 'Custom - Categ Manager',
	--- Sell price table
	s2.STK_SANALYSIS1 AS 'Selling Price 1 - Analysis',
	s2.STK_SANALYSIS2 AS 'Selling Price 2 - Analysis',
	s2.STK_SANALYSIS3 AS 'Selling Price 3 - Analysis',
	s2.STK_SANALYSIS4 AS 'Selling Price 4 - Analysis',
	s2.STK_SANALYSIS5 AS 'Selling Price 5 - Analysis',
	s2.STK_SANALYSIS6 AS 'Selling Price 6 - Analysis',
	s2.STK_SANALYSIS7 AS 'Selling Price 7 - Analysis',
	s2.STK_SANALYSIS8 AS 'Selling Price 8 - Analysis',
	s2.STK_SANALYSIS9 AS 'Selling Price 9 - Analysis',
	s2.STK_SANALYSIS10 AS 'Selling Price 10 - Analysis',
	s2.STK_SELLPRICE1 'Selling Price 1 - RETAIL',
	s2.STK_SELLPRICE2 'Selling Price 2 - WHOLESALE',
	s2.STK_SELLPRICE3 'Selling Price 3 - W NET',
	s2.STK_SELLPRICE4 'Selling Price 4 - OFFER',
	s2.STK_SELLPRICE5 'Selling Price 5 - PET SHOP NET',
	s2.STK_SELLPRICE6 'Selling Price 6 - CONSUMER EXC VAT',
	s2.STK_SELLPRICE7 'Selling Price 7 - MUST-HAVES WEBSITE',
	s2.STK_SELLPRICE8 'Selling Price 8 - AGENT',
	s2.STK_SELLPRICE9 'Selling Price 9 - SUB_A RETAIL',
	s2.STK_SELLPRICE10 'Selling Price 10 - CONSUMER'
FROM
	STK_STOCK S
	INNER JOIN STK_STOCK3 S3 ON S.STKCODE = S3.STKCODE3
	INNER JOIN STK_STOCK_2 S2 ON S.STKCODE = S2.STKCODE2
WHERE
	s.stkcode = '20EYL6001102'
ORDER BY
	stkcode;

RETURN;

SELECT
	*
FROM
	svbeautytest.dbo.STK_STOCK S
	INNER JOIN svbeautytest.dbo.STK_STOCK3 S3 ON S.STKCODE = S3.STKCODE3
	INNER JOIN svbeautytest.dbo.STK_STOCK_2 S2 ON S.STKCODE = S2.STKCODE2
WHERE
	s.stkcode = '20EYL6001102';