select count(a.cd_ped_rx)Tot,DBAMV.SET_EXA.NM_SET_EXA
  from DBAMV.PED_Rx a
  inner join atendime on atendime.cd_atendimento = a.cd_atendimento
  inner join DBAMV.SET_EXA on DBAMV.SET_EXA.CD_SET_EXA  =  a.cd_set_exa
  
 where a.cd_ped_rx in
 
                    (select b.cd_ped_rx
                                 from DBAMV.itped_rx b
                                  where b.cd_laudo is null
                                   and b.sn_realizado is null
                                     and b.dt_realizado is null
                              )
                              
                              group by DBAMV.SET_EXA.NM_SET_EXA
