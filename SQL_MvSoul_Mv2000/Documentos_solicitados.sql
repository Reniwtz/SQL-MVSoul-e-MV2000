SELECT
    pw_documento_clinico.cd_paciente    AS código_do_paciente,
    paciente.nm_paciente                AS nome_do_paciente,
    pw_documento_clinico.cd_atendimento AS código_do_atendimento,
    pw_documento_clinico.cd_prestador   AS código_do_prestador,
    pw_documento_clinico.cd_usuario     AS nome_do_prestador,
    pw_documento_clinico.nm_documento   AS tipo_de_documento
FROM
         pw_documento_clinico pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    JOIN atendime ON atendime.cd_atendimento = pw_documento_clinico.cd_atendimento
WHERE
        pw_editor_clinico.cd_documento = '227' --AVISO DE CIRURGIA AMBULATORIAL
    AND pw_documento_clinico.tp_status = 'FECHADO'
    AND atendime.cd_ori_ate IN ( '12', '43' )
    AND pw_documento_clinico.dh_criacao BETWEEN TO_DATE('09/02/26', 'DD/MM/YY') AND TO_DATE('10/02/26', 'DD/MM/YY')
GROUP BY
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.cd_prestador,
    pw_documento_clinico.cd_usuario,
    pw_documento_clinico.nm_documento
UNION ALL
SELECT
    pw_documento_clinico.cd_paciente    AS código_do_paciente,
    paciente.nm_paciente                AS nome_do_paciente,
    pw_documento_clinico.cd_atendimento AS código_do_atendimento,
    pw_documento_clinico.cd_prestador   AS código_do_prestador,
    pw_documento_clinico.cd_usuario     AS nome_do_prestador,
    pw_documento_clinico.nm_documento   AS tipo_de_documento
FROM
         pw_documento_clinico pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    JOIN atendime ON atendime.cd_atendimento = pw_documento_clinico.cd_atendimento
WHERE
        pw_editor_clinico.cd_documento = '348' --Solicitação de Autorização - AIH
    AND atendime.cd_ori_ate IN ( '12', '43' )
    AND pw_documento_clinico.dh_criacao BETWEEN TO_DATE('09/02/26', 'DD/MM/YY') AND TO_DATE('10/02/26', 'DD/MM/YY')
GROUP BY
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.cd_prestador,
    pw_documento_clinico.cd_usuario,
    pw_documento_clinico.nm_documento
UNION ALL
SELECT
    pw_documento_clinico.cd_paciente    AS código_do_paciente,
    paciente.nm_paciente                AS nome_do_paciente,
    pw_documento_clinico.cd_atendimento AS código_do_atendimento,
    pw_documento_clinico.cd_prestador   AS código_do_prestador,
    pw_documento_clinico.cd_usuario     AS nome_do_prestador,
    pw_documento_clinico.nm_documento   AS tipo_de_documento
FROM
         pw_documento_clinico pw_documento_clinico
    JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    JOIN paciente ON paciente.cd_paciente = pw_documento_clinico.cd_paciente
    JOIN atendime ON atendime.cd_atendimento = pw_documento_clinico.cd_atendimento
WHERE
        pw_editor_clinico.cd_documento = '349' --Solicitação de órtesee próteses e materiais especiais - OPME
    AND pw_documento_clinico.tp_status = 'FECHADO'
    AND atendime.cd_ori_ate IN ( '12', '43' )
    AND pw_documento_clinico.dh_criacao BETWEEN TO_DATE('09/02/26', 'DD/MM/YY') AND TO_DATE('10/02/26', 'DD/MM/YY')
GROUP BY
    pw_documento_clinico.cd_paciente,
    paciente.nm_paciente,
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.cd_prestador,
    pw_documento_clinico.cd_usuario,
    pw_documento_clinico.nm_documento
