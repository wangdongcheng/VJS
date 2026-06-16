begin transaction;
update stk_stock
set stk_order_in = 0
where stkcode in
(
'20CLA01243300',
'20CLA80071201',
-- '20CLA80077133S',
'20CLA80082061',
'20CLA80082069',
'20CLA80082070',
'20CLA80083076',
'20CLA80095460',
'20CLA80098991',
'20CLA80101831',
'20CLA80102843REG',
'20CLA80102844',
'20CLA80104074'
);
commit transaction;

select 
b.stkcode,
b.stk_physical l_physical,
bt.stk_physical t_physical,
b.STK_PHYSICAL-bt.STK_PHYSICAL as physical_diff,
b.STK_ORDER_IN l_order_in,
bt.STK_ORDER_IN t_order_in,
b.stk_order_in - bt.stk_order_in as order_in_diff,
b.STK_QTYPRINTED l_qtyprinted,
bt.STK_QTYPRINTED t_qtyprinted,
b.STK_QTYPRINTED - bt.STK_QTYPRINTED as qtyprinted_diff,
b.STK_RESERVE_OUT l_reserve_out,
bt.STK_RESERVE_OUT t_reserve_out,
b.STK_RESERVE_OUT - bt.STK_RESERVE_OUT as reserve_out_diff

from stk_stock b inner join [SVBeautyTest].[dbo].[stk_stock] bt on b.stkcode = bt.stkcode
where 
-- b.STK_DO_NOT_USE = 0 and (
-- b.STK_ORDER_IN <> bt.STK_ORDER_IN or
-- b.stk_physical <> bt.stk_physical or
-- b.STK_QTYPRINTED <> bt.STK_QTYPRINTED or
-- b.STK_RESERVE_OUT <> bt.STK_RESERVE_OUT 
-- )

b.stkcode in
(
'20CLA01243300',
'20CLA80071201',
-- '20CLA80077133S',
'20CLA80082061',
'20CLA80082069',
'20CLA80082070',
'20CLA80083076',
'20CLA80095460',
'20CLA80098991',
'20CLA80101831',
'20CLA80102843REG',
'20CLA80102844',
'20CLA80104074'
)

return;
select * from sys_user where user_active = 1 


SELECT TOP (1000) [POD_HEADER_REF]
      ,[POD_ORDER_REF]
      ,[POD_TYPE]
      ,[POD_STATUS]
,pod_stock_code
  FROM [SVBeauty].[dbo].[POP_DETAIL]
  where pod_stock_code  in
(
'20CLA01243300',
'20CLA80071201',
'20CLA80077133S',
'20CLA80082061',
'20CLA80082069',
'20CLA80082070',
'20CLA80083076',
'20CLA80095460',
'20CLA80098991',
'20CLA80101831',
'20CLA80102843REG',
'20CLA80102844',
'20CLA80104074'
) 
and pod_status = 0


select *
from stk_stock
where stk_order_in <> 0;