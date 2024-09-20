
SELECT
    *
FROM
    dbamv.cid_sus
WHERE
        cd_cid = 'C840'
    AND trunc(p_compet) BETWEEN dt_validade_inicial AND nvl(dt_validade_final, sysdate);


SELECT
    *
FROM
    dbamv.cid_sus
WHERE
    cd_cid IN ( 'C831', 'C857', 'C887', 'C827', 'C842',
                'D470', 'C821', 'C830', 'C841', 'C843',
                'C844', 'C829', 'C845', 'D479', 'C820',
                'C840', 'C859', 'C883', 'C889' )
    AND dt_validade_final IS NULL
