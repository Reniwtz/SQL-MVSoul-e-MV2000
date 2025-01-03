SELECT
    leito.cd_leito     AS codigo_do_paciente,
    leito.ds_leito     AS nome_do_leito,
    mov_int.hr_mov_int AS horario_da_movimentacao
FROM
         leito leito
    INNER JOIN mov_int ON leito.cd_leito = mov_int.cd_leito
WHERE
    --leito.ds_leito LIKE '%UTI 00%'
    --AND leito.tp_situacao LIKE '%A%'
    mov_int.cd_atendimento LIKE '4041845'
GROUP BY
    leito.cd_leito,
    leito.ds_leito,
    mov_int.hr_mov_int
ORDER BY
    mov_int.hr_mov_int DESC,
    leito.ds_leito;

-----------------------------------------------------------------------------
SELECT
    mov_int.cd_atendimento                                      AS código_do_atendimento,
    paciente.cd_paciente                                        AS código_do_paciente,
    paciente.nm_paciente                                        AS nome_do_paciente,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12) AS idade,
    paciente.tp_sexo                                            AS genero,
    atendime.cd_procedimento                                    AS cdg_do_proced_sus,
    atendime.cd_pro_int                                         AS cdg_do_proced_conv_partic,
    leito.cd_leito                                              AS codigo_do_leito,
    leito.ds_leito                                              AS nome_do_leito,
    mov_int.hr_mov_int                                          AS horario_da_movimentacao,
    atendime.dt_alta                                            AS data_da_alta
FROM
         leito leito
    INNER JOIN mov_int ON leito.cd_leito = mov_int.cd_leito
    INNER JOIN atendime ON mov_int.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
WHERE
    leito.ds_leito LIKE '%UTI 00%'
    AND leito.tp_situacao LIKE '%A%'
    --mov_int.cd_convenio LIKE '1'
    AND mov_int.hr_mov_int BETWEEN TO_DATE('01/12/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
GROUP BY
    mov_int.cd_atendimento,
    paciente.cd_paciente,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12),
    paciente.tp_sexo,
    atendime.cd_procedimento,
    atendime.cd_pro_int,
    paciente.nm_paciente,
    leito.cd_leito,
    leito.ds_leito,
    mov_int.hr_mov_int,
    atendime.dt_alta
ORDER BY
    mov_int.cd_atendimento,
    mov_int.hr_mov_int DESC
