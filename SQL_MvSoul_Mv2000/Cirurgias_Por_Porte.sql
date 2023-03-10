-- Puxando todos os procedimentos com os codigos 040401012 & 0401010074
-- SUS - Pequenas Cirurgias
SELECT
    DISTINCT(cd_atendimento),
    cd_procedimento,
    dt_atendimento,
    cd_convenio
FROM
    atendime
WHERE
    cd_convenio IN (1,2)
    AND ( dt_atendimento BETWEEN ( '01/02/2022' ) AND ( '28/02/2022' ) )
    AND (cd_procedimento LIKE '0404010121%'
    OR cd_procedimento LIKE '0401010074%');




-- Particular - pequenas cirurgias
SELECT
    *
FROM
    atendime
WHERE
    cd_ori_ate = 31
    AND ( dt_atendimento BETWEEN ( '01/02/2022' ) AND ( '28/02/2022' ) )
    AND cd_convenio = 16
    AND cd_ser_dis = 31
    AND cd_loc_proced = 3



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
