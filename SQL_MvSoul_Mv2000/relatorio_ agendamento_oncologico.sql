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

--------------------------------------------------------------------------------
SELECT
    atendime.cd_paciente,
    atendime.dt_atendimento
FROM
    atendime atendime
WHERE
        atendime.sn_atendimento_apac = 'S'
    AND atendime.dt_atendimento BETWEEN TO_DATE('01/09/2025', 'DD/MM/YYYY') AND TO_DATE('30/09/2025', 'DD/MM/YYYY')
    AND atendime.cd_paciente IN (
        SELECT
            paciente.cd_paciente AS cad
        FROM
                 solic_agendamento
            INNER JOIN atendime ON solic_agendamento.cd_atendimento = atendime.cd_atendimento
            INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
        WHERE
            solic_agendamento.dt_referencia BETWEEN TO_DATE('01/09/2025', 'DD/MM/YYYY') AND TO_DATE('30/09/2025', 'DD/MM/YYYY')
            AND solic_agendamento.tp_situacao LIKE 'A'
            AND solic_agendamento.tp_agendamento LIKE '%QUI%'
        GROUP BY
            paciente.cd_paciente
    )
GROUP BY
    atendime.cd_paciente,
    atendime.dt_atendimento

--------------------------------------------------------------------------------
SELECT
    atendime.cd_procedimento                                                                AS codigo_do_procedimento,
    procedimento_sus.ds_procedimento                                                        AS descricao_do_procedimento,
    to_char(atendime.dt_atendimento, 'DD/MM/YYYY')                                          AS data,
    SUM(teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico) AS total
FROM
         atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    LEFT JOIN (
        SELECT
            t1.*
        FROM
            teto_orcamentario_proced_sus t1
        WHERE
            t1.cd_fat_sia = (
                SELECT
                    MAX(cd_fat_sia)
                FROM
                    teto_orcamentario_proced_sus
            )
    ) teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
        atendime.sn_atendimento_apac = 'S'
    AND cd_atendimento IN (
        SELECT
            solic_agendamento.cd_atendimento
        FROM
            solic_agendamento
        WHERE
            solic_agendamento.dt_referencia BETWEEN TO_DATE('01/09/2025', 'DD/MM/YYYY') AND TO_DATE('30/09/2025', 'DD/MM/YYYY')
            AND solic_agendamento.tp_situacao LIKE 'A'
            AND solic_agendamento.tp_agendamento LIKE '%QUI%'
        GROUP BY
            solic_agendamento.cd_atendimento
    )
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    to_char(atendime.dt_atendimento, 'DD/MM/YYYY')
ORDER BY
    data
