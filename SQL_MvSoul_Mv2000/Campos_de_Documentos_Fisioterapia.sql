SELECT
    pw_documento_clinico.cd_paciente    AS cad,
    paciente.nm_paciente                AS nome_do_paciente,
    pw_documento_clinico.cd_atendimento AS atendimento,
    pw_documento_clinico.nm_documento   AS tipo_de_documento,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_ESPONTANEO_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'RESPIRANDO EM ESPONTÂNEO'
        END
    )                                   AS espontâneo,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_PRONGA_NASAL_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'RESPIRANDO EM PRONGA NASAL'
        END
    )                                   AS pronga_nasal,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_VENTURI_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'RESPIRANDO EM COMPROMETIDO'
        END
    )                                   AS venturi,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_MASCARA_RESERV_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'RESPIRANDO EM MÁSCARA COM RESERVATÓRIO'
        END
    )                                   AS máscara_com_reservatório,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_VNI_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'RESPIRANDO EM VNI'
        END
    )                                   AS vni,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_VMI_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'RESPIRANDO EM VMI'
        END
    )                                   AS vmi,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_TOT_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'RESPIRANDO EM TOT'
        END
    )                                   AS tot,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_TQT_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'RESPIRANDO EM TQT'
        END
    )                                   AS tqt,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_DRENO_DIREITA_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'DRENO TORACICO A DIREITA'
        END
    )                                   AS dreno_toracico_direito,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_FR_VNI_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'CONDUTA FR VNI'
        END
    )                                   AS fr_vni,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_FR_DESMAME_TRE_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'CONDUTA FR DESMAME'
        END
    )                                   AS fr_desmame,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_FR_EXTUBACAO_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'CONDUTA FR EXTUBAÇÃO'
        END
    )                                   AS fr_extubação,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_FM_SEDESTACAO_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'CONDUTA FM SEDESTAÇÃO'
        END
    )                                   AS fm_sedestação,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'CONDUTA FM BEIRA LEITO'
        END
    )                                   AS fm_beira_leito,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_FM_NA_POLTRONA_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'CONDUTA FM NA POLTRONA'
        END
    )                                   AS fm_na_poltrona,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_FM_BIPEDEST_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'CONDUTA FM BIPEDESTAÇÃO'
        END
    )                                   AS fm_bipedestação,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CK_FM_DEAMBULACAO_EVO_FISIO_INT_1'
                 AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' THEN
                'CONDUTA FM DEAMBULAÇÃO'
        END
    )                                   AS fm_deambulação
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
    AND editor_campo.ds_identificador IN ( 'CK_ESPONTANEO_EVO_FISIO_INT_1', 'CK_PRONGA_NASAL_EVO_FISIO_INT_1', 'CK_VENTURI_EVO_FISIO_INT_1',
    'CK_VNI_EVO_FISIO_INT_1', 'CK_VMI_EVO_FISIO_INT_1',
                                           'CK_TOT_EVO_FISIO_INT_1', 'CK_TQT_EVO_FISIO_INT_1', 'CK_DRENO_DIREITA_EVO_FISIO_INT_1', 'CK_FR_VNI_EVO_FISIO_INT_1',
                                           'CK_FR_DESMAME_TRE_EVO_FISIO_INT_1',
                                           'CK_FR_EXTUBACAO_EVO_FISIO_INT_1', 'CK_FM_SEDESTACAO_EVO_FISIO_INT_1', 'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_INT_1',
                                           'CK_FM_NA_POLTRONA_EVO_FISIO_INT_1', 'CK_FM_BIPEDEST_EVO_FISIO_INT_1',
                                           'CK_FM_DEAMBULACAO_EVO_FISIO_INT_1' )
GROUP BY
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento;
