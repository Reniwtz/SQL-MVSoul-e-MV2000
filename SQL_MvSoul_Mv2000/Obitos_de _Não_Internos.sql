SELECT
    aten.cd_atendimento                                    AS atendimento,
    pac.nm_paciente                                        AS nome_paciente,
    dt_alta                                                AS data_obito,
    pac.dt_nascimento                                      AS data_nascimento,
    tp_sexo                                                AS sexo,
    ori.ds_ori_ate                                         AS origem_atendimento,
    trunc(months_between(sysdate, pac.dt_nascimento) / 12) AS idade
FROM
         atendime aten
    INNER JOIN paciente pac ON aten.cd_paciente = pac.cd_paciente
    INNER JOIN ori_ate  ori ON aten.cd_ori_ate = ori.cd_ori_ate
WHERE
    TO_DATE(dt_alta, 'DD/MM/YY') BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/12/24', 'DD/MM/YY')
    AND tp_atendimento <> 'I'
    AND sn_obito = 'S'
GROUP BY
    aten.cd_atendimento,
    pac.nm_paciente,
    dt_alta,
    pac.dt_nascimento,
    tp_sexo,
    ori.ds_ori_ate,
    trunc(months_between(sysdate, pac.dt_nascimento) / 12)
