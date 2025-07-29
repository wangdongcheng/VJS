--- SQL script to update brand ordering report for Power BI
--- This script updates the stock information in the database based on the data from an Excel sheet.
--- import the Excel sheet into a temporary table named [Sheet1$], then updates the relevant stock tables.

SELECT *
FROM [VJSCL].[dbo].[STK_STOCK]
 
BEGIN TRAN 
UPDATE STK_STOCK_2
SET STK_SUPSTKCDE1=[Supplier code]
FROM STK_STOCK_2 S2
INNER JOIN [dbo].[Sheet1$] T ON S2.STKCODE2=T.[Stock Code]
 
COMMIT
 
BEGIN TRAN 
UPDATE STK_STOCK
SET STK_EC_SUP_UNIT=[Units per case],
STK_P_WEIGHT=[Weight value],
STK_P_WGHT_NAME=[Weight name]
FROM STK_STOCK S 
INNER JOIN [dbo].[Sheet1$] T ON S.STKCODE=T.[Stock Code]
 
COMMIT
 
BEGIN TRAN 
UPDATE STK_STOCK3
SET STK_USRFLAG2=1, 
STK_USRNUM1=[Minimum Order],
STK_USRNUM7=CASE WHEN [Layer] IS NULL THEN 0 ELSE [Layer] END, 
STK_USRNUM6=CASE WHEN [Full Pallet] IS NULL THEN 0 ELSE [Full Pallet] END,
STK_USRNUM4=CASE WHEN [Min Stock Coverage] IS NULL THEN 0 ELSE [Min Stock Coverage] END,
STK_USRNUM5=CASE WHEN [Max Stock Coverage] IS NULL THEN 0 ELSE [Max Stock Coverage] END,
STK_USRNUM8=CASE WHEN [CBM / Unit] IS NULL THEN 0 ELSE [CBM / Unit] END
FROM STK_STOCK3 S3
INNER JOIN [dbo].[Sheet1$] T ON S3.STKCODE3=T.[Stock Code]
 
COMMIT