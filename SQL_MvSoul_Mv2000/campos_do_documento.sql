SELECT
    pw_documento_clinico.cd_documento_clinico,
    pw_editor_clinico.cd_editor_registro,
    pw_documento_clinico.cd_paciente    AS cad,
    paciente.nm_paciente                AS nome_do_paciente,
    pw_documento_clinico.cd_atendimento AS atendimento,
    pw_documento_clinico.nm_documento   AS tipo_de_documento
FROM
         pw_documento_clinico pw_documento_clinico
    INNER JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    INNER JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
WHERE
    pw_documento_clinico.cd_objeto LIKE '105' --solicitações
    AND pw_documento_clinico.tp_status LIKE '%FECHADO%'
    AND pw_documento_clinico.dh_referencia BETWEEN TO_DATE('01/08/2025', 'DD/MM/YYYY') AND TO_DATE('31/08/2025', 'DD/MM/YYYY')
    AND pw_editor_clinico.cd_documento IN ( '228', '370' ) --apac
GROUP BY
    pw_documento_clinico.cd_documento_clinico,
    pw_editor_clinico.cd_editor_registro,
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.nm_documento

    
----------------------------------------------------------------------------------------------------------------------
SELECT
    dbms_lob.substr(erc.lo_valor, 4000) AS ds_resposta
FROM
    dbamv.pw_documento_clinico  pdc,
    dbamv.pw_editor_clinico     pec,
    dbamv.editor_registro_campo erc,
    dbamv.editor_campo          ecp
WHERE
        pec.cd_documento_clinico = pdc.cd_documento_clinico
    AND erc.cd_registro = pec.cd_editor_registro
    AND ecp.cd_campo = erc.cd_campo
    AND pdc.tp_status IN ( 'FECHADO' )
    AND pdc.cd_atendimento = 4152614
    AND pec.cd_documento IN ( 370 )
    AND ecp.ds_identificador IN ( 'CB_NOMESEC_AUTOPA_1' )
    AND pdc.cd_documento_clinico = (
        SELECT
            MAX(pdc.cd_documento_clinico)
        FROM
            dbamv.pw_documento_clinico pdc,
            dbamv.pw_editor_clinico    pec
        WHERE
                pec.cd_documento_clinico = pdc.cd_documento_clinico
            AND pdc.tp_status IN ( 'FECHADO' )
            AND pdc.cd_atendimento = 4152614
            AND pec.cd_documento IN ( 370 )
    );


---------------------------------------------------------------------------------------
SELECT
    procedimento_sus.cd_procedimento,
    procedimento_sus.cd_procedimento
    || ' - '
    || procedimento_sus.ds_procedimento,
    'TRUE'
FROM
    procedimento_sus
