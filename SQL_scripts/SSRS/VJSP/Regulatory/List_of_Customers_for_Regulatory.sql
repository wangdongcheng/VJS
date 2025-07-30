
declare @ActiveCustomer TABLE(value int);
INSERT INTO @ActiveCustomer
    (value)
values
    (0),
    (1);

SELECT SL.CUCODE, SL.CUSORT, SL.CUNAME, SLA.AD_ADDRESS, SLA.AD_ADDRESS_USER1, SLA.AD_PHONE, 
case SL.CU_DO_NOT_USE when 0 then 0 else 1 end as 'Status'
FROM SL_ACCOUNTS SL
    INNER JOIN SL_ADDRESSES SLA ON SL.CUCODE=SLA.AD_ACC_CODE AND SL.CU_DEL_ADD_CDE=SLA.AD_CODE
WHERE SL.CU_DO_NOT_USE in (select value from @ActiveCustomer);