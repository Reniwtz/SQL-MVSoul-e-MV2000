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




-- Atendimento por CIDxAtendimentoXIdade
SELECT
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid,
    same.nr_matricula_same,
    TRUNC(MONTHS_BETWEEN(atendime.dt_atendimento, paciente.dt_nascimento) / 12) AS idade_na_data_atendimento 
FROM
         atendime atendime
    INNER JOIN cid ON cid.cd_cid = atendime.cd_cid
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    LEFT JOIN same ON same.cd_paciente = paciente.cd_paciente
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/12/24', 'DD/MM/YY')
    AND atendime.cd_cid LIKE 'C50%'
    AND TRUNC(MONTHS_BETWEEN(atendime.dt_atendimento, paciente.dt_nascimento) / 12) BETWEEN 35 AND 49
GROUP BY
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid,
    same.nr_matricula_same,
    TRUNC(MONTHS_BETWEEN(atendime.dt_atendimento, paciente.dt_nascimento) / 12)
ORDER BY
    atendime.cd_cid
