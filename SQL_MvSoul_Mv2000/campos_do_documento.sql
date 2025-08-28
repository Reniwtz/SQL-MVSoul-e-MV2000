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



SELECT
    procedimento_sus.cd_procedimento,
    procedimento_sus.cd_procedimento
    || ' - '
    || procedimento_sus.ds_procedimento,
    'TRUE'
FROM
    procedimento_sus
