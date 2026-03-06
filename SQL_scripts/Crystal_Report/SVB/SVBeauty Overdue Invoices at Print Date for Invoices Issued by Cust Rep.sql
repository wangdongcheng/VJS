SELECT
    t.ST_COPYCUST,
    t.ST_TRANTYPE,
    t.ST_HEADER_REF,
    t.ST_DATE,
    t.ST_DUEDATE,
    t.ST_GROSS,
    t.ST_UNALLOCATED,
    a.CUNAME,
    a.CU_A_P_DAYS,
    a.CU_DUE_DAYS,
    a2.CU_USRFLAG5,
    a2.CU_USRFLAG6,
    a.CUUSER1
FROM
    "SVBeauty"."dbo"."SL_TRANSACTIONS" AS t
    INNER JOIN "SVBeauty"."dbo"."SL_ACCOUNTS" AS a
        ON t.ST_COPYCUST = a.CUCODE
    INNER JOIN "SVBeauty"."dbo"."SL_ACCOUNTS2" AS a2
        ON a.CUCODE = a2.CUCODE2
WHERE
    a2.CU_USRFLAG5 = 0
    AND t.ST_UNALLOCATED <> 0
    AND t.ST_DATE < {ts '2026-03-05 00:00:00'}
    AND (
        t.ST_TRANTYPE = 'ACR'
        OR t.ST_TRANTYPE = 'ADR'
        OR t.ST_TRANTYPE = 'CRN'
        OR t.ST_TRANTYPE = 'INV'
        OR t.ST_TRANTYPE = 'PAY'
    )
    AND a2.CU_USRFLAG6 = 0
    and t.ST_TRANTYPE = 'PAY'
ORDER BY
    a.CUUSER1,
    t.ST_COPYCUST,
    t.ST_DATE;


select *
from sl_transactions
where st_copycust in ('20PAM005')