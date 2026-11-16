USE [IBS001]
-- GO
-- /****** Object:  StoredProcedure [dbo].[xls_Sales_Details_QueryForPivot_v2]    Script Date: 11/16/2026 08:27:28 ******/
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

-- -- =============================================
-- -- Author:		David Spiteri
-- -- Create date: 01/07/2021
-- -- Amended:     24/10/2024
-- -- Description:	Excel Report
-- -- =============================================
-- ALTER PROCEDURE [dbo].[xls_Sales_Details_QueryForPivot_v2]
-- 	-- Add the parameters for the stored procedure here
-- 	@DATEFROM DATETIME,
-- 	@DATETO DATETIME
	
-- /*
-- exec [xls_Sales_Details_QueryForPivot_v2] '2020-01-01 00:00:00.000', '2020-01-15 00:00:00.000'
-- */
	
-- AS
-- BEGIN
-- 	-- SET NOCOUNT ON added to prevent extra result sets from
-- 	-- interfering with SELECT statements.
-- 	SET NOCOUNT ON;


SELECT 
CONVERT (varchar(10), (@DATEFROM), 103)  as DateFrom,
CONVERT (varchar(10), (@DATETO), 103)  as DateTo,
isnull(CONVERT (varchar(10), (T.THDate), 103) , CONVERT (varchar(10), (@DATETO), 103)) as 'Trans Date',
isnull((Year(T.THDate)), (Year(@DATETO))) as Year,
isnull((Month(T.THDate)), (Month(@DATETO))) as Month,
LQ.LQLocCode AS 'Loc Code',L.LocDesc AS 'Location', T.CliName,
S.StkGroup as 'Group',
S.StkCateg AS 'Category', C.CDesc AS 'Brand', S.StkCode AS 'Stk Code',S.StkDesc AS 'Stk Desc',
S.StkStatus AS 'Stk Status',S.StkSupplier AS 'Stk Supp Code',
CASE WHEN SL.SupName IS NULL THEN 'No Supplier' ELSE SL.SupName END as 'Supplier',
 '1' AS 'TTLNo. Stk Cards',
CASE WHEN LQ.LQQty > 0 THEN 1 ELSE 0 END AS 'No. of Stk Cards Qty>0',
CASE WHEN T.Sold IS NULL THEN 0 ELSE T.Sold END AS 'Units Sold',
CASE WHEN T.GrossSales IS NULL THEN 0 ELSE T.GrossSales END AS 'Sales Value In-VAT',
CASE WHEN T.GrossSales IS NULL THEN 0 ELSE T.GrossSales-T.TaxAmt END AS 'Sales Value Ex-VAT',
CASE WHEN T.TotCost IS NULL THEN 0 ELSE T.TotCost END AS 'Total Cost of Sales',
CASE WHEN T.GrossSales IS NULL OR T.GrossSales=0 OR (T.GrossSales - T.TaxAmt) = 0 THEN 0 ELSE (1-(T.TotCost/(T.GrossSales-T.TaxAmt))) END AS 'Margin',
LQ.LQQty AS 'Units In Stk',LQ.LQQty*S.StkAvgCost AS 'Stk Value',
CASE WHEN T.TotCost IS NULL OR TotCost=0 THEN 0 ELSE ((LQ.LQQty*S.StkAvgCost)/TotCost)*
(DATEDIFF(day, @DATEFROM, @DATETO) + 1) END AS 'Days Stk',
T.THTranCode AS 'Trans Type',
T.THSysRef AS 'Sys Ref.',
t.TLUserID AS 'UserID',
t.TLWorkstationID AS 'wsID'
FROM LocQty LQ 
INNER JOIN Stocks S ON S.StkCode=LQ.LQStkCode 
LEFT JOIN (SELECT TLLocCode,TLWorkstationID,TLUserID,TLRefCode, THDate,THCSCode,CliName, THTranCode,THSysRef,/*added TLWorkstationID,TLUserID as per Jeremy on 01/07/2021 and added THTranCode,THSysRef as per Jeremy on 22/10/2024*/
			SUM(CASE WHEN THTranCode IN ('CS', 'IN') THEN TLQty
				WHEN THTranCode IN ('CR','CN') THEN TLQty * -1
				else 0 END) AS 'Sold',
			SUM(CASE WHEN THTranCode IN ('CS', 'IN') THEN TLNetAmountF
				WHEN THTranCode IN ('CR','CN') THEN TLNetAmountF*-1
				ELSE 0 END) AS 'GrossSales',
			SUM(CASE WHEN THTranCode IN ('CS', 'IN') THEN TLTaxAmountF
				WHEN THTranCode IN ('CR','CN') THEN TLTaxAmountF*-1
				ELSE 0 END) AS 'TaxAmt',
			SUM(CASE WHEN THTranCode IN ('CS', 'IN') THEN TLUnitCost*TLQty
				WHEN THTranCode IN ('CR','CN') THEN TLUnitCost*TLQty*-1
				ELSE 0 END) AS 'TotCost'				
			FROM TranLine TL 
			INNER JOIN TranHead TH ON TL.TLSysRef=TH.THSysRef
			INNER JOIN Clients C ON TH.THCSCode=C.CliCode
			WHERE dbo.udf_formatdate(TH.THDate) BETWEEN 
			dbo.udf_formatdate(@DATEFROM) AND dbo.udf_formatdate(@DATETO)
			GROUP BY TLLocCode,TLWorkstationID,TLUserID,TLRefCode, THDate,THTranCode,THSysRef,THCSCode, CliName
			) T ON LQ.LQLocCode=T.TLLocCode AND LQ.LQStkCode=T.TLRefCode
LEFT OUTER JOIN Locations L ON LQ.LQLocCode=L.LocCode
LEFT OUTER JOIN Suppl SL ON SL.SupCode = S.StkSupplier
LEFT OUTER JOIN [dbo].[Colour] C ON StkColour=C.CCode
WHERE LQ.LQLocCode IN ('01','02','03',
/*'04', removed as per request from Jeremy on 10/12/2020*/
'05','06','07','08', '09') and THTranCode IN ('CS','IN','CR','CN')
GROUP BY t.THDate, LQ.LQLocCode,L.LocDesc,S.StkCateg,C.CDesc,S.StkCode,S.StkDesc,S.StkStatus,
S.StkSupplier,S.StkGroup, SL.SupName,LQ.LQQty,T.Sold,T.GrossSales,T.TaxAmt,S.StkAvgCost,T.TotCost,T.TLWorkstationID,T.TLUserID,T.THTranCode,T.THSysRef, T.CliName
ORDER BY T.THSysRef

END
