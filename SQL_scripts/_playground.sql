select su_usrchar1,su_usrchar2,su_usrchar3,su_usrchar4,su_usrchar5,su_usrchar6,
su_usrchar7,su_usrchar8,* from VJSCLCasesUnits.dbo.PL_ACCOUNTS2
where 
-- SU_COUNTRY_CODE = 'MLT'
SUCODE2='30bar001';


select su_country_code,su_country,* from pl_accounts 
where 
su_country_code != 'MLT'
;