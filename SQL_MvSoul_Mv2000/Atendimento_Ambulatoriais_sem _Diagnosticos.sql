select decode(a.tp_atendimento,'A','Ambulatorio')as tipo_atend,
       a.cd_atendimento as Atendimento,
       a.hr_alta_medica as alta_medica,
       hr_alta as alta_hospitalar,
       a.cd_cid || ' ' || a.cd_cid_obito as Cid_Principal,
       b.ds_tip_res as Resultado
  from atendime a, tip_res b
 where a.tp_Atendimento = 'A'
   and b.cd_tip_res(+) = a.cd_tip_res
   and a.cd_cid is null
   and a.cd_tip_res is null
   and a.cd_cid_obito is null
   and trunc(a.dt_atendimento) between '01/01/2023' and '31/12/2023'
   
   union all 
   
  select 'Total de Atendimentos Amb : ',
       count(a.cd_atendimento)Total_Atend,
       a.hr_alta_medica,
       hr_alta as alta_hosp,
       a.cd_cid || ' ' || a.cd_cid_obito as Cids,
       b.ds_tip_res
  from atendime a, tip_res b
 where a.tp_Atendimento = 'A'
   and b.cd_tip_res(+) = a.cd_tip_res
   and a.cd_cid is null
   and a.cd_tip_res is null
   and a.cd_cid_obito is null
   and trunc(a.dt_atendimento) between '01/01/2023' and '31/12/2023'
   group by  a.hr_alta_medica,
       hr_alta ,
       a.cd_cid || ' ' || a.cd_cid_obito,
       b.ds_tip_res,a.tp_atendimento
