SELECT
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid,
    same.nr_matricula_same
FROM
         atendime atendime
    INNER JOIN cid ON cid.cd_cid = atendime.cd_cid
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    LEFT JOIN same ON same.cd_paciente = paciente.cd_paciente
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
    AND atendime.cd_cid LIKE 'C51%'
GROUP BY
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid,
    same.nr_matricula_same
ORDER BY
    atendime.cd_cid
    
