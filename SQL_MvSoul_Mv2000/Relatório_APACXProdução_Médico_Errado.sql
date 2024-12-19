SELECT
    atendime.cd_atendimento,
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.dt_atendimento,
    ori_ate.ds_ori_ate,
    ser_dis.ds_ser_dis,
    atendime.cd_prestador,
    prestador.nm_prestador,
    atendime.cd_pro_int,
    pro_fat.ds_pro_fat,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN prestador ON prestador.cd_prestador = atendime.cd_prestador
    LEFT JOIN pro_fat ON atendime.cd_pro_int = pro_fat.cd_pro_fat
    INNER JOIN ori_ate ON ori_ate.cd_ori_ate = atendime.cd_ori_ate
    INNER JOIN ser_dis ON ser_dis.cd_ser_dis = atendime.cd_ser_dis
    LEFT JOIN procedimento_sus ON procedimento_sus.cd_procedimento = atendime.cd_procedimento
    LEFT JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = atendime.cd_procedimento
    LEFT JOIN fat_sia ON teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia
                         AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '09/2024'
WHERE
    dt_atendimento BETWEEN TO_DATE('01/10/2024', 'DD/MM/YYYY') AND TO_DATE('31/10/2024', 'DD/MM/YYYY')
    AND atendime.cd_prestador = '64'
    AND atendime.cd_paciente NOT IN (
        SELECT
            laudo_sia_apac.cd_paciente
        FROM
                 laudo_sia_apac
            INNER JOIN prestador ON prestador.cd_prestador = laudo_sia_apac.cd_prestador
        WHERE
            laudo_sia_apac.dt_competencia BETWEEN TO_DATE('01/08/2024', 'DD/MM/YYYY') AND TO_DATE('31/10/2024', 'DD/MM/YYYY')
            AND laudo_sia_apac.cd_prestador = '64'
    )
    AND ( atendime.cd_convenio LIKE '2'
          OR atendime.cd_convenio LIKE '39' )
    AND atendime.cd_paciente IN (
        SELECT
            laudo_sia_apac.cd_paciente
        FROM
                 laudo_sia_apac
            INNER JOIN prestador ON prestador.cd_prestador = laudo_sia_apac.cd_prestador
        WHERE
            laudo_sia_apac.dt_competencia BETWEEN TO_DATE('01/08/2024', 'DD/MM/YYYY') AND TO_DATE('31/10/2024', 'DD/MM/YYYY')
    )
GROUP BY
    atendime.cd_atendimento,
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.dt_atendimento,
    atendime.cd_ori_ate,
    ori_ate.ds_ori_ate,
    atendime.cd_ser_dis,
    ser_dis.ds_ser_dis,
    atendime.cd_prestador,
    prestador.nm_prestador,
    atendime.cd_pro_int,
    pro_fat.ds_pro_fat,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico
ORDER BY
    cd_atendimento;
    
    
    

---------------------------------------------------------------------------------------------------------------------------

SELECT
    atendime.cd_atendimento,
    atendime.cd_paciente,
    atendime.dt_atendimento,
    atendime.cd_ori_ate,
    ori_ate.ds_ori_ate,
    atendime.cd_ser_dis,
    ser_dis.ds_ser_dis,
    atendime.cd_paciente,
    atendime.cd_prestador,
    prestador.nm_prestador,
    atendime.cd_pro_int,
    pro_fat.ds_pro_fat,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico
FROM
         atendime atendime
    INNER JOIN prestador ON prestador.cd_prestador = atendime.cd_prestador
    LEFT JOIN pro_fat ON atendime.cd_pro_int = pro_fat.cd_pro_fat
    INNER JOIN ori_ate ON ori_ate.cd_ori_ate = atendime.cd_ori_ate
    INNER JOIN ser_dis ON ser_dis.cd_ser_dis = atendime.cd_ser_dis
    LEFT JOIN procedimento_sus ON procedimento_sus.cd_procedimento = atendime.cd_procedimento
    LEFT JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = atendime.cd_procedimento
    LEFT JOIN fat_sia 
    ON teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia 
       AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '09/2024'
WHERE
        dt_atendimento BETWEEN TO_DATE('01/07/2024', 'DD/MM/YYYY') AND TO_DATE('30/09/2024', 'DD/MM/YYYY')
    AND atendime.cd_prestador = '8963'
    AND ( atendime.cd_convenio LIKE '2'
          OR atendime.cd_convenio LIKE '39' )
   /* AND ( atendime.cd_pro_int LIKE '10101012'
          OR atendime.cd_procedimento LIKE '0301010072' )*/
    AND cd_paciente IN (
        SELECT
            laudo_sia_apac.cd_paciente
        FROM
                 laudo_sia_apac
            INNER JOIN prestador ON prestador.cd_prestador = laudo_sia_apac.cd_prestador
        WHERE
            laudo_sia_apac.dt_competencia BETWEEN TO_DATE('01/07/2024', 'DD/MM/YYYY') AND TO_DATE('30/09/2024', 'DD/MM/YYYY')
    )
GROUP BY
    atendime.cd_atendimento,
    atendime.cd_paciente,
    atendime.dt_atendimento,
    atendime.cd_ori_ate,
    ori_ate.ds_ori_ate,
    atendime.cd_ser_dis,
    ser_dis.ds_ser_dis,
    atendime.cd_paciente,
    atendime.cd_prestador,
    prestador.nm_prestador,
    atendime.cd_pro_int,
    pro_fat.ds_pro_fat,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico
ORDER BY
    cd_atendimento


    
    
