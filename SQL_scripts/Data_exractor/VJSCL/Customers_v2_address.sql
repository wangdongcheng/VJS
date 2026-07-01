SELECT
    AC.CUCODE AS 'Main - Code',
    AC.CUNAME AS 'Main - Name',
    ac.cu_do_not_use AS 'Info. - Inactive',
    AD.AD_CODE AS 'Addresses - Code',
    ac.CU_DEL_ADD_CDE as 'Addresses - Default Address Code',
    ad.AD_CONTACT AS 'Addresses - Contact',
    AD.AD_ADDRESS AS 'Addresses - Address',
    AD.AD_ADDRESS_USER1 AS 'Addresses - Town',
    AD.ad_address_user2 AS 'Addresses - County',
    AD.AD_POSTCODE AS 'Addresses - Postcode',
    ad.AD_COUNTRY AS 'Addresses - Country',
    AD.AD_E_MAIL AS 'Addresses - E-mail',
    ad.ad_cc_email AS 'Addresses - CC E-mail',
    ad.AD_ANALYSIS AS 'Addresses - SalesAnalysis',
    AD.ad_phone AS 'Addresses - Phone',
    ad.ad_mobile AS 'Addresses - Mobile',
    ad.ad_fax AS 'Addresses - Fax',
    ad.ad_delivery_route AS 'Addresses - Delivery Route',
    CASE
        WHEN ad.ad_inv_address = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Invoice',
    CASE
        WHEN ad.ad_del_address = 1 OR
        ad.ad_del_address_2 = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Delivery',
    CASE
        WHEN ad.ad_stat_address = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Statement',
    ad.AD_DO_NOT_USE AS 'Addresses - No Longer Use',
    ad.SL_AD_PRIMARY AS 'Address Primary ID'
FROM
    SL_ACCOUNTS AC
    INNER JOIN SL_ADDRESSES AD ON AC.CUCODE = AD.AD_ACC_CODE
ORDER BY
    2,
    4;




RETURN;

SELECT
    *
FROM
    vjsclcasesunits.dbo.SL_ACCOUNTS AC
    INNER JOIN vjsclcasesunits.dbo.SL_ADDRESSES AD ON AC.CUCODE = AD.AD_ACC_CODE
WHERE
    ac.cucode = '30abc001'