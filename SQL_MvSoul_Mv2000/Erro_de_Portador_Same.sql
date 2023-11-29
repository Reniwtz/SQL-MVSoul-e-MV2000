SELECT DISTINCT
    it_same_protocolos.nr_matricula_same,
    it_same_protocolos.nr_volume,
    same.cd_cad_same,
    portadores.cd_portador,
    portadores.ds_portador,
    portador_dest.cd_portador                                cd_portador_destino,
    portador_dest.ds_portador                                ds_portador_destino,
    it_same_protocolos.cd_atendimento,
    protocolos.dt_prev_retorno,
    protocolos.dt_saida,
    to_char(it_same_protocolos.dt_recebimento, 'DD/MM/YYYY')
    || ' '
    || to_char(it_same_protocolos.hr_recebimento, 'HH24:MI') dt_recebimento,
    protocolos.cd_protocolo,
    decode(nvl(it_same_protocolos.sn_recebimento_automatico, 'N'),
           'S',
           dbamv.pkg_rmi_traducao.extrair_pkg_msg('MSG_1', 'QUERY_C_PAC_PRONT', 'Receb. AutomÃ¡tico'),
           it_same_protocolos.cd_usuario_recebimento)        cd_usuario_recebimento,
    (
        SELECT
            nm_usuario
        FROM
            dbasgu.usuarios
        WHERE
            cd_usuario = it_same_protocolos.cd_usuario_recebimento
    )                                                        nm_usuario_recebimento,
    (
        SELECT
            cd_usuario
        FROM
            dbasgu.usuarios
        WHERE
            cd_usuario = protocolos.nm_usuario
    )                                                        cd_usuario_saida,
    (
        SELECT
            nm_usuario
        FROM
            dbasgu.usuarios
        WHERE
            cd_usuario = protocolos.nm_usuario
    )                                                        nm_usuario_saida
FROM
    dbamv.protocolos,
    dbamv.it_same_protocolos,
    dbamv.portadores,
    dbamv.portadores portador_dest,
    dbamv.same
WHERE
        protocolos.cd_protocolo = it_same_protocolos.cd_protocolo
    AND it_same_protocolos.nr_matricula_same = same.nr_matricula_same
    AND it_same_protocolos.nr_volume = same.nr_volume
    AND protocolos.cd_portador = portadores.cd_portador
    AND it_same_protocolos.cd_cad_same = same.cd_cad_same
    AND protocolos.cd_portador_destino = portador_dest.cd_portador (+)
    AND same.nr_matricula_same = 177948
    AND ( it_same_protocolos.cd_atendimento = nvl(:cd_atendimento, - 1)
          OR nvl(:cd_atendimento, - 1) = - 1 );

-----------------------------------------------------------------------
SELECT
    cd_paciente
FROM
    dbamv.atendime
WHERE
    cd_atendimento = 3733982;

UPDATE it_same_protocolos
SET
    cd_atendimento = 3733982
WHERE
        nr_matricula_same = 177948
    AND cd_protocolo = 495391;

-------------------------------------------------------------------
SELECT
    cd_paciente,
    cd_atendimento,
    cd_multi_empresa
FROM
    dbamv.atendime
WHERE
    cd_atendimento = 3733982;

SELECT
    *
FROM
    dbamv.cad_same;

=================================================================

SELECT
    *
FROM
    dbamv.it_same
WHERE
        cd_cad_same = 1
    AND ( ( cd_atendimento ) IN (
        SELECT
            cd_atendimento
        FROM
            atendime atendime
        WHERE
                atendime.cd_multi_empresa = 1
            AND ( atendime.cd_paciente = 402006 )
    ) );

SELECT
    *
FROM
    dbamv.it_same;


-------------------------------------------------------------

SELECT
    *
FROM
    dbamv.it_same
WHERE
        cd_cad_same = 1
    AND ( ( cd_atendimento ) IN (
        SELECT
            cd_atendimento
        FROM
            atendime atendime
        WHERE
                atendime.cd_multi_empresa = 1
            AND ( atendime.cd_paciente LIKE '402006' )
    ) );
    
--------------------------------------------------------------------------------

SELECT
    cd_paciente,
    cd_multi_empresa
FROM
    dbamv.atendime
WHERE
    cd_atendimento = 1693;
            
--------------------------------------------------------------------------------

SELECT DISTINCT
    it_same_protocolos.nr_matricula_same,
    it_same_protocolos.nr_volume,
    same.cd_cad_same,
    portadores.cd_portador,
    portadores.ds_portador,
    portador_dest.cd_portador                                cd_portador_destino,
    portador_dest.ds_portador                                ds_portador_destino,
    it_same_protocolos.cd_atendimento,
    protocolos.dt_prev_retorno,
    protocolos.dt_saida,
    to_char(it_same_protocolos.dt_recebimento, 'DD/MM/YYYY')
    || ' '
    || to_char(it_same_protocolos.hr_recebimento, 'HH24:MI') dt_recebimento,
    protocolos.cd_protocolo,
    decode(nvl(it_same_protocolos.sn_recebimento_automatico, 'N'),
           'S',
           dbamv.pkg_rmi_traducao.extrair_pkg_msg('MSG_1', 'QUERY_C_PAC_PRONT', 'Receb. AutomÃ¡tico'),
           it_same_protocolos.cd_usuario_recebimento)        cd_usuario_recebimento,
    (
        SELECT
            nm_usuario
        FROM
            dbasgu.usuarios
        WHERE
            cd_usuario = it_same_protocolos.cd_usuario_recebimento
    )                                                        nm_usuario_recebimento,
    (
        SELECT
            cd_usuario
        FROM
            dbasgu.usuarios
        WHERE
            cd_usuario = protocolos.nm_usuario
    )                                                        cd_usuario_saida,
    (
        SELECT
            nm_usuario
        FROM
            dbasgu.usuarios
        WHERE
            cd_usuario = protocolos.nm_usuario
    )                                                        nm_usuario_saida
FROM
    dbamv.protocolos,
    dbamv.it_same_protocolos,
    dbamv.portadores,
    dbamv.portadores portador_dest,
    dbamv.same
WHERE
        protocolos.cd_protocolo = it_same_protocolos.cd_protocolo
    AND it_same_protocolos.nr_matricula_same = same.nr_matricula_same
    AND it_same_protocolos.nr_volume = same.nr_volume
    AND protocolos.cd_portador = portadores.cd_portador
    AND it_same_protocolos.cd_cad_same = same.cd_cad_same
    AND protocolos.cd_portador_destino = portador_dest.cd_portador (+)
    AND same.nr_matricula_same = 177948
    AND ( it_same_protocolos.cd_atendimento = nvl(:cd_atendimento, - 1)
          OR nvl(:cd_atendimento, - 1) = - 1 );


