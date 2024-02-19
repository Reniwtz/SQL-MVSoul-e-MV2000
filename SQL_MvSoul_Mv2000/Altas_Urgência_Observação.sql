-- Altas
-- Altas
SELECT
    atendime.cd_paciente                                        AS paciente,
    paciente.nm_paciente                                        AS nome_paciente,
    atendime.cd_atendimento                                     AS atendimento,
    atendime.dt_alta                                            AS data_alta,
    paciente.dt_nascimento                                      AS data_nascimento,
    paciente.tp_sexo                                            AS sexo,
    ori_ate.ds_ori_ate                                          AS origem_atendimento,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12) AS idade,
    convenio.nm_convenio                                        AS convênio
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN prestador ON prestador.cd_prestador = atendime.cd_prestador
WHERE
    atendime.dt_alta BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/01/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/02/23', 'DD/MM/YY') AND TO_DATE('28/02/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/03/23', 'DD/MM/YY') AND TO_DATE('31/03/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/04/23', 'DD/MM/YY') AND TO_DATE('30/04/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/05/23', 'DD/MM/YY') AND TO_DATE('31/05/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/06/23', 'DD/MM/YY') AND TO_DATE('30/06/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/07/23', 'DD/MM/YY') AND TO_DATE('31/07/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/08/23', 'DD/MM/YY') AND TO_DATE('31/08/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/09/23', 'DD/MM/YY') AND TO_DATE('30/09/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/10/23', 'DD/MM/YY') AND TO_DATE('31/10/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/11/23', 'DD/MM/YY') AND TO_DATE('30/11/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/12/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
    AND atendime.tp_atendimento LIKE 'U'
    AND atendime.sn_obito LIKE 'N'
    AND cd_servico <> '21'
GROUP BY
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_atendimento,
    atendime.dt_alta,
    paciente.dt_nascimento,
    paciente.tp_sexo,
    ori_ate.ds_ori_ate,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12),
    convenio.nm_convenio
ORDER BY
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12);
    
    
    
SELECT
    convenio.nm_convenio AS convênio
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN prestador ON prestador.cd_prestador = atendime.cd_prestador
WHERE
    atendime.dt_alta BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/01/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/02/23', 'DD/MM/YY') AND TO_DATE('28/02/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/03/23', 'DD/MM/YY') AND TO_DATE('31/03/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/04/23', 'DD/MM/YY') AND TO_DATE('30/04/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/05/23', 'DD/MM/YY') AND TO_DATE('31/05/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/06/23', 'DD/MM/YY') AND TO_DATE('30/06/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/07/23', 'DD/MM/YY') AND TO_DATE('31/07/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/08/23', 'DD/MM/YY') AND TO_DATE('31/08/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/09/23', 'DD/MM/YY') AND TO_DATE('30/09/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/10/23', 'DD/MM/YY') AND TO_DATE('31/10/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/11/23', 'DD/MM/YY') AND TO_DATE('30/11/23', 'DD/MM/YY')
        --atendime.dt_alta BETWEEN TO_DATE('01/12/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
    AND atendime.tp_atendimento LIKE 'U'
    AND atendime.sn_obito LIKE 'N'
    AND atendime.cd_servico <> '21'
    AND atendime.cd_convenio LIKE '2'
    convenio.nm_convenio
ORDER BY
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12);
