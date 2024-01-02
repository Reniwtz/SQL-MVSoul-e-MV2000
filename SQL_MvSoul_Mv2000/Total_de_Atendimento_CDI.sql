SELECT
    cid.cd_cid,
    COUNT(atendime.cd_cid)
FROM
         atendime atendime
    INNER JOIN cid ON atendime.cd_cid = cid.cd_cid
WHERE
    dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND atendime.cd_cid LIKE 'C85%'
GROUP BY
    cid.cd_cid,
    atendime.cd_cid
order by
    cid.cd_cid;
