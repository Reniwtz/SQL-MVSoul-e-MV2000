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
    atendime.cd_cid                                             AS cid_da_admissao,
    cid.ds_cid                                                  AS descrição,
    atendime.cd_procedimento                                    AS cdg_do_proced_sus,
    procedimento_sus.ds_procedimento                            AS descrição,
    atendime.cd_pro_int                                         AS cdg_do_proced_conv_partic,
    pro_fat.ds_pro_fat                                          AS descrição,
    leito.cd_leito                                              AS codigo_do_leito,
    leito.ds_leito                                              AS nome_do_leito,
    atendime.hr_atendimento                                     AS data_do_atendimento,
    mov_int.hr_mov_int                                          AS horario_da_movimentacao,
    atendime.dt_alta_medica                                     AS data_da_alta,
    mot_alt.ds_mot_alt                                          AS tipo_de_alta
FROM
         leito leito
    INNER JOIN mov_int ON leito.cd_leito = mov_int.cd_leito
    INNER JOIN atendime ON mov_int.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    LEFT JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    LEFT JOIN pro_fat ON atendime.cd_pro_int = pro_fat.cd_pro_fat
    LEFT JOIN cid ON atendime.cd_cid = cid.cd_cid
    LEFT JOIN mot_alt ON atendime.cd_mot_alt = mot_alt.cd_mot_alt
WHERE
    leito.ds_leito LIKE '%UTI 00%'
    AND leito.tp_situacao LIKE '%A%'
    AND mov_int.hr_mov_int BETWEEN TO_DATE('01/12/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
GROUP BY
    mov_int.cd_atendimento,
    paciente.cd_paciente,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12),
    paciente.tp_sexo,
    atendime.cd_cid,
    cid.ds_cid,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    atendime.cd_pro_int,
    pro_fat.ds_pro_fat,
    paciente.nm_paciente,
    leito.cd_leito,
    leito.ds_leito,
    atendime.hr_atendimento,
    mov_int.hr_mov_int,
    atendime.dt_alta_medica,
    mot_alt.ds_mot_alt
UNION
SELECT
    mov_int.cd_atendimento                                      AS código_do_atendimento,
    paciente.cd_paciente                                        AS código_do_paciente,
    paciente.nm_paciente                                        AS nome_do_paciente,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12) AS idade,
    paciente.tp_sexo                                            AS genero,
    atendime.cd_cid                                             AS cid_da_admissao,
    cid.ds_cid                                                  AS descrição,
    atendime.cd_procedimento                                    AS cdg_do_proced_sus,
    procedimento_sus.ds_procedimento                            AS descrição,
    atendime.cd_pro_int                                         AS cdg_do_proced_conv_partic,
    pro_fat.ds_pro_fat                                          AS descrição,
    leito.cd_leito                                              AS codigo_do_leito,
    leito.ds_leito                                              AS nome_do_leito,
    atendime.hr_atendimento                                     AS data_do_atendimento,
    mov_int.hr_mov_int                                          AS horario_da_movimentacao,
    atendime.dt_alta_medica                                     AS data_da_alta,
    mot_alt.ds_mot_alt                                          AS tipo_de_alta
FROM
         leito leito
    INNER JOIN mov_int ON leito.cd_leito = mov_int.cd_leito
    INNER JOIN atendime ON mov_int.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    LEFT JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    LEFT JOIN pro_fat ON atendime.cd_pro_int = pro_fat.cd_pro_fat
    LEFT JOIN cid ON atendime.cd_cid = cid.cd_cid
    LEFT JOIN mot_alt ON atendime.cd_mot_alt = mot_alt.cd_mot_alt
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/12/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
    AND ( atendime.cd_leito LIKE '351'
          OR atendime.cd_leito LIKE '352'
          OR atendime.cd_leito LIKE '216'
          OR atendime.cd_leito LIKE '194'
          OR atendime.cd_leito LIKE '195'
          OR atendime.cd_leito LIKE '196'
          OR atendime.cd_leito LIKE '197'
          OR atendime.cd_leito LIKE '199'
          OR atendime.cd_leito LIKE '200' )
GROUP BY
    mov_int.cd_atendimento,
    paciente.cd_paciente,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12),
    paciente.tp_sexo,
    atendime.cd_cid,
    cid.ds_cid,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    atendime.cd_pro_int,
    pro_fat.ds_pro_fat,
    paciente.nm_paciente,
    leito.cd_leito,
    leito.ds_leito,
    atendime.hr_atendimento,
    mov_int.hr_mov_int,
    atendime.dt_alta_medica,
    mot_alt.ds_mot_alt
ORDER BY
    código_do_atendimento,
    horario_da_movimentacao DESC;
