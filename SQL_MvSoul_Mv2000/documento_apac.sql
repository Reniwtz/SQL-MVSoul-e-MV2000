WITH base_dados AS (
    SELECT
        pw_documento_clinico.cd_paciente AS cad,
        paciente.nm_paciente AS nome_do_paciente,
        pw_documento_clinico.cd_atendimento AS atendimento,
        pw_documento_clinico.nm_documento AS tipo_de_documento,
        MAX(
            CASE
                WHEN editor_campo.ds_identificador = 'TX_NOMPRIN_AUTOPA_1' THEN
                    SUBSTR(DBMS_LOB.SUBSTR(editor_registro_campo.lo_valor, 4000), 1, 10)
            END
        ) AS procedimento
    FROM
        pw_documento_clinico
        INNER JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        INNER JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
        INNER JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
        INNER JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    WHERE
        pw_documento_clinico.tp_status = 'FECHADO'
        AND pw_editor_clinico.cd_documento IN (370)
        AND editor_campo.ds_identificador IN ('TX_NOMPRIN_AUTOPA_1', 'CB_NOMESEC_AUTOPA_1')
        AND pw_documento_clinico.dh_referencia BETWEEN TO_DATE('01/08/2025', 'DD/MM/YYYY') AND TO_DATE('31/08/2025', 'DD/MM/YYYY')
    GROUP BY
        pw_documento_clinico.cd_paciente,
        paciente.nm_paciente,
        pw_documento_clinico.cd_atendimento,
        pw_documento_clinico.nm_documento
)

SELECT
    bd.*,
    tos.qt_fisico AS quantidade_total_contrato,
    psus.ds_procedimento as descrição_do_procedimento,
    ROUND(tos.vl_orcamento / NULLIF(tos.qt_fisico, 0), 2) AS valor_unitario_contrato,
    tos.vl_orcamento AS valor_total_contrato
FROM
    base_dados bd
LEFT JOIN (
    SELECT *
    FROM teto_orcamentario_proced_sus
    WHERE cd_fat_sia = (
        SELECT MAX(cd_fat_sia) FROM teto_orcamentario_proced_sus
    )
) tos ON tos.cd_procedimento = bd.procedimento
LEFT JOIN procedimento_sus psus ON psus.cd_procedimento = bd.procedimento


----------------------------------------------------------------------------------------------------------
WITH base_dados AS (
    SELECT
        MAX(
            CASE
                WHEN editor_campo.ds_identificador = 'TX_NOMPRIN_AUTOPA_1' THEN
                    SUBSTR(DBMS_LOB.SUBSTR(editor_registro_campo.lo_valor, 4000), 1, 10)
            END
        ) AS procedimento
    FROM
        pw_documento_clinico
        INNER JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        INNER JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
        INNER JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
        INNER JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    WHERE
        pw_documento_clinico.tp_status = 'FECHADO'
        AND pw_editor_clinico.cd_documento IN (370)
        AND editor_campo.ds_identificador = 'TX_NOMPRIN_AUTOPA_1'
        AND pw_documento_clinico.dh_referencia BETWEEN TO_DATE('01/08/2025', 'DD/MM/YYYY') AND TO_DATE('31/08/2025', 'DD/MM/YYYY')
    GROUP BY
        pw_documento_clinico.cd_paciente,
        paciente.nm_paciente,
        pw_documento_clinico.cd_atendimento,
        pw_documento_clinico.nm_documento
)

SELECT
    bd.procedimento,
    tos.qt_fisico AS quantidade_total_contrato,
    ROUND(tos.vl_orcamento / NULLIF(tos.qt_fisico, 0), 2) AS valor_unitario_contrato,
    tos.vl_orcamento AS valor_total_contrato,
    COUNT(*) AS quantidade_solicita,
    (ROUND(tos.vl_orcamento / NULLIF(tos.qt_fisico, 0), 2) * COUNT(*)) AS Valor_solicitado
FROM
    base_dados bd
    LEFT JOIN (
        SELECT *
        FROM teto_orcamentario_proced_sus
        WHERE cd_fat_sia = (
            SELECT MAX(cd_fat_sia) FROM teto_orcamentario_proced_sus
        )
    ) tos ON tos.cd_procedimento = bd.procedimento
GROUP BY
    bd.procedimento,
    tos.qt_fisico,
    tos.vl_orcamento;

