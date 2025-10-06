SELECT D.DiscountName, DL.CustomerCondition, C.Name, DL.StockCondition, DL.StockPriceCondition, DL.TargetQtyFrom, DL.TargetQtyTo, dl.DiscountType, dl.Value, dl.Accumulative,
dl.Active, dl.MaxQtyToLimit, dl.IsDeleted
  FROM [Salestime].[dbo].[DiscountLines] DL
  INNER JOIN [dbo].[Discounts] D ON DL.DiscountId=D.Id
  LEFT JOIN [dbo].[Customers] C ON DL.CustomerCondition=C.CustomerCode
  WHERE DL.Active = 1 and DL.IsDeleted = 0
  ORDER BY 1
