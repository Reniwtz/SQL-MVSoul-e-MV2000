SELECT
    paciente.cd_paciente                   AS código_do_paciente,
    paciente.nm_paciente                   AS nome_do_paciente,
    paciente.dt_nascimento                 AS data_de_nacimento,
    tipo_sexo.nm_sexo                      AS sexo,
    paciente.nr_ddd_fone                   AS dd,
    paciente.nr_fone                       AS telefone,
    solic_agendamento.cd_solic_agendamento AS número_da_solicitação,
    solic_agendamento.dt_solic_agendamento AS data,
    solic_agendamento.cd_atendimento       AS atendimento,
    prestador.nm_prestador                 AS médico,
    ori_ate.ds_ori_ate                     AS setor,
    convenio.nm_convenio                   AS convênio,
    con_pla.ds_con_pla                     AS plano,
    tip_mar.ds_tip_mar                     AS tipo_de_atendimento,
    solic_agendamento.cd_item_agendamento  AS item_de_agendamento,
    item_agendamento.ds_item_agendamento   AS descrição
FROM
         solic_agendamento solic_agendamento
    INNER JOIN item_agendamento ON item_agendamento.cd_item_agendamento = solic_agendamento.cd_item_agendamento
    INNER JOIN atendime ON atendime.cd_atendimento = solic_agendamento.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN tipo_sexo ON tipo_sexo.tp_sexo = paciente.tp_sexo
    INNER JOIN prestador ON prestador.cd_prestador = atendime.cd_prestador
    INNER JOIN convenio ON convenio.cd_convenio = atendime.cd_convenio
    INNER JOIN con_pla ON con_pla.cd_convenio = atendime.cd_convenio
    INNER JOIN ori_ate ON ori_ate.cd_ori_ate = atendime.cd_ori_ate
    INNER JOIN tip_mar ON tip_mar.cd_tip_mar = atendime.cd_tip_mar
WHERE
    solic_agendamento.cd_atendimento LIKE '3922433'
