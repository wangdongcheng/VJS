SELECT
    pl.sucode AS 'Main - Code',
    pl.suname AS 'Main - Name',
    pl.su_do_not_use AS 'Info. - Inactive',
    AD.pl_AD_CODE AS 'Addresses - Code',
    pl.sU_DEL_ADD_CDE AS 'Addresses - Default Address Code',
    ad.pl_AD_CONTACT AS 'Addresses - Contact',
    AD.pl_AD_ADDRESS AS 'Addresses - Address',
    AD.pl_AD_ADDRESS_USER1 AS 'Addresses - Town',
    AD.pl_ad_address_user2 AS 'Addresses - County',
    AD.pl_AD_POSTCODE AS 'Addresses - Postcode',
    ad.pl_AD_COUNTRY AS 'Addresses - Country',
    AD.pl_AD_EMAIL AS 'Addresses - E-mail',
    ad.pl_ad_cc_email AS 'Addresses - CC E-mail',
    ad.pl_AD_ANALYSIS AS 'Addresses - Purchase Analysis',
    AD.pl_ad_phone AS 'Addresses - Phone',
    ad.pl_ad_mobile AS 'Addresses - Mobile',
    ad.pl_ad_fax AS 'Addresses - Fax',
    CASE
        WHEN ad.pl_ad_inv_add = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Order',
    CASE
        WHEN ad.pl_ad_del_add = 1 OR
        ad.pl_ad_del_address_2 = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Delivery',
    CASE
        WHEN ad.pl_ad_stat_add = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Statement',
    CASE
        WHEN ad.pl_ad_rem_add = 1 THEN 'Yes'
        ELSE ''
    END AS 'Address for Remittance',
    ad.pl_AD_DO_NOT_USE AS 'Addresses - No Longer Use',
    ad.pl_AD_PRIMARY AS 'Address Primary ID'
FROM
    pl_ACCOUNTS pl
    INNER JOIN pl_ADDRESSES AD ON pl.sucode = AD.pl_AD_ACCCODE
ORDER BY
    pl.suname,
    ad.pl_ad_code;