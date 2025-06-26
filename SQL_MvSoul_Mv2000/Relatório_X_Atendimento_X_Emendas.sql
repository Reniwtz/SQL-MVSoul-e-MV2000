SELECT
    atendime.dt_atendimento  AS data_atendimento,
    itreg_amb.cd_atendimento AS atendimento,
    atendime.cd_paciente     AS paciente,
    paciente.nm_paciente     AS nome_do_paciente,
    reg_amb.cd_convenio      AS convenio,
    convenio.nm_convenio     AS descricao_do_convenio,
    reg_amb.cd_remessa       AS remessa,
    itreg_amb.cd_pro_fat     AS codigo_do_procedimento,
    pro_fat.ds_pro_fat       AS descricao_do_procedimento,
    itreg_amb.vl_unitario    AS valor
FROM
         itreg_amb itreg_amb
    INNER JOIN reg_amb ON reg_amb.cd_reg_amb = itreg_amb.cd_reg_amb
    INNER JOIN pro_fat ON pro_fat.cd_pro_fat = itreg_amb.cd_pro_fat
    INNER JOIN convenio ON convenio.cd_convenio = reg_amb.cd_convenio
    INNER JOIN atendime ON atendime.cd_atendimento = itreg_amb.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
WHERE
    atendime.cd_convenio IN ( '92', '95', '97', '98' )
    AND atendime.dt_atendimento BETWEEN TO_DATE('01/09/2024', 'DD/MM/YYYY') AND TO_DATE('26/06/2025', 'DD/MM/YYYY')
    
GROUP BY
    atendime.dt_atendimento,
    itreg_amb.cd_atendimento,
    atendime.cd_paciente,
    paciente.nm_paciente,
    reg_amb.cd_convenio,
    convenio.nm_convenio,
    reg_amb.cd_remessa,
    itreg_amb.cd_pro_fat,
    pro_fat.ds_pro_fat,
    itreg_amb.vl_unitario
ORDER BY
    itreg_amb.cd_atendimento DESC
