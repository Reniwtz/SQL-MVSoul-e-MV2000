 -- SUS - Consultas Médicas - Radioterapia e Ambulatorio - ADULTOS
select 'Adulto - SUS', count(cd_atendimento) from atendime     where dt_atendimento between '01/08/2022' and '31/08/2022'
   and cd_ori_ate not in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde) 
   and cd_convenio = 2
   and tp_atendimento = 'A'
union all
-- Planos de Saúde - Consultas Médicas - Radioterapia e Ambulatorio  - ADULTOS
select 'Adulto - P.Saude ', count(cd_atendimento)     from atendime     where dt_atendimento between '01/08/2022' and '31/08/2022'
   and cd_ori_ate not in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde)
   and cd_convenio not in (2,16)   -- (2 SUS Ambulatorio) (16 Particular)
   and tp_atendimento = 'A'
union all
-- Particular - Consultas Médicas - Radioterapia e Ambulatorio  - ADULTOS
select 'Adulto - Particular', count(cd_atendimento) from atendime where dt_atendimento between '01/08/2022' and '31/08/2022'
   and cd_ori_ate not in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde)
   and cd_convenio in (16)   -- (2 SUS Ambulatorio) (16 Particular)
   and tp_atendimento = 'A'
union all
-- PEDIATRIA
-- SUS - Consultas Médicas - Radioterapia e Ambulatorio - ADULTOS
select 'Pediatria - SUS', count(cd_atendimento) from atendime     where dt_atendimento between '01/08/2022' and '31/08/2022'
   and cd_ori_ate in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde) 
   and cd_convenio = 2
   and tp_atendimento = 'A'
union all
-- Planos de Saúde - Consultas Médicas - Radioterapia e Ambulatorio  - ADULTOS
select 'Pediatria - P.Saude', count(cd_atendimento)     from atendime     where dt_atendimento between '01/08/2022' and '31/08/2022'
   and cd_ori_ate in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde)
   and cd_convenio not in (2,16)   -- (2 SUS Ambulatorio) (16 Particular)
   and tp_atendimento = 'A'
union all
-- Particular - Consultas Médicas - Radioterapia e Ambulatorio  - ADULTOS
select 'Pediatria - Particular', count(cd_atendimento) from atendime where dt_atendimento between '01/08/2022' and '31/08/2022'
   and cd_ori_ate in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde)
   and cd_convenio in (16)   -- (2 SUS Ambulatorio) (16 Particular)
   and tp_atendimento = 'A'
/*
   select distinct(cd_procedimento),qt_produzida from atendime where dt_atendimento between '01/01/2016' and '31/01/2016' group by cd_atendimento,cd_procedimento
   select * from eve_siasus where dt_eve_siasus between '01/01/2016' and '31/01/2016' and cd_procedimento = '0301010072' -- Consultas Médicas
   select * from ori_ate order by ds_ori_ate
   select * from atendime where dt_atendimento between '01/01/2016' and '31/01/2016'
*/
