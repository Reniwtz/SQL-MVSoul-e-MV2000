SELECT
    pre_med.cd_atendimento,
    atendime.cd_paciente,
    paciente.nm_paciente,
    leito.ds_enfermaria,
    tip_presc.ds_tip_presc,
    itpre_med.ds_itpre_med
FROM
         itpre_med itpre_med
    INNER JOIN pre_med ON pre_med.cd_pre_med = itpre_med.cd_pre_med
    INNER JOIN atendime ON atendime.cd_atendimento = pre_med.cd_atendimento
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN tip_presc ON itpre_med.cd_tip_presc = tip_presc.cd_tip_presc
    INNER JOIN leito ON  atendime.cd_leito = leito.cd_leito
WHERE
        itpre_med.cd_tip_esq = 'DIE'
    AND dt_pre_med BETWEEN TO_DATE('30/08/2023', 'DD/MM/YYYY') AND TO_DATE('30/08/2023', 'DD/MM/YYYY')
    AND leito.cd_unid_int in 1
    --AND dt_pre_med > (sysdate-1)
group by
        pre_med.cd_atendimento,
    atendime.cd_paciente,
    paciente.nm_paciente,
    leito.ds_enfermaria,
    tip_presc.ds_tip_presc,
    itpre_med.ds_itpre_med
