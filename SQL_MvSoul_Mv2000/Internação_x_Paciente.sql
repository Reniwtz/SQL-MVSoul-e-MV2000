SELECT
   cd_paciente
FROM
    atendime atendime
WHERE 
        atendime.tp_atendimento = 'I'
    AND atendime.dt_atendimento  BETWEEN TO_DATE('01/01/2021', 'DD/MM/YYYY') AND TO_DATE('31/12/2021', 'DD/MM/YYYY')
group by 
    cd_paciente
