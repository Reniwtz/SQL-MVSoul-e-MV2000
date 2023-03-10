select d.cd_atendimento,
       e.nm_convenio,
       a.dt_inicio_age_cir as data_agendamento,
       b.cd_aviso_cirurgia as aviso,
       c.ds_sal_cir as sala,
       b.nm_paciente as paciente,
       case b.tp_situacao
         when 'G' then
          'Agendado'
         when 'R' then
          'Realizada'
         when 'C' then
          'Cancelada'
         else
          ''
       end tp_situacao,
       cirurgia.ds_cirurgia,
       decode(b.sn_uti,'N','Não','S','Sim') as sn_uti,
       b.tp_sanguineo
  from age_cir        a,
       aviso_cirurgia b,
       sal_cir        c,
       atendime       d,
       convenio       e,
       cirurgia_aviso,
       cirurgia
 where trunc(a.dt_inicio_age_cir) = trunc(sysdate)
   and a.cd_aviso_cirurgia(+) = b.cd_aviso_cirurgia
   and a.cd_sal_cir = c.cd_sal_cir
   and d.cd_atendimento = b.cd_atendimento
   and e.cd_convenio = d.cd_convenio
   and b.tp_situacao not in ('R')
   and cirurgia_aviso.cd_aviso_cirurgia = b.cd_aviso_cirurgia
   and cirurgia_aviso.cd_cirurgia = cirurgia.cd_cirurgia

