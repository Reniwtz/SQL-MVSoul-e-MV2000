SELECT
    atendime.cd_atendimento                                     AS atendimento,
    paciente.nm_paciente                                        AS nome_paciente,
    atendime.dt_alta                                            AS data_obito,
    paciente.dt_nascimento                                      AS data_nascimento,
    paciente.tp_sexo                                            AS sexo,
    ori_ate.ds_ori_ate                                          AS origem_atendimento,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12) AS idade
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
WHERE
    atendime.dt_alta BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/12/24', 'DD/MM/YY')
    AND atendime.tp_atendimento <> 'I'
    AND atendime.sn_obito = 'S'
GROUP BY
    atendime.cd_atendimento,
    paciente.nm_paciente,
    atendime.dt_alta,
    paciente.dt_nascimento,
    paciente.tp_sexo,
    ori_ate.ds_ori_ate,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12)
    
