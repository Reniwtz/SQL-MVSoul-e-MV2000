SELECT
    atendime.tp_atendimento,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.cd_documento_clinico,
    pw_documento_clinico.cd_paciente
FROM
    dbamv.pagu_objeto,
    dbamv.pw_documento_clinico,
    dbamv.atendime
WHERE
        pw_documento_clinico.cd_objeto = pagu_objeto.cd_objeto
    AND pw_documento_clinico.cd_atendimento = atendime.cd_atendimento
    AND pw_documento_clinico.cd_paciente = 272064
    AND pagu_objeto.tp_objeto = 'EVOMED'
    AND pw_documento_clinico.tp_status = 'ABERTO'


--Se Por ventura tiver uma evolução aberta, essa deverá ser fechada, se não conseguir fechar via sistema, pode fechar via BD.

UPDATE pw_documento_clinico
SET
    tp_status = 'FECHADO'
WHERE
    cd_documento_clinico = 1426441
