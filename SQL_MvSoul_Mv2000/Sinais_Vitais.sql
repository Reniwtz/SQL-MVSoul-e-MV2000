-- Paciente
SELECT
    paciente.nm_paciente,
    paciente.cd_paciente,
    unid_int.ds_unid_int
FROM
         itcoleta_sinal_vital
    INNER JOIN coleta_sinal_vital ON coleta_sinal_vital.cd_coleta_sinal_vital = itcoleta_sinal_vital.cd_coleta_sinal_vital
    INNER JOIN pw_documento_clinico ON pw_documento_clinico.cd_documento_clinico = coleta_sinal_vital.cd_documento_clinico
    INNER JOIN atendime ON coleta_sinal_vital.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN leito ON atendime.cd_leito = leito.cd_leito
    INNER JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
WHERE
    pw_documento_clinico.tp_status IN ( 'FECHADO', 'ASSINADO' )
    AND pw_documento_clinico.cd_tipo_documento LIKE '17'
    AND unid_int.cd_unid_int LIKE '1'
    AND coleta_sinal_vital.dt_referencia BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
GROUP BY
    paciente.nm_paciente,
    paciente.cd_paciente,
    unid_int.ds_unid_int
ORDER BY
    paciente.nm_paciente;

-----------------------------------------------------------------------------------------------------------------------

-- Sinais 
WITH UltimaColeta AS (
    SELECT 
        paciente.nm_paciente,
        paciente.cd_paciente,
        sinal_vital.ds_sinal_vital,
        itcoleta_sinal_vital.valor,
        coleta_sinal_vital.data_coleta,
        unid_int.ds_unid_int,
        ROW_NUMBER() OVER (
            PARTITION BY paciente.cd_paciente, sinal_vital.cd_sinal_vital, TRUNC(coleta_sinal_vital.data_coleta) 
            ORDER BY coleta_sinal_vital.data_coleta DESC
        ) AS rn
    FROM 
        itcoleta_sinal_vital
        INNER JOIN coleta_sinal_vital ON coleta_sinal_vital.cd_coleta_sinal_vital = itcoleta_sinal_vital.cd_coleta_sinal_vital
        INNER JOIN sinal_vital ON sinal_vital.cd_sinal_vital = itcoleta_sinal_vital.cd_sinal_vital
        INNER JOIN pw_documento_clinico ON pw_documento_clinico.cd_documento_clinico = coleta_sinal_vital.cd_documento_clinico
        INNER JOIN atendime ON coleta_sinal_vital.cd_atendimento = atendime.cd_atendimento
        INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
        INNER JOIN leito ON atendime.cd_leito = leito.cd_leito
        INNER JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
    WHERE 
        pw_documento_clinico.tp_status IN ('FECHADO', 'ASSINADO')
        AND pw_documento_clinico.cd_tipo_documento LIKE '17'
        AND coleta_sinal_vital.dt_referencia BETWEEN TO_DATE('31/12/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
)
SELECT 
    nm_paciente, 
    cd_paciente, 
    ds_sinal_vital, 
    valor, 
    data_coleta, 
    ds_unid_int
FROM UltimaColeta
WHERE rn = 1
ORDER BY nm_paciente, data_coleta;
