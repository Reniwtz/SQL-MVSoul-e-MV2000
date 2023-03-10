select a.cd_solsai_pro as Solicitacao,
       a.cd_pre_med as Prescricao,
       a.cd_estoque as Estoque,
       case a.tp_situacao when 'P' then 'Pedido'
                          when 'C' then 'Atend.Parcial'
         else ''
           end  as Situacao,
       case  a.tp_solsai_pro when 'P' then '<font size="3" color="FF0000">Pedido-Paciente</font>'
                            when 'S' then 'Pedido-Setores'
                              when 'C' then '<font size="3" color=" #800080">Devol-Paciente</font>'
                                when 'E' then 'Pedido-Estoque'
                                  when 'D' then 'Devol-Setor'
                                    
         else  a.tp_solsai_pro
           end as Tipo_Solicitacao,
           paciente.nm_paciente as paciente,
       a.cd_setor as Setor_Solicitante,
       a.cd_atendimento as Atendimento,
       a.cd_unid_int as Unid_Intern,
       to_char(a.dt_solsai_pro, 'dd/mm/yyyy') as Data_Solicitacao,
       to_char(a.hr_solsai_pro, 'hh24:mm:ss') as Hora,
       a.cd_turno as I_Neces,
       case a.sn_emitido when 'S' then 'Sim '
                         when 'N' then 'Não'
                           else  'Não'
                             end as Impres,
       case a.sn_urgente when 'N' then '<img src="imagens/verde.png" >'
                         when 'S' then '<img src="imagens/vermelho2.gif" >'
                           else ''
                             end as Urg
  from solsai_pro a,atendime,paciente 
 where a.tp_situacao not in ('S', 'A') --confirmado ou cancelado nao mostrar
   and a.tp_solsai_pro in ('P','S','C','E','D')
   and a.cd_estoque = 9
   and atendime.cd_atendimento (+)= a.cd_atendimento
   and paciente.cd_paciente (+)= atendime.cd_paciente
   and a.tp_situacao  = 'P'
   and a.tp_solsai_pro in ('P','C')
  and trunc(a.dt_solsai_pro) between Sysdate-2 and sysdate
   order by  a.dt_solsai_pro desc
