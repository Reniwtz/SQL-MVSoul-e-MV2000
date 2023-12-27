SELECT
    s.cd_solsai_pro solicitacao,
    decode(s.tp_solsai_pro, 'C', 'Devol. Paciente', 'E', 'Ped. Estoque',
           'P', 'Ped. Paciente', 'D', 'Devol. Setor', 'S','Ped. Setor')tipo,
    decode(s.tp_situacao, 'C', 'Atend. Parcial', 'P', 'Pedido')situacao,
    se.nm_setor setor,
    p.nm_paciente nome_do_paciente,
    e.ds_estoque estoque,
    s.hr_solsai_pro horario,
    s.cd_pre_med pescricao,
    decode(s.sn_urgente, 'N', 'Não', 'S', 'Sim') urgente,
    i.cd_tip_fre tipo_de_Frequencia,
    t.ds_tip_fre descricao
FROM
    solsai_pro s,
    setor      se,
    pre_med    pm,
    estoque    e,
    paciente   p,
    atendime   a,
    itpre_med  i,
    tip_fre    t
WHERE
    s.tp_situacao IN ( 'P', 'C' )
    AND s.cd_setor = se.cd_setor
    AND s.cd_estoque = e.cd_estoque
    AND s.cd_pre_med = pm.cd_pre_med (+)
    AND s.cd_atendimento = a.cd_atendimento (+)
    AND a.cd_paciente = p.cd_paciente (+)
    AND pm.cd_pre_med = i.cd_pre_med
    AND i.cd_tip_fre = t.cd_tip_fre
    AND s.dt_solsai_pro > ( sysdate - 2 )
    AND s.cd_estoque in (6)
    AND (t.ds_tip_fre = 'ACM' 
        OR t.ds_tip_fre = 'SN'
        OR t.ds_tip_fre = 'AGORA')
ORDER BY
    s.sn_urgente DESC,
    s.hr_solsai_pro ASC
