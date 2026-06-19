-AMBULATÓRIAL
SELECT
    convenio.nm_convenio     AS convenio,
    atendime.cd_atendimento  AS atendimento,
    atendime.dt_atendimento  AS data_atendimento,
    paciente.nr_cpf          AS cpf,
    atendime.cd_paciente     AS cad,
    paciente.nm_paciente     AS nome,
    atendime.cd_pro_int      AS codigo_procedimento,
    pro_fat.ds_pro_fat       AS descricao,
    itreg_amb.qt_lancamento  AS quantidade_lancada,
    itreg_amb.vl_total_conta AS valor_total_conta,
    ori_ate.ds_ori_ate       AS origem_do_atendimento,
    reg_amb.cd_remessa       AS remessa
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN convenio ON convenio.cd_convenio = atendime.cd_convenio
    INNER JOIN pro_fat ON pro_fat.cd_pro_fat = atendime.cd_pro_int
    INNER JOIN ori_ate ON ori_ate.cd_ori_ate = atendime.cd_ori_ate
    LEFT JOIN itreg_amb ON atendime.cd_atendimento = itreg_amb.cd_atendimento
    LEFT JOIN reg_amb ON reg_amb.cd_reg_amb = itreg_amb.cd_reg_amb
WHERE
    atendime.cd_convenio IN ( 92, 95, 97, 98, 104,
                              105, 106, 108, 112, 113,
                              114, 115, 116, 117, 119,
                              120, 122, 123 )
    AND atendime.dt_atendimento  >= TO_DATE('01/04/2026', 'DD/MM/YYYY')
    AND atendime.dt_atendimento <  TO_DATE('30/04/2026', 'DD/MM/YYYY') + 1
GROUP BY
    convenio.nm_convenio,
    atendime.cd_atendimento,
    atendime.dt_atendimento,
    paciente.nr_cpf,
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_pro_int,
    pro_fat.ds_pro_fat,
    itreg_amb.qt_lancamento,
    itreg_amb.vl_total_conta,
    ori_ate.ds_ori_ate,
    reg_amb.cd_remessa
ORDER BY
    atendime.dt_atendimento DESC,
    convenio.nm_convenio
 
 
--INTERNAÇÃO
SELECT
    convenio.nm_convenio         AS convenio,
    atendime.cd_atendimento      AS atendimento,
    atendime.dt_atendimento      AS data_atendimento,
    paciente.nr_cpf              AS cpf,
    atendime.cd_paciente         AS cad,
    paciente.nm_paciente         AS nome,
    reg_fat.cd_pro_fat_realizado AS codigo_procedimento,
    pro_fat.ds_pro_fat           AS descricao,
    itreg_fat.qt_lancamento        AS quantidade_lancada,
    reg_fat.vl_total_conta       AS valor,
    ori_ate.ds_ori_ate           AS origem_do_atendimento,
    reg_fat.cd_remessa           AS remessa
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN convenio ON convenio.cd_convenio = atendime.cd_convenio
    INNER JOIN pro_fat ON pro_fat.cd_pro_fat = atendime.cd_pro_int
    INNER JOIN ori_ate ON ori_ate.cd_ori_ate = atendime.cd_ori_ate
    LEFT JOIN reg_fat ON reg_fat.cd_atendimento = atendime.cd_atendimento
    LEFT JOIN itreg_fat ON itreg_fat.cd_reg_fat = reg_fat.cd_reg_fat
WHERE
    atendime.cd_convenio IN ( 92, 95, 97, 98, 104,
                             105, 106, 108, 112, 113,
                             114, 115, 116, 117, 119,
                             120, 122, 123 )
    AND atendime.dt_atendimento  >= TO_DATE('01/04/2026', 'DD/MM/YYYY')
    AND atendime.dt_atendimento <  TO_DATE('30/04/2026', 'DD/MM/YYYY') + 1
GROUP BY
    convenio.nm_convenio,
    atendime.cd_atendimento,
    atendime.dt_atendimento,
    paciente.nr_cpf,
    atendime.cd_paciente,
    paciente.nm_paciente,
    reg_fat.cd_pro_fat_realizado,
    pro_fat.ds_pro_fat,
    itreg_fat.qt_lancamento,
    reg_fat.vl_total_conta,
    reg_fat.cd_remessa,
    ori_ate.ds_ori_ate
ORDER BY
    convenio.nm_convenio
