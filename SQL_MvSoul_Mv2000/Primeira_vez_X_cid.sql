SELECT
    *  
FROM
    atendime atendime
    INNER JOIN paciente on paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN same on same.cd_paciente = paciente.cd_paciente
WHERE
        atendime.dt_atendimento BETWEEN TO_DATE('01/01/2021', 'DD/MM/YYYY') AND TO_DATE('31/12/2021', 'DD/MM/YYYY')
    AND atendime.cd_cid like '%C50%'
    AND same.dt_cadastro BETWEEN TO_DATE('01/01/2021', 'DD/MM/YYYY') AND TO_DATE('31/12/2021', 'DD/MM/YYYY')
