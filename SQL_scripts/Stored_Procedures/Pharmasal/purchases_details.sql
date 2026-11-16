DECLARE @DATEFROM date = '20250101';
DECLARE @DATETO date = '20261231';

SELECT 
CONVERT (varchar(10), (@DATEFROM), 103)  as DateFrom,
CONVERT (varchar(10), (@DATETO), 103)  as DateTo,
isnull(CONVERT (varchar(10), (T.THDate), 103) , CONVERT (varchar(10), (@DATETO), 103)) as 'Trans Date',
isnull((Year(T.THDate)), (Year(@DATETO))) as Year,
isnull((Month(T.THDate)), (Month(@DATETO))) as Month,
LQ.LQLocCode AS 'Loc Code',L.LocDesc AS 'Location',
S.StkGroup as 'Group',
S.StkCateg AS 'Category', C.CDesc AS 'Brand', S.StkCode AS 'Stk Code',S.StkDesc AS 'Stk Desc',
S.StkStatus AS 'Stk Status',S.StkSupplier AS 'Stk Suppl Code',
--SL.SupCode AS 'Stock Supplier Code',
CASE WHEN SL.SupName IS NULL THEN 'No Supplier' ELSE SL.SupName END as 'Creditor',
 '1' AS 'TTLNo. Stk Cards',
CASE WHEN LQ.LQQty > 0 THEN 1 ELSE 0 END AS 'No. of Stk Cards Qty>0',
CASE WHEN T.Purchased IS NULL THEN 0 ELSE T.Purchased END AS 'Units Purch.',
CASE WHEN T.GrossPurchases IS NULL THEN 0 ELSE T.GrossPurchases END AS 'Purch Value In-VAT',
CASE WHEN T.GrossPurchases IS NULL THEN 0 ELSE T.GrossPurchases-T.TaxAmt END AS 'Purch Value Ex-VAT',
CASE WHEN T.TotCost IS NULL THEN 0 ELSE T.TotCost END AS 'Total Purch Cost',
CASE WHEN T.GrossPurchases IS NULL OR T.GrossPurchases = 0 OR (T.GrossPurchases - T.TaxAmt) = 0 THEN 0 ELSE (1 - (T.TotCost / (T.GrossPurchases - T.TaxAmt))) 
END AS 'Margin',
LQ.LQQty AS 'Units In Stk', LQ.LQQty*S.StkAvgCost AS 'Stk Value',
CASE WHEN T.TotCost IS NULL OR T.TotCost=0 THEN 0 ELSE ((LQ.LQQty*S.StkAvgCost)/T.TotCost)*
(DATEDIFF(day, @DATEFROM, @DATETO) + 1) END AS 'Days Stk',
T.THTranCode AS 'Trans Type',
T.THSysRef AS 'Sys Ref.',
t.TLUserID AS 'UserID',
t.TLWorkstationID AS 'wsID'
FROM LocQty LQ 
INNER JOIN Stocks S ON S.StkCode=LQ.LQStkCode 
LEFT JOIN (SELECT TLLocCode,TLWorkstationID,TLUserID,TLRefCode, THDate,THCSCode,THTranCode,THSysRef, /*added TLWorkstationID,TLUserID,THTranCode,THSysRef as per Jeremy on 22/10/2024*/
			SUM(CASE WHEN THTranCode IN ('CP', 'PI') THEN TLQty
				WHEN THTranCode IN ('PR','RE') THEN TLQty * -1
				else 0 END) AS 'Purchased',
			SUM(CASE WHEN THTranCode IN ('CP', 'PI') THEN TLNetAmountF
				WHEN THTranCode IN ('PR','RE') THEN TLNetAmountF*-1
				ELSE 0 END) AS 'GrossPurchases',
			SUM(CASE WHEN THTranCode IN ('CP', 'PI') THEN TLTaxAmountF
				WHEN THTranCode IN ('PR','RE') THEN TLTaxAmountF*-1
				ELSE 0 END) AS 'TaxAmt',
			SUM(CASE WHEN THTranCode IN ('CP', 'PI') THEN TLUnitCost*TLQty
				WHEN THTranCode IN ('PR','RE') THEN TLUnitCost*TLQty*-1
				ELSE 0 END) AS 'TotCost'				
			FROM TranLine TL 
			INNER JOIN TranHead TH ON TL.TLSysRef=TH.THSysRef
			WHERE dbo.udf_formatdate(TH.THDate) BETWEEN 
			dbo.udf_formatdate(@DATEFROM) AND dbo.udf_formatdate(@DATETO)
			GROUP BY TLLocCode,TLWorkstationID,TLUserID,THTranCode,THSysRef,
			TLRefCode, THDate,THCSCode
			) T ON LQ.LQLocCode=T.TLLocCode AND LQ.LQStkCode=T.TLRefCode
LEFT OUTER JOIN Locations L ON LQ.LQLocCode=L.LocCode
LEFT OUTER JOIN Suppl SL ON SL.SupCode = T.THCSCode
LEFT OUTER JOIN [dbo].[Colour] C ON StkColour=C.CCode
WHERE LQ.LQLocCode IN (
    '01','02','03',
-- '04'--, removed as per request from Jeremy on 10/12/2020*/
'05','06','07','08', '09'
) and SL.SupCode NOT IN ('------') and THTranCode IN ('PI','CP','PR','RE')
GROUP BY t.THDate, LQ.LQLocCode,L.LocDesc,S.StkCateg,C.CDesc,S.StkCode,S.StkDesc,S.StkStatus,
S.StkSupplier,S.StkGroup, SL.SupName,LQ.LQQty,T.Purchased,T.GrossPurchases,T.TaxAmt,S.StkAvgCost,T.TotCost,T.TLWorkstationID,T.TLUserID,T.THTranCode,T.THSysRef
ORDER BY T.THSysRef