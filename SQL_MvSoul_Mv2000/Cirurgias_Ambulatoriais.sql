select count(ac.cd_Aviso_cirurgia) SUS_Amb
  from aviso_cirurgia ac, cirurgia_aviso ca, atendime a
 where ac.cd_aviso_cirurgia in (select ca.cd_aviso_cirurgia from cirurgia_aviso ca)
   and ac.dt_aviso_cirurgia > '30/09/2019' and ac.dt_aviso_cirurgia < '01/11/2019' 
   and ac.cd_cen_cir = 1 
   and ac.tp_situacao in ('A', 'G')
   and ca.cd_convenio = 1
union all
select count(ac.cd_Aviso_cirurgia) Particular
  from aviso_cirurgia ac, cirurgia_aviso ca, atendime a
 where ac.dt_aviso_cirurgia > '30/09/2019' and ac.dt_aviso_cirurgia < '01/11/2019' 
   and ac.cd_cen_cir = 1 
   and ac.tp_situacao in ('A', 'G')
   and ac.cd_aviso_cirurgia = ca.cd_aviso_cirurgia
   and ca.cd_convenio = 16
union all
select count(ac.cd_Aviso_cirurgia) Plano_Saude
  from aviso_cirurgia ac, cirurgia_aviso ca, atendime a
 where ac.dt_aviso_cirurgia > '30/09/2019' and ac.dt_aviso_cirurgia < '01/11/2019' 
   and ac.cd_cen_cir = 1 
   and ac.tp_situacao in ('A', 'G')
   and ac.cd_aviso_cirurgia = ca.cd_aviso_cirurgia
   and ca.cd_convenio not in ('1','2','16')

/*
select * from AVISO_CIRURGIA where dt_aviso_cirurgia between '01/01/2018' and '31/01/2018' and cd_cen_cir = 2 and tp_situacao in ('A', 'G')
select * from CIRURGIA_AVISO order by cd_Aviso_cirurgia
select * from CIRURGIA
select * from CONVENIO
select * from atendime 
*/       


-- Servicos de cirurgia no ambulatorio
SELECT ATENDIME . CD_SER_DIS CD_SER_DIS_SINT, NVL(SER_DIS . DS_SER_DIS, 'NAO INFORMADO') DS_SER_DIS_SINT,
       ATENDIME . CD_TIP_MAR CD_TIP_MAR_SINT,  NVL(TIP_MAR . DS_TIP_MAR, 'NAO INFORMADO') DS_TIP_MAR_SINT,
       COUNT(*) QT_ATENDE_SINT, ATENDIME . CD_CONVENIO CD_CONVENIO, CONVENIO . NM_CONVENIO NM_CONVENIO
  FROM DBAMV . ATENDIME, DBAMV . SER_DIS, DBAMV . TIP_MAR, DBAMV . CONVENIO
 WHERE TRUNC(ATENDIME.DT_ATENDIMENTO) BETWEEN '01/01/2022' AND '31/01/2022'
   AND ATENDIME.CD_SER_DIS = SER_DIS.CD_SER_DIS(+)
   AND ATENDIME.CD_TIP_MAR = TIP_MAR.CD_TIP_MAR(+)
   AND ATENDIME.CD_CONVENIO = CONVENIO.CD_CONVENIO
   AND ATENDIME.CD_MULTI_EMPRESA = '1'
   AND SER_DIS.CD_SER_DIS In ('31', '57', '58', '9', '59', '29', '5', '14', '46', '55') 
--   AND CONVENIO.CD_CONVENIO in ('16')
   AND CONVENIO.CD_CONVENIO in ('2')
--   AND CONVENIO.CD_CONVENIO not in('1','2','16')
 GROUP BY ATENDIME.CD_SER_DIS,   NVL(SER_DIS.DS_SER_DIS, 'NAO INFORMADO'),   ATENDIME.CD_TIP_MAR,
          NVL(TIP_MAR.DS_TIP_MAR, 'NAO INFORMADO'),   ATENDIME.CD_CONVENIO,  CONVENIO.NM_CONVENIO
 ORDER BY 6 ASC, 7 ASC, 1 ASC, 2 ASC