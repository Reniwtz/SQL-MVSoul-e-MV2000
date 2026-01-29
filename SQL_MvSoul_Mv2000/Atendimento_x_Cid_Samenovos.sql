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

----------------------------------------------------------------------------------------------------------------
    
SELECT
    atendime.cd_paciente                                                        AS cad,
    same.nr_matricula_same                                                      AS same,
    paciente.nm_paciente                                                        AS nome,
    atendime.cd_cid                                                             AS cid,
    cid.ds_cid                                                                  AS descrição,
    paciente.nm_bairro                                                          AS bairro,
    cidade.nm_cidade                                                            AS cidade,
    trunc(months_between(atendime.dt_atendimento, paciente.dt_nascimento) / 12) AS idade_na_data_atendimento,
    tipo_sexo.nm_sexo                                                           AS sexo
FROM
         atendime atendime
    INNER JOIN cid ON cid.cd_cid = atendime.cd_cid
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    LEFT JOIN same ON same.cd_paciente = paciente.cd_paciente
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
    INNER JOIN tipo_sexo ON tipo_sexo.tp_sexo = paciente.tp_sexo
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/25', 'DD/MM/YY') AND TO_DATE('31/12/25', 'DD/MM/YY')
    AND atendime.cd_cid LIKE 'C51%'
    AND same.dt_cadastro BETWEEN TO_DATE('01/01/25', 'DD/MM/YY') AND TO_DATE('31/12/25', 'DD/MM/YY')
    AND nr_volume LIKE '1'
GROUP BY
    atendime.cd_paciente,
    same.nr_matricula_same,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid,
    paciente.nm_bairro,
    cidade.nm_cidade,
    trunc(months_between(atendime.dt_atendimento, paciente.dt_nascimento) / 12),
    tipo_sexo.nm_sexo
ORDER BY
    atendime.cd_paciente,
    atendime.cd_cid
    
