SELECT
    convenio.nm_convenio     AS convenio,
    atendime.cd_atendimento  AS atendimento,
    paciente.nr_cpf          AS cpf,
    atendime.cd_paciente     AS cad,
    paciente.nm_paciente     AS nome,
    itreg_amb.cd_pro_fat     AS código_procedimento,
    pro_fat.ds_pro_fat       AS descrição,
    itreg_amb.qt_lancamento  AS quantidade_lançada,
    itreg_amb.vl_total_conta AS valor
FROM
         itreg_amb itreg_amb
    INNER JOIN atendime ON atendime.cd_atendimento = itreg_amb.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN convenio ON convenio.cd_convenio = atendime.cd_convenio
    INNER JOIN pro_fat ON pro_fat.cd_pro_fat = itreg_amb.cd_pro_fat
WHERE
    itreg_amb.cd_convenio IN ( 92, 95, 97, 98, 104, 105, 106, 108 )
GROUP BY
    convenio.nm_convenio,
    atendime.cd_atendimento,
    paciente.nr_cpf,
    atendime.cd_paciente,
    paciente.nm_paciente,
    itreg_amb.cd_pro_fat,
    pro_fat.ds_pro_fat,
    itreg_amb.qt_lancamento,
    itreg_amb.vl_total_conta
ORDER BY
    convenio.nm_convenio;
    
--------------------------------------------------------------------------------
SELECT
    convenio.nm_convenio         AS convenio,
    atendime.cd_atendimento      AS atendimento,
    paciente.nr_cpf              AS cpf,
    atendime.cd_paciente         AS cad,
    paciente.nm_paciente         AS nome,
    reg_fat.cd_pro_fat_realizado AS código_procedimento,
    pro_fat.ds_pro_fat           AS descrição,
    reg_fat.vl_total_conta       AS valor
FROM
         reg_fat reg_fat
    INNER JOIN atendime ON atendime.cd_atendimento = reg_fat.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN convenio ON convenio.cd_convenio = atendime.cd_convenio
    INNER JOIN pro_fat ON pro_fat.cd_pro_fat = reg_fat.cd_pro_fat_realizado
WHERE
    reg_fat.cd_convenio IN ( 92, 95, 97, 98, 104, 105, 106, 108 )
GROUP BY
    convenio.nm_convenio,
    atendime.cd_atendimento,
    paciente.nr_cpf,
    atendime.cd_paciente,
    paciente.nm_paciente,
    reg_fat.cd_pro_fat_realizado,
    pro_fat.ds_pro_fat,
    reg_fat.vl_total_conta
ORDER BY
    convenio.nm_convenio;    
    
    
    
    
    
