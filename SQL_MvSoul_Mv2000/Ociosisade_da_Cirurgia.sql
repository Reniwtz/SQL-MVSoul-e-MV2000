 
 select atendime.cd_atendimento as atendimento,
        paciente.nm_paciente as spaciente,
        aviso_cirurgia.dt_realizacao,                     
        aviso_cirurgia.cd_aviso_cirurgia as aviso_cirurgia,
        cirurgia.ds_cirurgia as scirurgia,
        aviso_cirurgia.dt_inicio_cirurgia ,
        aviso_cirurgia.dt_fim_cirurgia,
        aviso_cirurgia.dt_inicio_anestesia,
        aviso_cirurgia.dt_fim_anestesia,
        aviso_cirurgia.dt_inicio_limpeza,
        aviso_cirurgia.dt_fim_limpeza,
trunc(( (aviso_cirurgia.dt_inicio_limpeza -  aviso_cirurgia.dt_fim_limpeza) * 86400 / 3600)) ||':' || 
trunc(mod( (aviso_cirurgia.dt_inicio_limpeza -  aviso_cirurgia.dt_fim_limpeza) * 86400 , 3600 ) / 60 ) || ':'|| 
trunc(mod ( mod ( (aviso_cirurgia.dt_inicio_limpeza -  aviso_cirurgia.dt_fim_limpeza) * 86400, 3600 ), 60 )) Tp_limpeza ,
--------------------------------------------------------------------------------------------------------------------------
trunc(( (aviso_cirurgia.dt_inicio_cirurgia -  aviso_cirurgia.dt_fim_cirurgia) * 86400 / 3600)) ||':' || 
trunc(mod( (aviso_cirurgia.dt_inicio_cirurgia -  aviso_cirurgia.dt_fim_cirurgia) * 86400 , 3600 ) / 60 ) || ':'|| 
trunc(mod ( mod ( (aviso_cirurgia.dt_inicio_cirurgia  - aviso_cirurgia.dt_fim_cirurgia) * 86400, 3600 ), 60 )) Tp_cirurgia ,                                         
----------------------------------------------------------------------------------------------------------------------------
trunc(( (aviso_cirurgia.dt_inicio_cirurgia -  aviso_cirurgia.dt_fim_cirurgia) * 86400 / 3600))+  
trunc(( (aviso_cirurgia.dt_inicio_cirurgia -  aviso_cirurgia.dt_fim_cirurgia) * 86400 / 3600))"Tot_Hora",
trunc(mod( (aviso_cirurgia.dt_inicio_limpeza -  aviso_cirurgia.dt_fim_limpeza) * 86400 , 3600 ) / 60 )+
trunc(mod( (aviso_cirurgia.dt_inicio_cirurgia -  aviso_cirurgia.dt_fim_cirurgia) * 86400 , 3600 ) / 60 )"Tot_Minuto",
trunc(mod ( mod ( (aviso_cirurgia.dt_inicio_limpeza -  aviso_cirurgia.dt_fim_limpeza) * 86400, 3600 ), 60 ))+
trunc(mod ( mod ( (aviso_cirurgia.dt_inicio_cirurgia  - aviso_cirurgia.dt_fim_cirurgia) * 86400, 3600 ), 60 ))"Tot_Segundo"
   from cirurgia, aviso_cirurgia, cirurgia_aviso, atendime, paciente
  where cirurgia.cd_cirurgia = cirurgia_aviso.cd_cirurgia
    and aviso_cirurgia.cd_aviso_cirurgia = cirurgia_aviso.cd_aviso_cirurgia
    and atendime.cd_atendimento = aviso_cirurgia.cd_atendimento
    and trunc(aviso_cirurgia.dt_aviso_cirurgia)>=  '01/01/2016'
    and paciente.cd_paciente = atendime.cd_paciente
    and aviso_cirurgia.tp_situacao = 'R'
    and trunc(aviso_cirurgia.dt_aviso_cirurgia) between nvl(#datainicial#,trunc(sysdate-1)) and nvl(#datafinal# , trunc (sysdate)) 
    order by aviso_cirurgia.dt_aviso_cirurgia desc
    
