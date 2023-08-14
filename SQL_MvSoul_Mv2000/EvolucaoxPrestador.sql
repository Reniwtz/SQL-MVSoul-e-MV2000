SELECT
    cd_documento_clinico,
    cd_tipo_documento,
    cd_documento_digital,
    cd_paciente,
    cd_atendimento,
    cd_usuario,
    cd_prestador
FROM
    pw_documento_clinico
WHERE
    pw_documento_clinico.cd_prestador LIKE '8787'
    AND cd_tipo_documento LIKE '33'
    AND pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/07/2023', 'DD/MM/YYYY') AND TO_DATE('31/07/2023', 'DD/MM/YYYY')
