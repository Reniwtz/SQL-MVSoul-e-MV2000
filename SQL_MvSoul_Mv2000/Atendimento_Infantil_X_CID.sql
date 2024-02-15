SELECT
    atendime.cd_cid,
    ds_cid,
    COUNT(*)
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN cid ON cid.cd_cid = atendime.cd_cid
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/01/24', 'DD/MM/YY')
    AND months_between(sysdate, dt_nascimento) / 12 < 15
    AND cid.cd_cid LIKE '%C%'
GROUP BY
    atendime.cd_cid,
    ds_cid
ORDER BY
    COUNT(*) DESC;

