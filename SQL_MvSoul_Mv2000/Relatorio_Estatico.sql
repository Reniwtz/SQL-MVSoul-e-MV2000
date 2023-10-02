-- ConsultasAmbulatoriais
-- SUS - Consultas Médicas - Radioterapia e Ambulatorio - ADULTOS
select 'Adulto - SUS', count(cd_atendimento) from atendime     where dt_atendimento BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
   and cd_ori_ate not in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde) 
   and cd_convenio = 2
   and tp_atendimento = 'A'
union all
-- Planos de Saúde - Consultas Médicas - Radioterapia e Ambulatorio  - ADULTOS
select 'Adulto - P.Saude ', count(cd_atendimento)     from atendime     where dt_atendimento BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
   and cd_ori_ate not in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde)
   and cd_convenio not in (2,16)   -- (2 SUS Ambulatorio) (16 Particular)
   and tp_atendimento = 'A'
union all
-- Particular - Consultas Médicas - Radioterapia e Ambulatorio  - ADULTOS
select 'Adulto - Particular', count(cd_atendimento) from atendime where dt_atendimento BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
   and cd_ori_ate not in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde)
   and cd_convenio in (16)   -- (2 SUS Ambulatorio) (16 Particular)
   and tp_atendimento = 'A'
union all
-- PEDIATRIA
-- SUS - Consultas Médicas - Radioterapia e Ambulatorio - ADULTOS
select 'Pediatria - SUS', count(cd_atendimento) from atendime     where dt_atendimento BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
   and cd_ori_ate in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde) 
   and cd_convenio = 2
   and tp_atendimento = 'A'
union all
-- Planos de Saúde - Consultas Médicas - Radioterapia e Ambulatorio  - ADULTOS
select 'Pediatria - P.Saude', count(cd_atendimento)     from atendime     where dt_atendimento BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
   and cd_ori_ate in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde)
   and cd_convenio not in (2,16)   -- (2 SUS Ambulatorio) (16 Particular)
   and tp_atendimento = 'A'
union all
-- Particular - Consultas Médicas - Radioterapia e Ambulatorio  - ADULTOS
select 'Pediatria - Particular', count(cd_atendimento) from atendime where dt_atendimento BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
   and cd_ori_ate in (30)   -- (12 Ambulatorial) (30 Pediatria) (14 Radio Consulta) (31 Planos de Saúde)
   and cd_convenio in (16)   -- (2 SUS Ambulatorio) (16 Particular)
   and tp_atendimento = 'A'

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






