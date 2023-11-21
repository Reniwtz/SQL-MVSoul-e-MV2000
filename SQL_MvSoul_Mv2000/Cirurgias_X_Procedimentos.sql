SELECT
    count(cd_aviso_cirurgia)
FROM
    aviso_cirurgia aviso_cirurgia,
    atendime  atendime
WHERE
        aviso_cirurgia.tp_situacao = 'R'
    AND aviso_cirurgia.cd_cen_cir = '1'
    AND aviso_cirurgia.dt_realizacao BETWEEN TO_DATE('01/01/2022', 'DD/MM/YYYY') AND TO_DATE('31/12/2022', 'DD/MM/YYYY')
    AND aviso_cirurgia.cd_atendimento = atendime.cd_atendimento
    AND atendime.cd_procedimento like '0409040169'  
    
    
select * from procedimento_sus where cd_procedimento like '0409030040'  
select * from procedimento_sus where cd_procedimento like '0416010121'
select * from procedimento_sus where cd_procedimento like '0416010105'
select * from procedimento_sus where cd_procedimento like '0416010113'
select * from procedimento_sus where cd_procedimento like '0416010113'

select * from procedimento_sus where ds_procedimento like '%ORQUI%'
