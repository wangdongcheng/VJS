-- server: VJSQL01
-- database: WINIT_VJSGROUP_895961
-- stored procedure: sp_CaseFillReport
PRINT 'just to research the sql, no need to execute this' 
RETURN;

USE [WINIT_VJSGROUP_895961]
GO
/****** Object:  StoredProcedure [dbo].[sp_CaseFillReport]    Script Date: 27/08/2025 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
ALTER PROCEDURE [dbo].[sp_CaseFillReport]    --     [sp_CaseFillReport] 'Sum(IsNull(TD.QuantityBU,0))','1=1',50,1,'admin'                                                                                                     
--DECLARE                      
@sortExpression  VARCHAR(100)='ItemCode DESC',                                                                                                    
@searchString VARCHAR(max)='1=1 AND  DATEDIFF(dd,TH.TrxDate,''2024-08-01'') <= 0  AND  DATEDIFF(dd,TH.TrxDate,''2024-08-30'') >= 0 ',                                                                                                                          
  
    
    
      
@maximumRows INT =50,                                                                                                                                           
@startRowIndex INT=0,                                                                  
@UserCode VARCHAR(100)='admin' ,      
@udt_FilterData as udt_FilterData readonly                                            
as                         
BEGIN              
              
Insert INTO tblErrorLog  (Err_Message,Err_Procedure,Err_Date)                    
Select    '@searchString::'+@searchString,'sp_CaseFillReport',Getdate()                              
      
select * INTO #FilterData from @udt_FilterData      
if not exists(select * from sys.tables where name ='tempFilterData ')      
BEGIN       
 select * INTo tempFilterData from @udt_FilterData                    
END      
Declare @Channel INT=0,@City INT=0,@Category INT=0,@Supplier INT=0    
,@Brand INT=0,@Agency INT=0      
      
if exists(select * from #FilterData where FilterName='Channel' )      
SET @Channel=1      
if exists(select * from #FilterData where FilterName='City')      
SET @City=1      
if exists(select * from #FilterData where FilterName='Category')      
SET @Category=1      
if exists(select * from #FilterData where FilterName='Supplier')      
SET @Supplier=1      
if exists(select * from #FilterData where FilterName='Brand')      
SET @Brand=1      
if exists(select * from #FilterData where FilterName='Agency')      
SET @Agency=1      
      
--Select * From (                    
              
select * INTO #ChildUser from dbo.udf_GetAllChildUsers(@UserCode,'All')                                  
                    
EXEC('select SU.Description Supplier,I.GroupLevel2 Brand,I.GroupLevel3 Category,I.GroupLevel6 Sector
,SUM(ISNULL(TD.FinalBU,0)*TD.PriceUsedLevel3) SaleAmount            
,Round(case WHEN SUM(ISNULL(TD.FinalBU,0)*TD.PriceUsedLevel3)=0 THEN 0 ELSE            
SUM((ISNULL(TD.FinalBU,0)-ISNULL(V.[Total Quantity Invoiced],0))*TD.PriceUsedLevel3)/SUM(ISNULL(TD.FinalBU,0)*TD.PriceUsedLevel3)*100.00 END,2) TotalValueLostPercentage            
,TD.ItemCode,I.Description ItemName,                          
  SUM(ISNULL(TD.FinalBU,0)) QuantityOrdered,SUM(ISNULL(V.[Total Quantity Invoiced],0)) QuantityInvoiced,                                        
CAST(ISNULL(SUM(ISNULL(V.[Total Quantity Invoiced],0))/ SUM(ISNULL(TD.FinalBU,0))*100,0) AS DECIMAL(10,2)) as CaseFillRate,                        
SUM(ISNULL(TD.FinalBU,0)-ISNULL(V.[Total Quantity Invoiced],0)) as LostSales                     
,SUM((ISNULL(TD.FinalBU,0)-ISNULL(V.[Total Quantity Invoiced],0))*TD.PriceUsedLevel3) LostSaleAmount            
,TH.UserCode,TH.ClientCode,CD.ChannelCode,TD.TrxCode                   
into #Data          
from tblTrxDetail TD                      
Inner Join tblTrxHeader TH  On TH.TrxCode= TD.TrxCode                  
INNER JOIN (select  winITReference,SUM(ISNULL([Total Quantity Invoiced],0)) OdVal             
from tblSalesrep_SalesActuals_Brand_Customers_Invoices               
group by winITReference               
having SUM(ISNULL([Total Quantity Invoiced],0))>0              
) W ON W.winITReference=TD.TrxCode       
LEFT JOIN (              
select winITReference, stockcode,SUM(ISNULL([Total Quantity Invoiced],0)) [Total Quantity Invoiced] from tblSalesrep_SalesActuals_Brand_Customers_Invoices               
Group by winITReference, stockcode    ) V ON V.winITReference=TD.TrxCode AND TD.Itemcode=V.stockcode                
                    
inner join tblItem I On TD.ItemCode =I.Code                                        
                    
INNER JOIN #ChildUser CU On TH.UserCode COLLATE DATABASE_DEFAULT =CU.UserCode COLLATE DATABASE_DEFAULT                                      
                    
Inner Join tblCustomer C on C.Code=TH.ClientCode                    
                  
INNER JOIN tblCustomerDetail CD on CD.CustomerCode=C.Code                  
                  
inner join tblChannel CH on CH.Description = CD.ChannelCode              
            
Left join tblitemGroup SU on SU.Code=I.GroupLevel5 and SU.ItemGroupLevelId=4                                     
                    
--Left Outer join tblItemGroup IG on I.GroupLevel2=IG.Code                                 
                    
Where        
(      
('+@Channel+'=0 OR  CD.ChannelCode in (select FilterValue from #FilterData where FilterName=''Channel''))      
and ('+@City+'=0 OR  C.CityCode in (select FilterValue from #FilterData where FilterName=''City''))      
and ('+@Category+'=0 OR  I.GroupLevel3  in (select FilterValue from #FilterData where FilterName=''Category''))      
and ('+@Supplier+'=0 OR  I.GroupLevel5  in (select FilterValue from #FilterData where FilterName=''Supplier''))      
and ('+@Brand+'=0 OR  I.GroupLevel2 in (select FilterValue from #FilterData where FilterName=''Brand''))      
and ('+@Agency+'=0 OR  I.GroupLevel1  in (select FilterValue from #FilterData where FilterName=''Agency''))      
) and       
TD.FinalBU>0                     
AND TH.TrxType=5 AND TH.TrxStatus in (200) /*(100,200,-200,-300,-400)*/ AND '+@SearchString+'                     
GROUP BY TD.ItemCode,I.Description,TH.UserCode,TH.ClientCode,CD.ChannelCode,TD.TrxCode             
 ,SU.Description ,I.GroupLevel2 ,I.GroupLevel3,I.GroupLevel6                 
                   
Select * From (                    
 select Row_Number() over(order by '+@sortExpression+') RowNum,* from                   
 #Data ) As T Where RowNum between '+@StartRowIndex +' And ('+@MaximumRows+'+'+@StartRowIndex +'-1)                   
 ')                    
              
Drop table #ChildUser   
END     