--Fisioterapia evolução de internação
WITH mapa AS (
    -- =========================
    -- RESPIRAÇÃO 
    -- =========================
    SELECT 'CK_ESPONTANEO_EVO_FISIO_INT_1'        AS id, 'RESPIRANDO EM ESPONTÂNEO'       AS txt, 'ESPONTANEO'          AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_PRONGA_NASAL_EVO_FISIO_INT_1'      AS id, 'RESPIRANDO EM PRONGA NASAL'     AS txt, 'PRONGA_NASAL'        AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VENTURI_EVO_FISIO_INT_1'           AS id, 'RESPIRANDO EM COMPROMETIDO'     AS txt, 'VENTURI'             AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_MASCARA_RESERV_EVO_FISIO_INT_1'    AS id, 'MASCARA RESERVATÓRIO'           AS txt, 'MASCARA'             AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VNI_EVO_FISIO_INT_1'               AS id, 'RESPIRANDO EM VNI'              AS txt, 'VNI'                 AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VMI_EVO_FISIO_INT_1'               AS id, 'RESPIRANDO EM VMI'              AS txt, 'VMI'                 AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_TOT_EVO_FISIO_INT_1'               AS id, 'RESPIRANDO EM TOT'              AS txt, 'TOT'                 AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_TQT_EVO_FISIO_INT_1'               AS id, 'RESPIRANDO EM TQT'              AS txt, 'TQT'                 AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- RESPIRAÇÃO (VALOR)
    -- =========================
    SELECT 'DT_ENTUBADO_EVO_FISIO_INT_1'          AS id, 'DATA DA INTUBAÇÃO'              AS txt, 'DT_INTUBADO'         AS col, 'VALOR' AS tipo FROM dual UNION ALL
    SELECT 'DT_EXTUBADO_EVO_FISIO_INT_1'          AS id, 'DATA DA EXTUBAÇÃO'              AS txt, 'DT_EXTUBAÇÃO'        AS col, 'VALOR' AS tipo FROM dual UNION ALL
    
    -- =========================
    -- DISPOSITIVOS
    -- =========================
    SELECT 'CK_DRENO_DIREITA_EVO_FISIO_INT_1'     AS id, 'DRENO TORACICO A DIREITA'       AS txt, 'DRENO_TOR_DIREITO'   AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- CONDUTAS - FR
    -- =========================
    SELECT 'CK_FR_VNI_EVO_FISIO_INT_1'             AS id, 'CONDUTA FR VNI'                AS txt, 'FR_VNI'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FR_DESMAME_TRE_EVO_FISIO_INT_1'     AS id, 'CONDUTA FR DESMAME'            AS txt, 'FR_DESMAME'          AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FR_EXTUBACAO_EVO_FISIO_INT_1'       AS id, 'CONDUTA FR EXTUBAÇÃO'          AS txt, 'FR_EXTUBACAO'        AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- CONDUTAS - FM
    -- =========================
    SELECT 'CK_FM_SEDESTACAO_EVO_FISIO_INT_1'       AS id, 'CONDUTA FM SEDESTAÇÃO'         AS txt, 'FM_SEDESTACAO'       AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_INT_1'   AS id, 'CONDUTA FM BEIRA LEITO'        AS txt, 'FM_BEIRA_LEITO'      AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_NA_POLTRONA_EVO_FISIO_INT_1'      AS id, 'CONDUTA FM NA POLTRONA'        AS txt, 'FM_NA_POLTRONA'      AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_BIPEDEST_EVO_FISIO_INT_1'         AS id, 'CONDUTA FM BIPEDESTAÇÃO'       AS txt, 'FM_BIPEDESTACAO'     AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_DEAMBULACAO_EVO_FISIO_INT_1'      AS id, 'CONDUTA FM DEAMBULAÇÃO'        AS txt, 'FM_DEAMBULACAO'      AS col, 'BOOL'  AS tipo FROM dual
),
base AS (
SELECT
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento,
    pw_documento_clinico.dh_criacao,
    mapa.col,
    mapa.txt,
    mapa.tipo,
    TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 4000, 1)) AS valor_texto
FROM
         pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
    JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
    JOIN mapa ON mapa.id = editor_campo.ds_identificador
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
WHERE
        --pw_documento_clinico.cd_atendimento = '4307107'
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/02/25', 'DD/MM/YY') AND TO_DATE('31/12/25', 'DD/MM/YY')
    AND pw_editor_clinico.cd_documento = '384'
    AND pw_documento_clinico.cd_objeto = '261'
    AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    AND ( ( mapa.tipo = 'BOOL'
            AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' )
          OR ( mapa.tipo = 'VALOR'
               AND TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 4000, 1)) IS NOT NULL ) )
)
SELECT
    cd_paciente    AS cad,
    nm_paciente    AS nome_do_paciente,
    cd_atendimento AS atendimento,
    nm_documento   AS tipo_de_documento,
    dh_criacao     AS data_do_documento,

    MAX(CASE WHEN col = 'ESPONTANEO'        THEN txt END) AS espontaneo,
    MAX(CASE WHEN col = 'PRONGA_NASAL'      THEN txt END) AS pronga_nasal,
    MAX(CASE WHEN col = 'VENTURI'           THEN txt END) AS venturi,
    MAX(CASE WHEN col = 'MASCARA'           THEN txt END) AS mascara,
    MAX(CASE WHEN col = 'VNI'               THEN txt END) AS vni,
    MAX(CASE WHEN col = 'VMI'               THEN txt END) AS vmi,
    MAX(CASE WHEN col = 'TOT'               THEN txt END) AS tot,
    MAX(CASE WHEN col = 'TQT'               THEN txt END) AS tqt,

    MAX(CASE WHEN col = 'DT_INTUBADO'       THEN valor_texto END) AS data_intubacao,
    MAX(CASE WHEN col = 'DT_EXTUBADO'       THEN valor_texto END) AS data_estubacao,
    
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
    nm_documento,
    dh_criacao;


-- Óbitos Internação
SELECT DISTINCT
    atendime.cd_paciente
FROM
    atendime atendime
WHERE
        atendime.tp_atendimento = 'I'
    AND atendime.sn_obito = 'S'
    AND atendime.cd_atendimento IN (
        SELECT
            pw_documento_clinico.cd_atendimento
        FROM
                 pw_documento_clinico
            JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
            JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
            JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
            JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
        WHERE
            pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
            AND pw_editor_clinico.cd_documento = '384'
            AND pw_documento_clinico.cd_objeto = '261'
            AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
)


--Altas Internação
SELECT DISTINCT
    atendime.cd_atendimento
FROM
    atendime atendime
WHERE
        atendime.tp_atendimento = 'I'
    AND atendime.sn_obito = 'N'
    AND atendime.dt_alta IS NOT NULL
    AND atendime.cd_atendimento IN (
        SELECT
            pw_documento_clinico.cd_atendimento
        FROM
                 pw_documento_clinico
            JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
            JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
            JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
            JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
        WHERE
            pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
            AND pw_editor_clinico.cd_documento = '384'
            AND pw_documento_clinico.cd_objeto = '261'
            AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    )


--Admissões Internação  
WITH base AS (
    SELECT
        pw_documento_clinico.cd_atendimento,
        pw_documento_clinico.cd_paciente,
        pw_documento_clinico.dh_criacao,
        ROW_NUMBER()
        OVER(PARTITION BY pw_documento_clinico.cd_atendimento, pw_documento_clinico.cd_paciente
             ORDER BY
                 pw_documento_clinico.dh_criacao
        ) AS rn
    FROM
             pw_documento_clinico
        JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
        JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
        JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    WHERE
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
        AND pw_editor_clinico.cd_documento = '384'
        AND pw_documento_clinico.cd_objeto = '261'
        AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
)
SELECT
    base.cd_atendimento,
    base.cd_paciente,
    base.dh_criacao
FROM
    base
WHERE
    base.rn = 1
ORDER BY
    base.cd_paciente,
    base.cd_atendimento;


--Transferências internação
WITH base AS (
    SELECT
        pw_documento_clinico.cd_atendimento,
        pw_documento_clinico.cd_paciente,
        pw_documento_clinico.dh_criacao,
        ROW_NUMBER() OVER (
            PARTITION BY pw_documento_clinico.cd_atendimento, pw_documento_clinico.cd_paciente
            ORDER BY pw_documento_clinico.dh_criacao
        ) AS rn
    FROM
        pw_documento_clinico
        JOIN pw_editor_clinico
            ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        JOIN editor_registro_campo
            ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
        JOIN editor_campo
            ON editor_campo.cd_campo = editor_registro_campo.cd_campo
        JOIN paciente
            ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    WHERE
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
        AND pw_editor_clinico.cd_documento = '384'
        AND pw_documento_clinico.cd_objeto = '261'
        AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
),
primeiro AS (
    SELECT
        base.cd_atendimento,
        base.cd_paciente,
        base.dh_criacao
    FROM base
    WHERE base.rn = 1
)
SELECT
    primeiro.cd_atendimento,
    primeiro.cd_paciente,
    primeiro.dh_criacao AS dh_primeiro_documento,
    mov_int.hr_mov_int  AS dt_movimentacao_leito
FROM
    primeiro
    JOIN mov_int
        ON mov_int.cd_atendimento = primeiro.cd_atendimento
WHERE
    mov_int.hr_mov_int > primeiro.dh_criacao
ORDER BY
    primeiro.cd_paciente,
    primeiro.cd_atendimento,
    mov_int.hr_mov_int;




--------------------------------------------------------------------------------------------------------
--Fisioterapia evolução de UTI adulto
WITH mapa AS (
    -- =========================
    -- RESPIRAÇÃO (BOOL)
    -- =========================
    SELECT 'CK_ESPONTANEO_EVO_FISIO_UTI_1'        AS id, 'RESPIRANDO EM ESPONTÂNEO'   AS txt, 'ESPONTANEO'       AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_PRONGA_NASAL_EVO_FISIO_UTI_1'      AS id, 'RESPIRANDO EM PRONGA NASAL' AS txt, 'PRONGA_NASAL'     AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VENTURI_EVO_FISIO_UTI_1'           AS id, 'RESPIRANDO EM COMPROMETIDO' AS txt, 'VENTURI'          AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_MASCAR_RESERV_EVO_FISIO_UTI_1'     AS id, 'MÁSCARA RESERVATÓRIO'       AS txt, 'MASCARA'          AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VNI_EVO_FISIO_UTI_1'               AS id, 'RESPIRANDO EM VNI'          AS txt, 'VNI'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VMI_EVO_FISIO_UTI_1'               AS id, 'RESPIRANDO EM VMI'          AS txt, 'VMI'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_TOT_EVO_FISIO_UTI_1'               AS id, 'RESPIRANDO EM TOT'          AS txt, 'TOT'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_TQT_EVO_FISIO_UTI_1'               AS id, 'RESPIRANDO EM TQT'          AS txt, 'TQT'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    
    -- =========================
    -- RESPIRAÇÃO (VALOR)
    -- =========================
    SELECT 'DT_INTUBADO_EVO_FISIO_UTI_1'          AS id, 'DATA DA INTUBAÇÃO'          AS txt, 'DT_INTUBADO'      AS col, 'VALOR' AS tipo FROM dual UNION ALL
    SELECT 'DT_EXTURBADO_EVO_FISIO_UTI_1'         AS id, 'DATA DA EXTUBAÇÃO'          AS txt, 'DT_EXTUBAÇÃO'     AS col, 'VALOR' AS tipo FROM dual UNION ALL

    -- =========================
    -- PARAMETROS VM (BOOL)
    -- =========================
    SELECT 'CK_PCV_EVO_FISIO_UTI_1'               AS id, 'VENTILAÇÃO MECÂNICA PCV'    AS txt, 'PCV'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VCV_EVO_FISIO_UTI_1'               AS id, 'VENTILAÇÃO MECÂNICA VCV'    AS txt, 'VCV'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_PSV_EVO_FISIO_UTI_1'               AS id, 'VENTILAÇÃO MECÂNICA PSV'    AS txt, 'PSV'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_OUTRO_EVO_FISIO_UTI_1'             AS id, 'VENTILAÇÃO MECÂNICA OUTRO'  AS txt, 'OUTRO'            AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- DISPOSITIVOS (BOOL)
    SELECT 'CK_DRENO_A_DIREITA_EVO_FISIO_UTI_1'    AS id, 'DRENO TORÁCICO À DIREITA'  AS txt, 'DRENO_TOR_DIREITO' AS col, 'BOOL' AS tipo FROM dual UNION ALL

    -- CONDUTAS FR (BOOL)
    SELECT 'CK_FR_VNI_EVO_FISIO_UTI_1'             AS id, 'CONDUTA FR VNI'            AS txt, 'FR_VNI'            AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FR_DESMAME_TRE_EVO_FISIO_UTI_1'     AS id, 'CONDUTA FR DESMAME'        AS txt, 'FR_DESMAME'        AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FR_EXTUBACAO_EVO_FISIO_UTI_1'       AS id, 'CONDUTA FR EXTUBAÇÃO'      AS txt, 'FR_EXTUBACAO'      AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- CONDUTAS FM (BOOL)
    SELECT 'CK_FM_SEDEST_EVO_FISIO_UTI_1'          AS id, 'CONDUTA FM SEDESTAÇÃO'     AS txt, 'FM_SEDESTACAO'     AS col, 'BOOL' AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_UTI_1'  AS id, 'CONDUTA FM BEIRA LEITO'    AS txt, 'FM_BEIRA_LEITO'    AS col, 'BOOL' AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_POLTRONA_EVO_FISIO_UTI_1'        AS id, 'CONDUTA FM NA POLTRONA'    AS txt, 'FM_NA_POLTRONA'    AS col, 'BOOL' AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_BIPEDEST_EVO_FISIO_UTI_1'        AS id, 'CONDUTA FM BIPEDESTAÇÃO'   AS txt, 'FM_BIPEDESTACAO'   AS col, 'BOOL' AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_DEAMBUL_EVO_FISIO_UTI_1'         AS id, 'CONDUTA FM DEAMBULAÇÃO'    AS txt, 'FM_DEAMBULACAO'    AS col, 'BOOL' AS tipo FROM dual
),
base AS (
SELECT
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento,
    pw_documento_clinico.dh_criacao,
    mapa.col,
    mapa.txt,
    mapa.tipo,
    TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 4000, 1)) AS valor_texto
FROM
         pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
    JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
    JOIN mapa ON mapa.id = editor_campo.ds_identificador
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
WHERE
        --pw_documento_clinico.cd_atendimento = '4285233'
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/02/25', 'DD/MM/YY') AND TO_DATE('31/12/25', 'DD/MM/YY')
    AND pw_editor_clinico.cd_documento = '382'
    AND pw_documento_clinico.cd_objeto = '261'
    AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    AND ( ( mapa.tipo = 'BOOL'
            AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' )
          OR ( mapa.tipo = 'VALOR'
               AND TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 4000, 1)) IS NOT NULL ) )
)
SELECT
    cd_paciente    AS cad,
    nm_paciente    AS nome_do_paciente,
    cd_atendimento AS atendimento,
    nm_documento   AS tipo_de_documento,
    dh_criacao     AS data_do_documento,

    MAX(CASE WHEN col = 'ESPONTANEO'        THEN txt END) AS espontaneo,
    MAX(CASE WHEN col = 'PRONGA_NASAL'      THEN txt END) AS pronga_nasal,
    MAX(CASE WHEN col = 'VENTURI'           THEN txt END) AS venturi,
    MAX(CASE WHEN col = 'MASCARA'           THEN txt END) AS mascara,
    MAX(CASE WHEN col = 'VNI'               THEN txt END) AS vni,
    MAX(CASE WHEN col = 'VMI'               THEN txt END) AS vmi,
    MAX(CASE WHEN col = 'TOT'               THEN txt END) AS tot,
    MAX(CASE WHEN col = 'TQT'               THEN txt END) AS tqt,

    MAX(CASE WHEN col = 'DT_INTUBADO'       THEN valor_texto END) AS data_intubacao,
    MAX(CASE WHEN col = 'DT_EXTUBADO'       THEN valor_texto END) AS data_estubacao,

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
    nm_documento,
    dh_criacao;


-- Óbitos UTI Adulto
SELECT DISTINCT
    atendime.cd_paciente
FROM
    atendime atendime
WHERE
        atendime.tp_atendimento = 'I'
    AND atendime.sn_obito = 'S'
    AND atendime.cd_atendimento IN (
        SELECT
            pw_documento_clinico.cd_atendimento
        FROM
                 pw_documento_clinico
            JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
            JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
            JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
            JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
        WHERE
            pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
            AND pw_editor_clinico.cd_documento = '382'
            AND pw_documento_clinico.cd_objeto = '261'
            AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    )


--Altas UTI Adulto
SELECT DISTINCT
    atendime.cd_atendimento
FROM
    atendime atendime
WHERE
        atendime.tp_atendimento = 'I'
    AND atendime.sn_obito = 'N'
    AND atendime.dt_alta IS NOT NULL
    AND atendime.cd_atendimento IN (
        SELECT
            pw_documento_clinico.cd_atendimento
        FROM
                 pw_documento_clinico
            JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
            JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
            JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
            JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
        WHERE
            pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
            AND pw_editor_clinico.cd_documento = '382'
            AND pw_documento_clinico.cd_objeto = '261'
            AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    )

    
--Admissões   
WITH base AS (
    SELECT
        pw_documento_clinico.cd_atendimento,
        pw_documento_clinico.cd_paciente,
        pw_documento_clinico.dh_criacao,
        ROW_NUMBER()
        OVER(PARTITION BY pw_documento_clinico.cd_atendimento, pw_documento_clinico.cd_paciente
             ORDER BY
                 pw_documento_clinico.dh_criacao
        ) AS rn
    FROM
             pw_documento_clinico
        JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
        JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
        JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    WHERE
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
        AND pw_editor_clinico.cd_documento = '382'
        AND pw_documento_clinico.cd_objeto = '261'
        AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
)
SELECT
    base.cd_atendimento,
    base.cd_paciente,
    base.dh_criacao
FROM
    base
WHERE
    base.rn = 1
ORDER BY
    base.cd_paciente,
    base.cd_atendimento;


--Transferências UTI Adulto
WITH base AS (
    SELECT
        pw_documento_clinico.cd_atendimento,
        pw_documento_clinico.cd_paciente,
        pw_documento_clinico.dh_criacao,
        ROW_NUMBER() OVER (
            PARTITION BY pw_documento_clinico.cd_atendimento, pw_documento_clinico.cd_paciente
            ORDER BY pw_documento_clinico.dh_criacao
        ) AS rn
    FROM
        pw_documento_clinico
        JOIN pw_editor_clinico
            ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        JOIN editor_registro_campo
            ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
        JOIN editor_campo
            ON editor_campo.cd_campo = editor_registro_campo.cd_campo
        JOIN paciente
            ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    WHERE
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
        AND pw_editor_clinico.cd_documento = '382'
        AND pw_documento_clinico.cd_objeto = '261'
        AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
),
primeiro AS (
    SELECT
        base.cd_atendimento,
        base.cd_paciente,
        base.dh_criacao
    FROM base
    WHERE base.rn = 1
)
SELECT
    primeiro.cd_atendimento,
    primeiro.cd_paciente,
    primeiro.dh_criacao AS dh_primeiro_documento,
    mov_int.hr_mov_int  AS dt_movimentacao_leito
FROM
    primeiro
    JOIN mov_int
        ON mov_int.cd_atendimento = primeiro.cd_atendimento
WHERE
    mov_int.hr_mov_int > primeiro.dh_criacao
ORDER BY
    primeiro.cd_paciente,
    primeiro.cd_atendimento,
    mov_int.hr_mov_int;

    
--------------------------------------------------------------------------------------------------------
--Fisioterapia evolução de UTI pediatrica
WITH mapa AS (
    -- =========================
    -- RESPIRAÇÃO 
    -- =========================
    SELECT 'CK_ESPONTANEO_EVO_FISIO_UTI_PED_1'        AS id, 'RESPIRANDO EM ESPONTÂNEO'    AS txt, 'ESPONTANEO'      AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_PRONGA_NASAL_EVO_FISIO_UTI_PED_1'      AS id, 'RESPIRANDO EM PRONGA NASAL'  AS txt, 'PRONGA_NASAL'    AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VENTURI_EVO_FISIO_UTI_PED_1'           AS id, 'RESPIRANDO EM COMPROMETIDO'  AS txt, 'VENTURI'         AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_MASCARA_RESERV_EVO_FISIO_UTI_PED_1'    AS id, 'MÁSCARA RESERVATÓRIO'        AS txt, 'MASCARA'         AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VNI_EVO_FISIO_UTI_PED_1'               AS id, 'RESPIRANDO EM VNI'           AS txt, 'VNI'             AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VMI_EVO_FISIO_UTI_PED_1'               AS id, 'RESPIRANDO EM VMI'           AS txt, 'VMI'             AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_TOT_EVO_FISIO_UTI_PED_1'               AS id, 'RESPIRANDO EM TOT'           AS txt, 'TOT'             AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_TQT_EVO_FISIO_UTI_PED_1'               AS id, 'RESPIRANDO EM TQT'           AS txt, 'TQT'             AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- RESPIRAÇÃO (VALOR)
    -- =========================
    SELECT 'DT_INTUBADO_EVO_FISIO_UTI_PED_1'          AS id, 'DATA DA INTUBAÇÃO'           AS txt, 'DT_INTUBADO'     AS col, 'VALOR' AS tipo FROM dual UNION ALL
    SELECT 'DT_EXTURBADO_EVO_FISIO_UTI_PED_1'         AS id, 'DATA DA EXTUBAÇÃO'           AS txt, 'DT_EXTUBAÇÃO'    AS col, 'VALOR' AS tipo FROM dual UNION ALL
    
    -- =========================
    -- PARAMENTROS VENTILAÇÃO MECÂNICA
    -- =========================
    SELECT 'CK_PCV_EVO_FISIO_UTI_PED_1'                AS id, 'VENTILAÇÃO MECÂNICA PCV'   AS txt, 'PCV'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_VCV_EVO_FISIO_UTI_PED_1'                AS id, 'VENTILAÇÃO MECÂNICA VCV'   AS txt, 'VCV'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_PSV_EVO_FISIO_UTI_PED_1'                AS id, 'VENTILAÇÃO MECÂNICA PSV'   AS txt, 'PSV'              AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_OUTRO_EVO_FISIO_UTI_PED_1'              AS id, 'VENTILAÇÃO MECÂNICA OUTRO' AS txt, 'OUTRO'            AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- DISPOSITIVOS
    -- =========================
    SELECT 'CK_DRENO_DIREITA_EVO_FISIO_UTI_PED_1'      AS id, 'DRENO TORÁCICO À DIREITA'  AS txt, 'DRENO_TOR_DIREITO' AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- CONDUTAS - FR
    -- =========================
    SELECT 'CK_FR_VNI_EVO_FISIO_UTI_PED_1'             AS id, 'CONDUTA FR VNI'             AS txt, 'FR_VNI'           AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FR_DESMAME_TRE_EVO_FISIO_UTI_PED_1'     AS id, 'CONDUTA FR DESMAME'         AS txt, 'FR_DESMAME'       AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FR_EXTUBACAO_EVO_FISIO_UTI_PED_1'       AS id, 'CONDUTA FR EXTUBAÇÃO'       AS txt, 'FR_EXTUBACAO'     AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- CONDUTAS - FM
    -- =========================
    SELECT 'CK_FM_SEDESTACAO_EVO_FISIO_UTI_PED_1'      AS id, 'CONDUTA FM SEDESTAÇÃO'      AS txt, 'FM_SEDESTACAO'     AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_BEIRA_DO_LEITO_EVO_FISIO_UTI_PED_1'  AS id, 'CONDUTA FM BEIRA LEITO'     AS txt, 'FM_BEIRA_LEITO'    AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_NA_POLTRONA_EVO_FISIO_UTI_PED_1'     AS id, 'CONDUTA FM NA POLTRONA'     AS txt, 'FM_NA_POLTRONA'    AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_BIPEDEST_EVO_FISIO_UTI_PED_1'        AS id, 'CONDUTA FM BIPEDESTAÇÃO'    AS txt, 'FM_BIPEDESTACAO'   AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_FM_DEAMBULACAO_EVO_FISIO_UTI_PED_1'     AS id, 'CONDUTA FM DEAMBULAÇÃO'     AS txt, 'FM_DEAMBULACAO'    AS col, 'BOOL'  AS tipo FROM dual
),
base AS (
SELECT
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento,
    pw_documento_clinico.dh_criacao,
    mapa.col,
    mapa.txt,
    mapa.tipo,
    TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 4000, 1)) AS valor_texto
FROM
         pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
    JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
    JOIN mapa ON mapa.id = editor_campo.ds_identificador
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
WHERE
        --pw_documento_clinico.cd_atendimento = '4307107'
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/02/25', 'DD/MM/YY') AND TO_DATE('31/12/25', 'DD/MM/YY')
    AND pw_editor_clinico.cd_documento = '383'
    AND pw_documento_clinico.cd_objeto = '261'
    AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    AND ( ( mapa.tipo = 'BOOL'
            AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' )
          OR ( mapa.tipo = 'VALOR'
               AND TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 4000, 1)) IS NOT NULL ) )
)
SELECT
    cd_paciente    AS cad,
    nm_paciente    AS nome_do_paciente,
    cd_atendimento AS atendimento,
    nm_documento   AS tipo_de_documento,
    dh_criacao     AS data_do_documento,
    dh_criacao     AS data_do_documento,

    MAX(CASE WHEN col = 'ESPONTANEO'        THEN txt END) AS espontaneo,
    MAX(CASE WHEN col = 'PRONGA_NASAL'      THEN txt END) AS pronga_nasal,
    MAX(CASE WHEN col = 'VENTURI'           THEN txt END) AS venturi,
    MAX(CASE WHEN col = 'MASCARA'           THEN txt END) AS mascara,
    MAX(CASE WHEN col = 'VNI'               THEN txt END) AS vni,
    MAX(CASE WHEN col = 'VMI'               THEN txt END) AS vmi,
    MAX(CASE WHEN col = 'TOT'               THEN txt END) AS tot,
    MAX(CASE WHEN col = 'TQT'               THEN txt END) AS tqt,
    
    MAX(CASE WHEN col = 'DT_INTUBADO'       THEN valor_texto END) AS data_intubacao,
    MAX(CASE WHEN col = 'DT_EXTUBADO'       THEN valor_texto END) AS data_estubacao,

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
    nm_documento,
    dh_criacao;


-- Óbitos UTI pediatrica
SELECT DISTINCT
    atendime.cd_paciente
FROM
    atendime atendime
WHERE
        atendime.tp_atendimento = 'I'
    AND atendime.sn_obito = 'S'
    AND atendime.cd_atendimento IN (
        SELECT
            pw_documento_clinico.cd_atendimento
        FROM
                 pw_documento_clinico
            JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
            JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
            JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
            JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
        WHERE
            pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
            AND pw_editor_clinico.cd_documento = '383'
            AND pw_documento_clinico.cd_objeto = '261'
            AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    )


--Altas UTI pediatrica
SELECT DISTINCT
    atendime.cd_atendimento
FROM
    atendime atendime
WHERE
        atendime.tp_atendimento = 'I'
    AND atendime.sn_obito = 'N'
    AND atendime.dt_alta IS NOT NULL
    AND atendime.cd_atendimento IN (
        SELECT
            pw_documento_clinico.cd_atendimento
        FROM
                 pw_documento_clinico
            JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
            JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
            JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
            JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
        WHERE
            pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
            AND pw_editor_clinico.cd_documento = '383'
            AND pw_documento_clinico.cd_objeto = '261'
            AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    )

    
--Admissões UTI pediatrica  
WITH base AS (
    SELECT
        pw_documento_clinico.cd_atendimento,
        pw_documento_clinico.cd_paciente,
        pw_documento_clinico.dh_criacao,
        ROW_NUMBER()
        OVER(PARTITION BY pw_documento_clinico.cd_atendimento, pw_documento_clinico.cd_paciente
             ORDER BY
                 pw_documento_clinico.dh_criacao
        ) AS rn
    FROM
             pw_documento_clinico
        JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
        JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
        JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    WHERE
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
        AND pw_editor_clinico.cd_documento = '383'
        AND pw_documento_clinico.cd_objeto = '261'
        AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
)
SELECT
    base.cd_atendimento,
    base.cd_paciente,
    base.dh_criacao
FROM
    base
WHERE
    base.rn = 1
ORDER BY
    base.cd_paciente,
    base.cd_atendimento;


--Transferências UTI pediatrica
WITH base AS (
    SELECT
        pw_documento_clinico.cd_atendimento,
        pw_documento_clinico.cd_paciente,
        pw_documento_clinico.dh_criacao,
        ROW_NUMBER() OVER (
            PARTITION BY pw_documento_clinico.cd_atendimento, pw_documento_clinico.cd_paciente
            ORDER BY pw_documento_clinico.dh_criacao
        ) AS rn
    FROM
        pw_documento_clinico
        JOIN pw_editor_clinico
            ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        JOIN editor_registro_campo
            ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
        JOIN editor_campo
            ON editor_campo.cd_campo = editor_registro_campo.cd_campo
        JOIN paciente
            ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    WHERE
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/01/26', 'DD/MM/YY') AND TO_DATE('01/03/26', 'DD/MM/YY')
        AND pw_editor_clinico.cd_documento = '383'
        AND pw_documento_clinico.cd_objeto = '261'
        AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
),
primeiro AS (
    SELECT
        base.cd_atendimento,
        base.cd_paciente,
        base.dh_criacao
    FROM base
    WHERE base.rn = 1
)
SELECT
    primeiro.cd_atendimento,
    primeiro.cd_paciente,
    primeiro.dh_criacao AS dh_primeiro_documento,
    mov_int.hr_mov_int  AS dt_movimentacao_leito
FROM
    primeiro
    JOIN mov_int
        ON mov_int.cd_atendimento = primeiro.cd_atendimento
WHERE
    mov_int.hr_mov_int > primeiro.dh_criacao
ORDER BY
    primeiro.cd_paciente,
    primeiro.cd_atendimento,
    mov_int.hr_mov_int;

--------------------------------------------------------------------------------------------------------
--Evolução de Fisioterapia - Ambulatório Adulto
WITH mapa AS (
    -- =========================
    -- DIAGNÓSTICO PRINCIPAL 
    -- =========================
    SELECT 'TX_DIAGPRI_EVO_FISIO_ADULTO_1'        AS id, 'NVL CONSCIÊNCIA DIAGNÓSTICO PRINCIPAL'   AS txt, 'DIAGNÓSTICO'     AS col, 'BOOL'  AS tipo FROM dual UNION ALL
   
    -- =========================
    -- CLÍNICA DE ORIGEM
    -- =========================
    SELECT 'TX_CLINICAORI_EVO_FISIO_ADULTO_1'     AS id, 'CLÍNICA DE ORIGEM'                       AS txt, 'CLINICA_ORIGEM'  AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- NÍVEL DE CONSCIÊNCIA
    -- =========================
    SELECT 'CK_NCSEDADO_EVO_FISIO_ADULTO_1'       AS id, 'NVL CONSCIÊNCIA SEDADO'                  AS txt, 'SEDADO'          AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_NCCOMATOSO_EVO_FISIO_ADULTO_1'     AS id, 'NVL CONSCIÊNCIA COMATOSO'                AS txt, 'COMATOSO'        AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_NCTORPOROSO_EVO_FISIO_ADULTO_1'    AS id, 'NVL CONSCIÊNCIAO TORPOROSO'              AS txt, 'TORPOROSO'       AS col, 'BOOL'  AS tipo FROM dual UNION ALL

    -- =========================
    -- EXAMES FÍSICOS
    -- =========================
    SELECT 'CK_DRENO_EVO_FISIO_ADULTO_1'          AS id, 'EXAMES FÍSICOS DRENO'                   AS txt, 'DRENO'           AS col, 'BOOL'  AS tipo FROM dual UNION ALL
    SELECT 'CK_SONDA_EVO_FISIO_ADULTO_1'          AS id, 'EXAMES FÍSICOS SONDA'                   AS txt, 'SONDA'           AS col, 'BOOL'  AS tipo FROM dual 
),
base AS (
SELECT
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento,
    pw_documento_clinico.dh_criacao,
    mapa.col,
    mapa.txt,
    mapa.tipo,
    TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 4000, 1)) AS valor_texto
FROM
         pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
    JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
    JOIN mapa ON mapa.id = editor_campo.ds_identificador
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
WHERE
        --pw_documento_clinico.cd_atendimento = '4307107'
        pw_documento_clinico.dh_criacao BETWEEN TO_DATE('01/02/25', 'DD/MM/YY') AND TO_DATE('31/12/25', 'DD/MM/YY')
    AND pw_editor_clinico.cd_documento = '282'
    AND pw_documento_clinico.cd_objeto = '261'
    AND pw_documento_clinico.nm_documento LIKE '%FISIOTERAPIA%'
    AND ( ( mapa.tipo = 'BOOL'
            AND lower(TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 5, 1))) = 'true' )
          OR ( mapa.tipo = 'VALOR'
               AND TRIM(dbms_lob.substr(editor_registro_campo.lo_valor, 4000, 1)) IS NOT NULL ) )
)
SELECT
    cd_paciente    AS cad,
    nm_paciente    AS nome_do_paciente,
    cd_atendimento AS atendimento,
    nm_documento   AS tipo_de_documento,
    dh_criacao     AS data_do_documento,

    MAX(CASE WHEN col = 'DIAGNÓSTICO'       THEN txt END) AS diagnóstico,
    
    MAX(CASE WHEN col = 'CLINICA_ORIGEM'    THEN txt END) AS clínica_origem,
    
    MAX(CASE WHEN col = 'SEDADO'            THEN txt END) AS sedado,
    MAX(CASE WHEN col = 'COMATOSO'          THEN txt END) AS comatoso,
    MAX(CASE WHEN col = 'TORPOROSO'         THEN txt END) AS torporoso,
    
    MAX(CASE WHEN col = 'DRENO'             THEN txt END) AS dreno,
    MAX(CASE WHEN col = 'DESCRIÇÃO'         THEN txt END) AS descrição,
    MAX(CASE WHEN col = 'SONDA'             THEN txt END) AS sonda
    
FROM base
GROUP BY
    cd_paciente,
    nm_paciente,
    cd_atendimento,
    nm_documento,
    dh_criacao
order by
    dh_criacao;
