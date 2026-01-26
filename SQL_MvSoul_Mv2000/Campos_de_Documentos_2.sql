SELECT
    pw_documento_clinico.cd_paciente    AS cad,
    paciente.nm_paciente                AS nome_do_paciente,
    pw_documento_clinico.cd_atendimento AS atendimento,
    pw_documento_clinico.nm_documento   AS tipo_de_documento,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'TX_ESTAD_BOM_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'BOM'
        END
    )                                   AS bom,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'TX_ESTAD_REGULAR_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'REGULAR'
        END
    )                                   AS regular,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'TX_COMPROMETIDO_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'COMPROMETIDO'
        END
    )                                   AS comprometido,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'TX_GRAVE_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'GRAVE'
        END
    )                                   AS grave,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'TX_GRAVISSIMO_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'GRAVISSIMO'
        END
    )                                   AS gravissimo
FROM
         pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
    JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
WHERE
        pw_documento_clinico.cd_atendimento = '4307107'
    AND pw_editor_clinico.cd_documento = '384'
    AND pw_documento_clinico.cd_objeto = '261'
    AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    AND pw_documento_clinico.cd_usuario LIKE '%TANIA.SANTOS%'
    AND editor_campo.ds_identificador IN ( 'TX_ESTAD_BOM_EVO_FISIO_INT_1', 'TX_ESTAD_REGULAR_EVO_FISIO_INT_1', 'TX_COMPROMETIDO_EVO_FISIO_INT_1',
    'TX_GRAVE_EVO_FISIO_INT_1', 'TX_GRAVISSIMO_EVO_FISIO_INT_1' )
GROUP BY
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento;
