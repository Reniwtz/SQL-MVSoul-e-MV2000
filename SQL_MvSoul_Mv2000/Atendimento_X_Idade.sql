SELECT
    atendime.cd_paciente
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/12/24', 'DD/MM/YY')
    AND months_between(sysdate, dt_nascimento) / 12 < 15
GROUP BY
    atendime.cd_paciente
