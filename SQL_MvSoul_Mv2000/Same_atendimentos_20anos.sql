WITH ultimo_atendimento AS (
    SELECT
        atendime.cd_paciente        AS cad,
        paciente.nm_paciente        AS nome_do_paciente,
        atendime.dt_atendimento     AS data_do_atendimento,
        ROW_NUMBER() OVER (
            PARTITION BY atendime.cd_paciente
            ORDER BY atendime.dt_atendimento DESC
        ) AS rn
    FROM
        atendime atendime
        INNER JOIN paciente 
            ON paciente.cd_paciente = atendime.cd_paciente
)
SELECT
    ua.cad,
    ua.nome_do_paciente,
    ua.data_do_atendimento,
    same.nr_matricula_same AS nr_same
FROM
    ultimo_atendimento ua
    LEFT JOIN same 
        ON same.cd_paciente = ua.cad
WHERE
    ua.rn = 1
    AND ua.data_do_atendimento <= ADD_MONTHS(TRUNC(SYSDATE), -240)
ORDER BY
    ua.data_do_atendimento DESC;
