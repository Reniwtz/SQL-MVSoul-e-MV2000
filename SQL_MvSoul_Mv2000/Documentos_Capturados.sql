SELECT
    pw_documento_clinico.cd_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.cd_usuario,
    pw_documento_clinico.dh_fechamento,
    pw_documento_clinico.nm_documento
FROM
         pw_documento_clinico pw_documento_clinico
    INNER JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    INNER JOIN atendime ON atendime.cd_atendimento = pw_documento_clinico.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
WHERE
    pw_documento_clinico.dh_referencia BETWEEN TO_DATE('17/11/2025', 'DD/MM/YYYY') AND TO_DATE('17/11/2025', 'DD/MM/YYYY')
    AND pw_editor_clinico.cd_documento LIKE '233'
    AND pw_documento_clinico.cd_documento_cancelado IS NULL
    AND paciente.cd_paciente LIKE '436593'
    AND pw_documento_clinico.cd_objeto LIKE '105'
    AND pw_documento_clinico.tp_status LIKE '%FECHADO%'
GROUP BY
     pw_documento_clinico.cd_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.cd_usuario,
    pw_documento_clinico.dh_fechamento,
    pw_documento_clinico.nm_documento;
