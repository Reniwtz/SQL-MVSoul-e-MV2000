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

    
------------------------------------------------------------------------------------------------------------
SELECT
    atendime.cd_paciente,
    atendime.dt_atendimento,
    floor((EXTRACT(YEAR FROM atendime.dt_atendimento) - EXTRACT(YEAR FROM paciente.dt_nascimento)) -
          CASE
              WHEN EXTRACT(MONTH FROM atendime.dt_atendimento) < EXTRACT(MONTH FROM paciente.dt_nascimento)
                   OR(EXTRACT(MONTH FROM atendime.dt_atendimento) = EXTRACT(MONTH FROM paciente.dt_nascimento)
                      AND EXTRACT(DAY FROM atendime.dt_atendimento) < EXTRACT(DAY FROM paciente.dt_nascimento)) THEN
                  1
              ELSE
                  0
          END
    ) AS idade
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/12/24', 'DD/MM/YY')
GROUP BY
    atendime.cd_paciente,
    atendime.dt_atendimento,
    paciente.dt_nascimento
ORDER BY
    idade DESC;
