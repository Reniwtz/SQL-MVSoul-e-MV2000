SELECT
    same.nr_matricula_same,
    same.cd_paciente,
    paciente.nm_paciente,
    same.dt_cadastro dt_same
FROM
         same same
    INNER JOIN paciente ON paciente.cd_paciente = same.cd_paciente
    INNER JOIN it_same ON same.nr_matricula_same = it_same.nr_matricula_same
    INNER JOIN atendime ON it_same.cd_atendimento = atendime.cd_atendimento
WHERE
        same.nr_matricula_same >= 107001
    AND same.dt_cadastro BETWEEN TO_DATE('29/01/2025', 'DD/MM/YYYY') AND TO_DATE('29/01/2025', 'DD/MM/YYYY')
    --AND trunc(months_between(sysdate, paciente.dt_nascimento) / 12) >= 18 
GROUP BY
    same.nr_matricula_same,
    same.cd_paciente,
    paciente.nm_paciente,
    same.dt_cadastro
order by
    paciente.nm_paciente;
