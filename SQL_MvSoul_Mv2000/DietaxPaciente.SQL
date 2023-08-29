SELECT
    itpre_med.cd_tip_esq, cd_atendimento
FROM
    itpre_med itpre_med
    inner join pre_med on pre_med.cd_pre_med = itpre_med.cd_pre_med
    inner join atendime on atendime.cd_atendimento = pre_med.cd_atendimento
    inner join paciente on atendime.cd_paciente = paciente.cd_paciente
    --tip_presc tip_presc
WHERE
        itpre_med.cd_tip_esq = 'DIE'
    AND dt_pre_med BETWEEN TO_DATE('29/08/2023', 'DD/MM/YYYY') AND TO_DATE('29/08/2023', 'DD/MM/YYYY')
    
    
 
select * from tip_presc
    
select * from itpre_MED where dt_solsai_pro > '01/01/2023' cd_produto = '8246'
