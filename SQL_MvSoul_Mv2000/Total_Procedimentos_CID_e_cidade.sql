SELECT
    c.nm_cidade AS cidade,
    COUNT(*) AS total_de_atendimento
FROM
    atendime a,
    paciente q,
    cidade   c
WHERE
    a.cd_paciente = q.cd_paciente
    AND c.cd_cidade = q.cd_cidade
    AND a.dt_atendimento BETWEEN ( '01/01/2017' ) AND ( '31/12/2022' )
    AND (c.nm_cidade = 'CAJAZEIRAS'
    OR c.nm_cidade = 'SOUSA')
    AND a.CD_CID = 'C61'
GROUP BY
    c.nm_cidade
ORDER BY
    COUNT(*);
