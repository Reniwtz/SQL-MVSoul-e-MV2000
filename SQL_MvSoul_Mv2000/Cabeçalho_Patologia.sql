SELECT
    itped_rx.cd_ped_rx      AS pedido,
    itped_rx.cd_laudo       AS laudo,
    ped_rx.dt_pedido        AS data_do_pedido,
    itped_rx.dt_entrega     AS data_do_laudo,
    paciente.cd_paciente    AS cadastro_do_paciente,
    same.nr_matricula_same  AS matricula_same,
    ped_rx.nr_controle      AS numero_controle,
    paciente.nm_paciente    AS nome_do_paciente,
    paciente.dt_nascimento  AS data_de_nasc_paciente,
    atendime.cd_atendimento AS codigo_do_atendimento,
    paciente.nm_mae         AS nome_da_mae,
    ped_rx.nm_prestador     AS medico_solicitante,
    ped_rx.ds_observacao    AS procedencia
FROM
         itped_rx
    INNER JOIN ped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    INNER JOIN atendime ON ped_rx.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN same ON same.cd_paciente = paciente.cd_paciente
WHERE
    itped_rx.cd_laudo IS NOT NULL
    AND ped_rx.cd_setor = 43
    AND ped_rx.cd_set_exa = 13
    AND ped_rx.dt_pedido BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('21/08/2024', 'DD/MM/YYYY')
    AND itped_rx.cd_ent_psdi IS NOT NULL
GROUP BY
    itped_rx.cd_ped_rx,
    itped_rx.cd_laudo,
    ped_rx.dt_pedido,
    itped_rx.dt_entrega,
    paciente.cd_paciente,
    same.nr_matricula_same,
    ped_rx.nr_controle,
    paciente.nm_paciente,
    paciente.dt_nascimento,
    atendime.cd_atendimento,
    paciente.nm_mae,
    ped_rx.nm_prestador,
    ped_rx.ds_observacao;
