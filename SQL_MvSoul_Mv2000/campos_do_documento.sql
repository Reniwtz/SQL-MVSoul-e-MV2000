SELECT
    pw_documento_clinico.cd_atendimento,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'TX_NOMPRIN_AUTOPA_1' THEN
                dbms_lob.substr(editor_registro_campo.lo_valor, 4000)
        END
    ) AS tx_nomprim_autopa_1,
    MAX(
        CASE
            WHEN editor_campo.ds_identificador = 'CB_NOMESEC_AUTOPA_1' THEN
                dbms_lob.substr(editor_registro_campo.lo_valor, 4000)
        END
    ) AS cb_nomsec_autopa_1
FROM
         pw_documento_clinico pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN editor_registro_campo ON editor_registro_campo.cd_registro = pw_editor_clinico.cd_editor_registro
    JOIN editor_campo ON editor_campo.cd_campo = editor_registro_campo.cd_campo
WHERE
        pw_documento_clinico.tp_status = 'FECHADO'
    AND pw_documento_clinico.cd_atendimento = '4194846'
    AND pw_editor_clinico.cd_documento IN ( 370 )
    AND editor_campo.ds_identificador IN ( 'TX_NOMPRIN_AUTOPA_1', 'CB_NOMESEC_AUTOPA_1' )
    AND pw_documento_clinico.cd_documento_clinico = (
        SELECT
            MAX(pw_documento_clinico.cd_documento_clinico)
        FROM
                 pw_documento_clinico pw_documento_clinico
            JOIN pw_editor_clinico pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
        WHERE
                pw_documento_clinico.tp_status = 'FECHADO'
            AND pw_documento_clinico.cd_atendimento = '4194846'
            AND pw_editor_clinico.cd_documento IN ( 370 )
    )
GROUP BY
    pw_documento_clinico.cd_atendimento;

    
----------------------------------------------------------------------------------------------------------------------
SELECT
    pdc.cd_atendimento,
    MAX(CASE
        WHEN ecp.ds_identificador = 'TX_NOMPRIN_AUTOPA_1'
        THEN DBMS_LOB.SUBSTR(erc.lo_valor, 4000)
    END) AS tx_nomprim_autopa_1,

    MAX(CASE
        WHEN ecp.ds_identificador = 'CB_NOMESEC_AUTOPA_1'
        THEN DBMS_LOB.SUBSTR(erc.lo_valor, 4000)
    END) AS cb_nomsec_autopa_1

FROM
    dbamv.pw_documento_clinico  pdc
    JOIN dbamv.pw_editor_clinico     pec ON pec.cd_documento_clinico = pdc.cd_documento_clinico
    JOIN dbamv.editor_registro_campo erc ON erc.cd_registro = pec.cd_editor_registro
    JOIN dbamv.editor_campo          ecp ON ecp.cd_campo = erc.cd_campo

WHERE
    pdc.tp_status = 'FECHADO'
    AND pdc.cd_atendimento = '4194846'
    AND pec.cd_documento IN (370)
    AND ecp.ds_identificador IN (
        'TX_NOMPRIN_AUTOPA_1',
        'CB_NOMESEC_AUTOPA_1'
    )
    AND pdc.cd_documento_clinico = (
        SELECT MAX(pdc.cd_documento_clinico)
        FROM dbamv.pw_documento_clinico pdc
        JOIN dbamv.pw_editor_clinico pec ON pec.cd_documento_clinico = pdc.cd_documento_clinico
        WHERE pdc.tp_status = 'FECHADO'
          AND pdc.cd_atendimento = '4194846'
          AND pec.cd_documento IN (370)
    )
GROUP BY
    pdc.cd_atendimento;
    


---------------------------------------------------------------------------------------
SELECT
    procedimento_sus.cd_procedimento,
    procedimento_sus.cd_procedimento
    || ' - '
    || procedimento_sus.ds_procedimento,
    'TRUE'
FROM
    procedimento_sus
