SELECT decode(ATENDIME . CD_CONVENIO , '1', 'SUS - INT', '2', 'SUS - AMB', '16', 'Particular', 'P.Saude') Convenio, substr(to_CHAR(atendime.dt_Atendimento, 'MONTH'),0,3) Mes_Atend, COUNT ( ATENDIME . CD_CONVENIO ) CONT_CONV
  FROM Dbamv . ATENDIME, Dbamv . CONVENIO
 WHERE CONVENIO . CD_CONVENIO(+) = ATENDIME . CD_CONVENIO
   AND TRUNC(ATENDIME . DT_ATENDIMENTO) BETWEEN '01/08/2022' AND '31/08/2022'
   and DBAMV . FNC_MV_USUARIO_UNIDADE_SETOR(null,
                                    null,
                                    ATENDIME . cd_ori_ate,
                                    ATENDIME . cd_leito) = 'S'
   AND ATENDIME.TP_ATENDIMENTO = 'U'
GROUP BY ATENDIME . CD_CONVENIO , substr(to_CHAR(atendime.dt_Atendimento, 'MONTH'),0,3), CONVENIO . NM_CONVENIO
ORDER BY Convenio, Mes_Atend



--   and atendime.cd_convenio = '2'
select * from atendime where tp_Atendimento = 'U' and dt_Atendimento between '01/08/2022' and '31/08/2022' and cd_convenio not in ('1','2','16')
