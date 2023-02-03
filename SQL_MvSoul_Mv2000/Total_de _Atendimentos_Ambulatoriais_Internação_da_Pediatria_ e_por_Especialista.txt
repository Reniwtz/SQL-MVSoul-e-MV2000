-- Total de Atendimento no Ambulatório
SELECT
    --p.nm_paciente,
    --a.cd_paciente,
    --a.cd_atendimento,
    --a.dt_atendimento
    COUNT(*) AS total_de_atendimento
FROM
    atendime a
    --paciente p
WHERE
        --a.cd_paciente = p.cd_paciente
    a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND cd_loc_proced LIKE '3'
    AND tp_atendimento LIKE 'A'
    AND ( cd_ori_ate LIKE '12'
          OR cd_ori_ate LIKE '30' )
ORDER BY
    COUNT(*);




-- Total de Procedimentos na Pediatria
SELECT
    COUNT(*) AS total_de_atendimento
FROM
    atendime a
    --paciente p
WHERE
    a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND  cd_ori_ate LIKE '30'
    AND tp_atendimento like 'I'
ORDER BY
    COUNT(*);




-- Total de Atendimento no Ambulatório por Especialista 
SELECT
    --p.nm_paciente,
    --a.cd_paciente,
    --a.cd_atendimento,
    --a.dt_atendimento
    pr.nm_prestador,
    COUNT(*) AS total_de_atendimento
FROM
    atendime  a,
    prestador pr
    --paciente p
WHERE
        --a.cd_paciente = p.cd_paciente
        a.cd_prestador = pr.cd_prestador
    AND a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND cd_loc_proced LIKE '3'
    AND tp_atendimento LIKE 'A'
    AND ( cd_ori_ate LIKE '12'
          OR cd_ori_ate LIKE '30' )
GROUP BY
    nm_prestador
ORDER BY
    COUNT(*);




-- Total de Procedimentos na Pediatria por Especialista 
SELECT
    --p.nm_paciente,
    --a.cd_paciente,
    --a.cd_atendimento,
    --a.dt_atendimento
    pr.nm_prestador,
    COUNT(*) AS total_de_atendimento
FROM
    atendime  a,
    prestador pr
    --paciente p
WHERE
        --a.cd_paciente = p.cd_paciente
        a.cd_prestador = pr.cd_prestador
    AND a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND  cd_ori_ate LIKE '30'
    AND tp_atendimento like 'I'
GROUP BY
    nm_prestador
ORDER BY
    COUNT(*);


