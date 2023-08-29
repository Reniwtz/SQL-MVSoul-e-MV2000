SELECT
    pre_med.cd_atendimento,
    atendime.cd_paciente,
    itpre_med.cd_tip_esq,
    tip_presc.ds_tip_presc,
    itpre_med.ds_itpre_med
FROM
         itpre_med itpre_med
    INNER JOIN pre_med ON pre_med.cd_pre_med = itpre_med.cd_pre_med
    INNER JOIN atendime ON atendime.cd_atendimento = pre_med.cd_atendimento
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN tip_presc ON itpre_med.cd_tip_presc = tip_presc.cd_tip_presc
WHERE
        itpre_med.cd_tip_esq = 'DIE'
    AND dt_pre_med BETWEEN TO_DATE('29/08/2023', 'DD/MM/YYYY') AND TO_DATE('29/08/2023', 'DD/MM/YYYY')
    
    
 
select * from tip_presc
    
select * from itpre_MED where dt_solsai_pro > '01/01/2023' cd_produto = '8246'
