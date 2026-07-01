select

    ac.cucode AS 'Main - Code',
    ac.cuname AS 'Main - Name',
    ac.cu_on_stop as 'Main - On Stop',
    ac.cuaddress as 'Main - Address',
    ac.cu_address_user1 as 'Main - Town',
    ac.cuphone as 'Main - Phone',
    ac.cu_address_user2 as 'Main - County',
    ac.cufax as 'Main - Fax',
    ac.cupostcode as 'Main - Postcode',
    ac.cu_country as 'Main - Country',
    ac.cu_email as 'Main - Email',
    ac.cucurrencycode as 'Main - Currency',
    ac.CU_MULTI_CURR as 'Main - Any Currency',
    ac.cuturnoverytd as 'Main - T/o YTD',
    ac.cubalance as 'Main - Balance',


 --- Contact tab   
    ac.cucontact


from sl_accounts ac