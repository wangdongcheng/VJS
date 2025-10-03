select SU_COUNTRY_CODE,* from vjscl.dbo.pl_accounts
where SU_COUNTRY_CODE != 'MLT';

select pop.POH_INV_DATE,pop.POH_ACCOUNT,pla.SU_COUNTRY_CODE,* 
from pop_header pop
inner join pl_accounts pla on pop.poh_account = pla.sucode
where pla.su_country_code != 'MLT'
order by 1 desc;



select * from stk_stock
where stk_date_putin > '2025-08-15 00:00:00.000'
or stk_date_edited > '2025-08-15 00:00:00.000';

select *
from sl_addresses addr
where addr.AD_ACC_CODE = '30CRI003';