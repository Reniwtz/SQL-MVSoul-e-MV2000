--Fisioterapia evolução de internação
WITH mapa AS (
    -- =========================
    -- RESPIRAÇÃO 
    -- =========================
    SELECT 'CK_ESPONTANEO_EVO_FISIO_INT_1'        AS id, 'RESPIRANDO EM ESPONTÂNEO'       AS txt, 'ESPONTANEO'          AS col FROM dual UNION ALL
    SELECT 'CK_PRONGA_NASAL_EVO_FISIO_INT_1'      AS id, 'RESPIRANDO EM PRONGA NASAL'     AS txt, 'PRONGA_NASAL'        AS col FROM dual UNION ALL
    SELECT 'CK_VENTURI_EVO_FISIO_INT_1'           AS id, 'RESPIRANDO EM COMPROMETIDO'     AS txt, 'VENTURI'             AS col FROM dual UNION ALL
    SELECT 'CK_MASCARA_RESERV_EVO_FISIO_INT_1'    AS id, 'MASCARA RESERVATÓRIO'           AS txt, 'MASCARA'             AS col FROM dual UNION ALL
    SELECT 'CK_VNI_EVO_FISIO_INT_1'               AS id, 'RESPIRANDO EM VNI'              AS txt, 'VNI'                 AS col FROM dual UNION ALL
    SELECT 'CK_VMI_EVO_FISIO_INT_1'               AS id, 'RESPIRANDO EM VMI'              AS txt, 'VMI'                 AS col FROM dual UNION ALL
    SELECT 'CK_TOT_EVO_FISIO_INT_1'               AS id, 'RESPIRANDO EM TOT'              AS txt, 'TOT'                 AS col FROM dual UNION ALL
    SELECT 'CK_TQT_EVO_FISIO_INT_1'               AS id, 'RESPIRANDO EM TQT'              AS txt, 'TQT'                 AS col FROM dual UNION ALL

    -- =========================
    -- DISPOSITIVOS
    -- =========================
    SELECT 'CK_DRENO_DIREITA_EVO_FISIO_INT_1'     AS id, 'DRENO TORACICO A DIREITA'       AS txt, 'DRENO_TOR_DIREITO'   AS col FROM dual UNION ALL

    -- =========================
    -- CONDUTAS - FR
    -- =========================
    SELECT 'CK_FR_VNI_EVO_FISIO_INT_1'             AS id, 'CONDUTA FR VNI'                AS txt, 'FR_VNI'              AS col FROM dual UNION ALL
    SELECT 'CK_FR_DESMAME_TRE_EVO_FISIO_INT_1'     AS id, 'CONDUTA FR DESMAME'            AS txt, 'FR_DESMAME'          AS col FROM dual UNION ALL
    SELECT 'CK_FR_EXTUBACAO_EVO_FISIO_INT_1'       AS id, 'CONDUTA FR EXTUBAÇÃO'          AS txt, 'FR_EXTUBACAO'        AS col FROM dual UNION ALL

    -- =========================
    -- CONDUTAS - FM
    -- =========================
    SELECT 'CK_FM_SEDESTACAO_EVO_FISIO_INT_1'       AS id, 'CONDUTA FM SEDESTAÇÃO'         AS txt, 'FM_SEDESTACAO'       AS col FROM dual UNION ALL
    SELECT 'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_INT_1'   AS id, 'CONDUTA FM BEIRA LEITO'        AS txt, 'FM_BEIRA_LEITO'      AS col FROM dual UNION ALL
    SELECT 'CK_FM_NA_POLTRONA_EVO_FISIO_INT_1'      AS id, 'CONDUTA FM NA POLTRONA'        AS txt, 'FM_NA_POLTRONA'      AS col FROM dual UNION ALL
    SELECT 'CK_FM_BIPEDEST_EVO_FISIO_INT_1'         AS id, 'CONDUTA FM BIPEDESTAÇÃO'       AS txt, 'FM_BIPEDESTACAO'     AS col FROM dual UNION ALL
    SELECT 'CK_FM_DEAMBULACAO_EVO_FISIO_INT_1'      AS id, 'CONDUTA FM DEAMBULAÇÃO'        AS txt, 'FM_DEAMBULACAO'      AS col FROM dual
),
base AS (
SELECT
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento,
    mapa.col,
    mapa.txt
FROM
         pw_documento_clinico pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
    JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
    JOIN mapa ON mapa.id = editor_campo.ds_identificador
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
WHERE
        pw_documento_clinico.cd_atendimento = '4307107'
    AND pw_editor_clinico.cd_documento = '384'
    AND pw_documento_clinico.cd_objeto = '261'
    AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    AND pw_documento_clinico.cd_usuario LIKE '%TANIA.SANTOS%'
    AND editor_campo.ds_identificador IN ( 'CK_ESPONTANEO_EVO_FISIO_INT_1', 'CK_PRONGA_NASAL_EVO_FISIO_INT_1', 'CK_VENTURI_EVO_FISIO_INT_1',
    'CK_MASCARA_RESERV_EVO_FISIO_INT_1', 'CK_VNI_EVO_FISIO_INT_1',
                                           'CK_VMI_EVO_FISIO_INT_1', 'CK_TOT_EVO_FISIO_INT_1', 'CK_TQT_EVO_FISIO_INT_1', 'CK_DRENO_DIREITA_EVO_FISIO_INT_1',
                                           'CK_FR_VNI_EVO_FISIO_INT_1',
                                           'CK_FR_DESMAME_TRE_EVO_FISIO_INT_1', 'CK_FR_EXTUBACAO_EVO_FISIO_INT_1', 'CK_FM_SEDESTACAO_EVO_FISIO_INT_1',
                                           'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_INT_1', 'CK_FM_NA_POLTRONA_EVO_FISIO_INT_1',
                                           'CK_FM_BIPEDEST_EVO_FISIO_INT_1', 'CK_FM_DEAMBULACAO_EVO_FISIO_INT_1' )
    AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true'
)
SELECT
    cd_paciente    AS cad,
    nm_paciente    AS nome_do_paciente,
    cd_atendimento AS atendimento,
    nm_documento   AS tipo_de_documento,

    MAX(CASE WHEN col = 'ESPONTANEO'        THEN txt END) AS espontaneo,
    MAX(CASE WHEN col = 'PRONGA_NASAL'      THEN txt END) AS pronga_nasal,
    MAX(CASE WHEN col = 'VENTURI'           THEN txt END) AS venturi,
    MAX(CASE WHEN col = 'MASCARA'           THEN txt END) AS mascara,
    MAX(CASE WHEN col = 'VNI'               THEN txt END) AS vni,
    MAX(CASE WHEN col = 'VMI'               THEN txt END) AS vmi,
    MAX(CASE WHEN col = 'TOT'               THEN txt END) AS tot,
    MAX(CASE WHEN col = 'TQT'               THEN txt END) AS tqt,

    MAX(CASE WHEN col = 'DRENO_TOR_DIREITO' THEN txt END) AS dreno_toracico_direito,

    MAX(CASE WHEN col = 'FR_VNI'            THEN txt END) AS fr_vni,
    MAX(CASE WHEN col = 'FR_DESMAME'        THEN txt END) AS fr_desmame,
    MAX(CASE WHEN col = 'FR_EXTUBACAO'      THEN txt END) AS fr_extubacao,

    MAX(CASE WHEN col = 'FM_SEDESTACAO'     THEN txt END) AS fm_sedestacao,
    MAX(CASE WHEN col = 'FM_BEIRA_LEITO'    THEN txt END) AS fm_beira_leito,
    MAX(CASE WHEN col = 'FM_NA_POLTRONA'    THEN txt END) AS fm_na_poltrona,
    MAX(CASE WHEN col = 'FM_BIPEDESTACAO'   THEN txt END) AS fm_bipedestacao,
    MAX(CASE WHEN col = 'FM_DEAMBULACAO'    THEN txt END) AS fm_deambulacao

FROM base
GROUP BY
    cd_paciente,
    nm_paciente,
    cd_atendimento,
    nm_documento;

--------------------------------------------------------------------------------------------------------
-- Fisioterapia evolução de UTI adulto
WITH mapa AS (
    -- =========================
    -- RESPIRAÇÃO 
    -- =========================
    SELECT 'CK_ESPONTANEO_EVO_FISIO_UTI_1'       AS id, 'RESPIRANDO EM ESPONTÂNEO'     AS txt, 'ESPONTANEO'       AS col FROM dual UNION ALL
    SELECT 'CK_PRONGA_NASAL_EVO_FISIO_UTI_1'     AS id, 'RESPIRANDO EM PRONGA NASAL'   AS txt, 'PRONGA_NASAL'     AS col FROM dual UNION ALL
    SELECT 'CK_VENTURI_EVO_FISIO_UTI_1'          AS id, 'RESPIRANDO EM COMPROMETIDO'   AS txt, 'VENTURI'          AS col FROM dual UNION ALL
    SELECT 'CK_MASCARA_RESERV_EVO_FISIO_UTI_1'   AS id, 'MÁSCARA RESERVATÓRIO'         AS txt, 'MASCARA'          AS col FROM dual UNION ALL
    SELECT 'CK_VNI_EVO_FISIO_UTI_1'              AS id, 'RESPIRANDO EM VNI'            AS txt, 'VNI'              AS col FROM dual UNION ALL
    SELECT 'CK_VMI_EVO_FISIO_UTI_1'              AS id, 'RESPIRANDO EM VMI'            AS txt, 'VMI'              AS col FROM dual UNION ALL
    SELECT 'CK_TOT_EVO_FISIO_UTI_1'              AS id, 'RESPIRANDO EM TOT'            AS txt, 'TOT'              AS col FROM dual UNION ALL
    SELECT 'CK_TQT_EVO_FISIO_UTI_1'              AS id, 'RESPIRANDO EM TQT'            AS txt, 'TQT'              AS col FROM dual UNION ALL

    -- =========================
    -- PARAMENTROS VENTILAÇÃO MECÂNICA
    -- =========================
    SELECT 'CK_PCV_EVO_FISIO_UTI_1'               AS id, 'VENTILAÇÃO MECÂNICA PCV'      AS txt, 'PCV'              AS col FROM dual UNION ALL
    SELECT 'CK_VCV_EVO_FISIO_UTI_1'               AS id, 'VENTILAÇÃO MECÂNICA VCV'      AS txt, 'VCV'              AS col FROM dual UNION ALL
    SELECT 'CK_PSV_EVO_FISIO_UTI_1'               AS id, 'VENTILAÇÃO MECÂNICA PSV'      AS txt, 'PSV'              AS col FROM dual UNION ALL
    SELECT 'CK_OUTRO_EVO_FISIO_UTI_1'             AS id, 'VENTILAÇÃO MECÂNICA OUTRO'    AS txt, 'OUTRO'            AS col FROM dual UNION ALL

    -- =========================
    -- DISPOSITIVOS
    -- =========================
    SELECT 'CK_DRENO_DIREITA_EVO_FISIO_UTI_1'      AS id, 'DRENO TORÁCICO À DIREITA'    AS txt, 'DRENO_TOR_DIREITO' AS col FROM dual UNION ALL

    -- =========================
    -- CONDUTAS - FR
    -- =========================
    SELECT 'CK_FR_VNI_EVO_FISIO_UTI_1'             AS id, 'CONDUTA FR VNI'               AS txt, 'FR_VNI'           AS col FROM dual UNION ALL
    SELECT 'CK_FR_DESMAME_TRE_EVO_FISIO_UTI_1'     AS id, 'CONDUTA FR DESMAME'           AS txt, 'FR_DESMAME'       AS col FROM dual UNION ALL
    SELECT 'CK_FR_EXTUBACAO_EVO_FISIO_UTI_1'       AS id, 'CONDUTA FR EXTUBAÇÃO'         AS txt, 'FR_EXTUBACAO'     AS col FROM dual UNION ALL

    -- =========================
    -- CONDUTAS - FM
    -- =========================
    SELECT 'CK_FM_SEDESTACAO_EVO_FISIO_UTI_1'      AS id, 'CONDUTA FM SEDESTAÇÃO'        AS txt, 'FM_SEDESTACAO'     AS col FROM dual UNION ALL
    SELECT 'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_UTI_1'  AS id, 'CONDUTA FM BEIRA LEITO'       AS txt, 'FM_BEIRA_LEITO'    AS col FROM dual UNION ALL
    SELECT 'CK_FM_NA_POLTRONA_EVO_FISIO_UTI_1'     AS id, 'CONDUTA FM NA POLTRONA'       AS txt, 'FM_NA_POLTRONA'    AS col FROM dual UNION ALL
    SELECT 'CK_FM_BIPEDEST_EVO_FISIO_UTI_1'        AS id, 'CONDUTA FM BIPEDESTAÇÃO'      AS txt, 'FM_BIPEDESTACAO'   AS col FROM dual UNION ALL
    SELECT 'CK_FM_DEAMBULACAO_EVO_FISIO_UTI_1'     AS id, 'CONDUTA FM DEAMBULAÇÃO'       AS txt, 'FM_DEAMBULACAO'    AS col FROM dual
),
base AS (
SELECT
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento,
    mapa.col,
    mapa.txt
FROM
         pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
    JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
    JOIN mapa ON mapa.id = editor_campo.ds_identificador
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
WHERE
        pw_documento_clinico.cd_atendimento = '4285233'
    AND pw_editor_clinico.cd_documento = '382'
    AND pw_documento_clinico.cd_objeto = '261'
    AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    AND pw_documento_clinico.cd_usuario LIKE '%CLAUDIA.BRASILEIRO%'
    AND editor_campo.ds_identificador IN ( 'CK_ESPONTANEO_EVO_FISIO_UTI_1', 'CK_PRONGA_NASAL_EVO_FISIO_UTI_1', 'CK_VENTURI_EVO_FISIO_UTI_1',
    'CK_MASCARA_RESERV_EVO_FISIO_UTI_1', 'CK_VNI_EVO_FISIO_UTI_1',
                                           'CK_VMI_EVO_FISIO_UTI_1', 'CK_TOT_EVO_FISIO_UTI_1', 'CK_TQT_EVO_FISIO_UTI_1', 'CK_PCV_EVO_FISIO_UTI_1',
                                           'CK_VCV_EVO_FISIO_UTI_1',
                                           'CK_PSV_EVO_FISIO_UTI_1', 'CK_OUTRO_EVO_FISIO_UTI_1', 'CK_DRENO_DIREITA_EVO_FISIO_UTI_1', 'CK_FR_VNI_EVO_FISIO_UTI_1',
                                           'CK_FR_DESMAME_TRE_EVO_FISIO_UTI_1',
                                           'CK_FR_EXTUBACAO_EVO_FISIO_UTI_1', 'CK_FM_SEDESTACAO_EVO_FISIO_UTI_1', 'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_UTI_1',
                                           'CK_FM_NA_POLTRONA_EVO_FISIO_UTI_1', 'CK_FM_BIPEDEST_EVO_FISIO_UTI_1',
                                           'CK_FM_DEAMBULACAO_EVO_FISIO_UTI_1' )
    AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true'
)
SELECT
    cd_paciente    AS cad,
    nm_paciente    AS nome_do_paciente,
    cd_atendimento AS atendimento,
    nm_documento   AS tipo_de_documento,

    MAX(CASE WHEN col = 'ESPONTANEO'        THEN txt END) AS espontaneo,
    MAX(CASE WHEN col = 'PRONGA_NASAL'      THEN txt END) AS pronga_nasal,
    MAX(CASE WHEN col = 'VENTURI'           THEN txt END) AS venturi,
    MAX(CASE WHEN col = 'MASCARA'           THEN txt END) AS mascara,
    MAX(CASE WHEN col = 'VNI'               THEN txt END) AS vni,
    MAX(CASE WHEN col = 'VMI'               THEN txt END) AS vmi,
    MAX(CASE WHEN col = 'TOT'               THEN txt END) AS tot,
    MAX(CASE WHEN col = 'TQT'               THEN txt END) AS tqt,
    
    MAX(CASE WHEN col = 'PCV'               THEN txt END) AS pcv,
    MAX(CASE WHEN col = 'VCV'               THEN txt END) AS vcv,
    MAX(CASE WHEN col = 'PSV'               THEN txt END) AS psv,
    MAX(CASE WHEN col = 'OUTRO'             THEN txt END) AS outro,

    MAX(CASE WHEN col = 'DRENO_TOR_DIREITO' THEN txt END) AS dreno_toracico_direito,

    MAX(CASE WHEN col = 'FR_VNI'            THEN txt END) AS fr_vni,
    MAX(CASE WHEN col = 'FR_DESMAME'        THEN txt END) AS fr_desmame,
    MAX(CASE WHEN col = 'FR_EXTUBACAO'      THEN txt END) AS fr_extubacao,

    MAX(CASE WHEN col = 'FM_SEDESTACAO'     THEN txt END) AS fm_sedestacao,
    MAX(CASE WHEN col = 'FM_BEIRA_LEITO'    THEN txt END) AS fm_beira_leito,
    MAX(CASE WHEN col = 'FM_NA_POLTRONA'    THEN txt END) AS fm_na_poltrona,
    MAX(CASE WHEN col = 'FM_BIPEDESTACAO'   THEN txt END) AS fm_bipedestacao,
    MAX(CASE WHEN col = 'FM_DEAMBULACAO'    THEN txt END) AS fm_deambulacao
FROM base
GROUP BY
    cd_paciente,
    nm_paciente,
    cd_atendimento,
    nm_documento;
