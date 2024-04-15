SELECT
    atendime.cd_paciente,
    paciente.nm_paciente,
    paciente.dt_nascimento
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN procedimento_sus ON procedimento_sus.cd_procedimento = atendime.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/22', 'DD/MM/YY') AND TO_DATE('31/12/22', 'DD/MM/YY')
    AND atendime.cd_procedimento LIKE '0304010413'
    AND EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM dt_nascimento) >= 80
GROUP BY
    atendime.cd_paciente,
    paciente.nm_paciente,
    paciente.dt_nascimento;
