SELECT
    COUNT(paciente.cd_paciente)
FROM
    paciente paciente,
    same same
WHERE
        paciente.dt_cadastro BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('08/09/2023', 'DD/MM/YYYY')
    AND paciente.dt_nascimento BETWEEN TO_DATE('08/09/1973', 'DD/MM/YYYY') AND TO_DATE('08/09/2008', 'DD/MM/YYYY')
    and same.cd_paciente = paciente.cd_paciente
