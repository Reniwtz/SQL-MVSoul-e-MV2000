SELECT
    solic_agendamento.dt_referencia  AS data_do_agendamento,
    solic_agendamento.cd_atendimento AS atendimento_pai,
    paciente.cd_paciente             AS cad,
    paciente.nm_paciente             AS nome_do_paciente,
    tratamento.nm_protocolo          AS tratamento
FROM
         solic_agendamento
    INNER JOIN atendime ON solic_agendamento.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN tratamento ON solic_agendamento.cd_tratamento = tratamento.cd_tratamento
WHERE
    solic_agendamento.dt_referencia BETWEEN TO_DATE('01/09/2025', 'DD/MM/YYYY') AND TO_DATE('30/09/2025', 'DD/MM/YYYY')
    AND solic_agendamento.tp_situacao LIKE 'A'
    AND solic_agendamento.tp_agendamento LIKE '%QUI%'
GROUP BY
    solic_agendamento.dt_referencia,
    solic_agendamento.cd_atendimento,
    paciente.cd_paciente,
    paciente.nm_paciente,
    tratamento.nm_protocolo
