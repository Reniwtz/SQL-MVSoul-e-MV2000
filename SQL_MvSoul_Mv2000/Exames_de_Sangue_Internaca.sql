SELECT
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_editor_clinico.cd_documento,
    pw_documento_clinico.nm_documento
FROM
         pw_documento_clinico
    INNER JOIN paciente ON pw_documento_clinico.cd_paciente = paciente.cd_paciente
    INNER JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
WHERE
    cd_objeto LIKE '105'
    AND pw_documento_clinico.dh_fechamento BETWEEN ( '01/04/2023' ) AND ( '30/04/2023' )
    AND pw_editor_clinico.cd_documento LIKE '233'
