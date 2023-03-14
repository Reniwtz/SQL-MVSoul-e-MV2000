-- TOTAL DE ATENDIMENTOS
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
    AND a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND ( nm_cidade = 'CAJAZEIRAS'
          OR c.nm_cidade = 'CACHOEIRA DOS INDIOS'
          OR c.nm_cidade = 'BOM JESUS'
          OR c.nm_cidade = 'SAO JOSE DE PIRANHAS'
          OR c.nm_cidade = 'MONTE HOREBE'
          OR c.nm_cidade = 'CARRAPATEIRA'
          OR c.nm_cidade = 'BONITO DE SANTA FE'
          OR c.nm_cidade = 'SAO JOAO DO RIO DO PEIXE'
          OR c.nm_cidade = 'UIRAUNA'
          OR c.nm_cidade = 'SANTA HELENA'
          OR c.nm_cidade = 'TRIUNFO'
          OR c.nm_cidade = 'BERNARDINO BATISTA'
          OR c.nm_cidade = 'JOCA CLAUDINO'
          OR c.nm_cidade = 'POCO DE JOSE DE MOURA'
          OR c.nm_cidade = 'POCO DANTAS'
          )
GROUP BY
    c.nm_cidade
ORDER BY
    COUNT(*);

    
-- TOTAL DE ATENDIMENTOS SOMADOS
SELECT
    count(q.cd_paciente)
FROM
    atendime a,
    paciente q,
    cidade   c
WHERE
        a.cd_paciente = q.cd_paciente
    AND c.cd_cidade = q.cd_cidade
    AND a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND ( nm_cidade = 'CAJAZEIRAS'
          OR c.nm_cidade = 'CACHOEIRA DOS INDIOS'
          OR c.nm_cidade = 'BOM JESUS'
          OR c.nm_cidade = 'SAO JOSE DE PIRANHAS'
          OR c.nm_cidade = 'MONTE HOREBE'
          OR c.nm_cidade = 'CARRAPATEIRA'
          OR c.nm_cidade = 'BONITO DE SANTA FE'
          OR c.nm_cidade = 'SAO JOAO DO RIO DO PEIXE'
          OR c.nm_cidade = 'UIRAUNA'
          OR c.nm_cidade = 'SANTA HELENA'
          OR c.nm_cidade = 'TRIUNFO'
          OR c.nm_cidade = 'BERNARDINO BATISTA'
          OR c.nm_cidade = 'JOCA CLAUDINO'
          OR c.nm_cidade = 'POCO DE JOSE DE MOURA'
          OR c.nm_cidade = 'POCO DANTAS'
);

  
-- TOTAL DE ATENDIMENTO POR INDIVIDUO
SELECT
    DISTINCT a.cd_paciente AS Paciente,
    c.nm_cidade AS cidade
FROM
    atendime a,
    paciente q,
    cidade   c
WHERE
    a.cd_paciente = q.cd_paciente
    AND c.cd_cidade = q.cd_cidade
    AND a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND ( nm_cidade = 'CAJAZEIRAS'
          OR c.nm_cidade = 'CACHOEIRA DOS INDIOS'
          OR c.nm_cidade = 'BOM JESUS'
          OR c.nm_cidade = 'SAO JOSE DE PIRANHAS'
          OR c.nm_cidade = 'MONTE HOREBE'
          OR c.nm_cidade = 'CARRAPATEIRA'
          OR c.nm_cidade = 'BONITO DE SANTA FE'
          OR c.nm_cidade = 'SAO JOAO DO RIO DO PEIXE'
          OR c.nm_cidade = 'UIRAUNA'
          OR c.nm_cidade = 'SANTA HELENA'
          OR c.nm_cidade = 'TRIUNFO'
          OR c.nm_cidade = 'BERNARDINO BATISTA'
          OR c.nm_cidade = 'JOCA CLAUDINO'
          OR c.nm_cidade = 'POCO DE JOSE DE MOURA'
          OR c.nm_cidade = 'POCO DANTAS'
);

-- TOTAL DE ATENDIMENTOS POR INDIVIDUO SOMADO
SELECT
    count(distinct a.cd_paciente)
FROM
    atendime a,
    paciente q,
    cidade   c
WHERE
        a.cd_paciente = q.cd_paciente
    AND c.cd_cidade = q.cd_cidade
    AND a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND ( nm_cidade = 'CAJAZEIRAS'
          OR c.nm_cidade = 'CACHOEIRA DOS INDIOS'
          OR c.nm_cidade = 'BOM JESUS'
          OR c.nm_cidade = 'SAO JOSE DE PIRANHAS'
          OR c.nm_cidade = 'MONTE HOREBE'
          OR c.nm_cidade = 'CARRAPATEIRA'
          OR c.nm_cidade = 'BONITO DE SANTA FE'
          OR c.nm_cidade = 'SAO JOAO DO RIO DO PEIXE'
          OR c.nm_cidade = 'UIRAUNA'
          OR c.nm_cidade = 'SANTA HELENA'
          OR c.nm_cidade = 'TRIUNFO'
          OR c.nm_cidade = 'BERNARDINO BATISTA'
          OR c.nm_cidade = 'JOCA CLAUDINO'
          OR c.nm_cidade = 'POCO DE JOSE DE MOURA'
          OR c.nm_cidade = 'POCO DANTAS'
);
