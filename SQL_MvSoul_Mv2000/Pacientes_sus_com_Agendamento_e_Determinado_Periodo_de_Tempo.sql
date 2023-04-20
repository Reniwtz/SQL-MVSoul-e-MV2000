SELECT
    i.hr_agenda           AS data_e_hora,
    i.nm_paciente         AS paciente,
    i.dt_nascimento       AS data_de_nascimento,
    i.nr_ddd_fone         AS dd_telefone,
    i.nr_fone             AS telefone,
    i.nr_ddd_celular      AS dd_celular,
    i.nr_celular          AS celular,
    a.ds_item_agendamento AS item_de_agendamento,
    s.ds_ser_dis          AS serviço,
    t.ds_tip_mar          AS tipo_de_marcação,
    c.nm_convenio         AS convênio,
    i.sn_encaixe          AS encaixe
FROM
    it_agenda_central i,
    item_agendamento  a,
    ser_dis           s,
    tip_mar           t,
    convenio          c
WHERE
    hr_agenda BETWEEN ( '27/03/2023' ) AND ( '01/05/2023' )
    AND cd_paciente IS NOT NULL
    AND i.cd_tip_mar LIKE '2'
    AND a.cd_item_agendamento = i.cd_item_agendamento
    AND s.cd_ser_dis = i.cd_ser_dis
    AND t.cd_tip_mar = i.cd_tip_mar
    AND c.cd_convenio = i.cd_convenio
    AND i.cd_convenio = '2'
ORDER BY
    i.nm_paciente;
    