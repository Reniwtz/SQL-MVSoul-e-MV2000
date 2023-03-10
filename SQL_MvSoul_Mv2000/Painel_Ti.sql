select t.semana_ano,
       case
         when t.semana = '1' then 'DOMINGO'
         when t.semana = '2' then 'SEGUNDA'
         when t.semana = '3' then 'TERÇA'
         when t.semana = '4' then 'QUARTA'
         when t.semana = '5' then 'QUINTA'
         when t.semana = '6' then 'SEXTA'
         when t.semana = '7' then 'SABADO'
       end as semana,
       --t.dia||'-'||t.total as marcacoes
       t.dia,
       t.total
from (
  select to_char(solicitacao_os.dt_pedido,'IW') as semana_ano,
         to_char(solicitacao_os.dt_pedido,'D') as semana,
         to_char(solicitacao_os.dt_pedido,'dd/mm/yyyy') as dia,
         count(distinct solicitacao_os.cd_os) as total
  from solicitacao_os 
  inner join setor on solicitacao_os.cd_setor = setor.cd_setor
  where to_char(solicitacao_os.dt_pedido,'IW.YYYY') = to_char(sysdate,'IW.YYYY')
  and cd_oficina = 2
  group by to_char(solicitacao_os.dt_pedido,'D'),
           to_char(solicitacao_os.dt_pedido,'IW'),
           to_char(solicitacao_os.dt_pedido,'dd/mm/yyyy')
  order by to_number(to_char(solicitacao_os.dt_pedido,'IW')),
           to_date(to_char(solicitacao_os.dt_pedido,'dd/mm/yyyy'))
) t
order by 1,3
