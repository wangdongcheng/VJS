SELECT
  AC.CUCODE AS 'Customer Code',
  AC.CUNAME AS 'Name',
  AC2.CU_CONTACT_FIRSTNAME AS 'First Name',
  AC2.CU_CONTACT_SURNAME AS 'Surname',
  AC.CU_EMAIL AS 'Billing Email',
  AC.CUPHONE AS 'Billing Phone1',
  AC.CUADDRESS AS 'Billing Address L1',
  AC.CU_ADDRESS_USER1 AS 'Billing City',
  AC.CU_COUNTRY_CODE AS 'Billing Country Code',
  AC.CU_COUNTRY AS 'Billing Country',
  AC.CUPOSTCODE AS 'Billing Postal Code',
  AC.CUSORT AS 'Customer Type',
  P.PriceName AS 'Price Key',
  AC.CUUSER3 AS 'Pay Method',
  CASE
    WHEN AC.CU_TERMS = 'CASH' OR
    AC.CU_TERMS = 'CASH SALE' THEN 'COD'
    WHEN UPPER(LTRIM(RTRIM(AC.CU_TERMS))) LIKE '% DAYS' THEN CONCAT(
      CASE
        WHEN LEN(
          LEFT(
            AC.CU_TERMS,
            CHARINDEX(' ', AC.CU_TERMS + ' ') - 1
          )
        ) = 1 THEN '0'
        ELSE ''
      END,
      LEFT(
        AC.CU_TERMS,
        CHARINDEX(' ', AC.CU_TERMS + ' ') - 1
      ),
      'D'
    )
    ELSE AC.CU_TERMS
  END AS 'Terms',
  AC.CUCURRENCYCODE AS 'Currency',
  'MT' + CU_VAT_REG_NO AS 'Tax Registration ID',
  AC.CU_COMPANY_REG_NUMBER AS 'Company Reg. ID',
  CASE
    WHEN AC.CU_COUNTRY_CODE = 'MT' THEN 'LOCVAT'
    ELSE 'EUVAT'
  END AS 'Tax Zone',
  -- AD.AD_CODE AS 'Address Code',
  -- AD.AD_ADDRESS AS 'Shipping Address L1',
  -- AD.AD_ADDRESS_USER1 AS 'Shipping City',
  -- AD.AD_E_MAIL AS 'Ship Email',
  -- AD.AD_POSTCODE AS 'Shipping Postal Code',
  -- AD.AD_PHONE AS 'Ship Phone',
  -- AD.AD_COUNTRY AS 'Ship Country',
  -- address page details
  AD.AD_CODE AS 'Address Code',
  AD.AD_ADDRESS AS 'Address on Address Page',
  -- '' AS 'Shipping Address L2',
  AD.AD_ADDRESS_USER1 AS 'Town/City City on Address Page',
  AD.ad_address_user2 AS 'County on Address Page',
  AD.AD_POSTCODE AS 'Postal Code on Address Page',
  CASE
    WHEN ad.ad_cc_email IS NOT NULL AND
    ad.AD_CC_EMAIL != '' THEN CONCAT(ad.AD_E_MAIL, ';', ad.ad_cc_email)
    ELSE ad.AD_E_MAIL
  END AS 'Email Address on Address Page',
  -- ISNULL(ad.ad_cc_email, '') AS 'CC Email on Address Page',
  AD.ad_phone AS 'Phone on Address Page',
  ad.ad_mobile AS 'Mobile on Address Page',
  ad.ad_fax AS 'Fax on Address Page',
  ISNULL(ad.ad_delivery_route, '') AS 'Delivery Route',
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
  ad.SL_AD_PRIMARY AS 'Address Primary ID',
  'P092000' AS 'AR Account'
FROM
  SL_ACCOUNTS AC
  INNER JOIN SL_ACCOUNTS2 AC2 ON AC.CUCODE = AC2.CUCODE2
  INNER JOIN SL_ADDRESSES AD ON AC.CUCODE = AD.AD_ACC_CODE
  INNER JOIN (
    SELECT
      *
    FROM
      (
        SELECT
          CASE col
            WHEN 'STK_USRPRCKEY1' THEN '1'
            WHEN 'STK_USRPRCKEY2' THEN '2'
            WHEN 'STK_USRPRCKEY3' THEN '3'
            WHEN 'STK_USRPRCKEY4' THEN '4'
            WHEN 'STK_USRPRCKEY5' THEN '5'
            WHEN 'STK_USRPRCKEY6' THEN '6'
            WHEN 'STK_USRPRCKEY7' THEN '7'
            WHEN 'STK_USRPRCKEY8' THEN '8'
            WHEN 'STK_USRPRCKEY9' THEN '9'
            WHEN 'STK_USRPRCKEY10' THEN '10'
          END AS PriceKey,
          VALUE AS 'PriceName'
        FROM
          LANG_USERFIELDS UNPIVOT (
            VALUE FOR col IN (
              STK_USRPRCKEY1,
              STK_USRPRCKEY2,
              STK_USRPRCKEY3,
              STK_USRPRCKEY4,
              STK_USRPRCKEY5,
              STK_USRPRCKEY6,
              STK_USRPRCKEY7,
              STK_USRPRCKEY8,
              STK_USRPRCKEY9,
              STK_USRPRCKEY10
            )
          ) unpiv
      ) src
  ) P ON AC.CU_PRICE_KEY = P.PriceKey
WHERE
  AC.CU_DO_NOT_USE = 0
  -- add by paul 20260130_094128
  AND
  (
    ad.ad_del_address = 1 OR
    ad.ad_del_address_2 = 1 OR
    ad.AD_INV_ADDRESS = 1 OR
    ad.AD_STAT_ADDRESS = 1
  ) AND
  ad.AD_DO_NOT_USE = 0
  -- add end
ORDER BY
  AC.CUNAME,
  ad.ad_code;