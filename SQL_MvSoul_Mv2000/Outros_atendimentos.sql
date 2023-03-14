-- Total geral de outros atendimentos
SELECT
    COUNT(a.cd_atendimento)
FROM
    atendime a
WHERE
    a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/07/2022' );
    
    
-- Outros atendimentos por Municípios
SELECT
    c.nm_cidade AS cidade,
    COUNT(*)    AS total_de_atendimento
FROM
    atendime a,
    paciente q,
    cidade   c
WHERE
        a.cd_paciente = q.cd_paciente
    AND c.cd_cidade = q.cd_cidade
    AND a.dt_atendimento BETWEEN ( '01/01/2019' ) AND ( '31/12/2019' )
    AND ( c.nm_cidade = 'JOAO PESSOA'
          OR c.nm_cidade = 'CABEDELO'
          OR c.nm_cidade = 'SANTA RITA'
          OR c.nm_cidade = 'BAYEUX'
          OR c.nm_cidade = 'GUARABIRA'
          OR c.nm_cidade = 'PATOS'
          OR c.nm_cidade = 'MAMANGUAPE'
          OR c.nm_cidade = 'SAPE'
          OR c.nm_cidade = 'ITABAIANA'
          OR c.nm_cidade = 'JURIPIRANGA'
          OR c.nm_cidade = 'CONDE'
          OR c.nm_cidade = 'CAMPINA GRANDE'
          OR c.nm_cidade = 'RIO TINTO'
          OR c.nm_cidade = 'ALHANDRA'
          OR c.nm_cidade = 'LUCENA'
          OR c.nm_cidade = 'LUCENA'
          OR c.nm_cidade = 'PEDRAS DE FOGO'
          OR c.nm_cidade = 'PILAR'
          OR c.nm_cidade = 'CAAPORA'
          OR c.nm_cidade = 'SOUSA'
          OR c.nm_cidade = 'SALGADO DE SAO FELIX' )
GROUP BY
    c.nm_cidade
ORDER BY
    COUNT(*);


-- Total de outros atendimentos por municipio
SELECT
    count(q.cd_paciente)
FROM
    atendime a,
    paciente q,
    cidade   c
WHERE
        a.cd_paciente = q.cd_paciente
    AND c.cd_cidade = q.cd_cidade
    AND a.dt_atendimento BETWEEN ( '01/01/2019' ) AND ( '31/12/2019' )
    AND ( c.nm_cidade = 'JOAO PESSOA'
          OR c.nm_cidade = 'CABEDELO'
          OR c.nm_cidade = 'SANTA RITA'
          OR c.nm_cidade = 'BAYEUX'
          OR c.nm_cidade = 'GUARABIRA'
          OR c.nm_cidade = 'PATOS'
          OR c.nm_cidade = 'MAMANGUAPE'
          OR c.nm_cidade = 'SAPE'
          OR c.nm_cidade = 'ITABAIANA'
          OR c.nm_cidade = 'JURIPIRANGA'
          OR c.nm_cidade = 'CONDE'
          OR c.nm_cidade = 'CAMPINA GRANDE'
          OR c.nm_cidade = 'RIO TINTO'
          OR c.nm_cidade = 'ALHANDRA'
          OR c.nm_cidade = 'LUCENA'
          OR c.nm_cidade = 'LUCENA'
          OR c.nm_cidade = 'PEDRAS DE FOGO'
          OR c.nm_cidade = 'PILAR'
          OR c.nm_cidade = 'CAAPORA'
          OR c.nm_cidade = 'SOUSA'
          OR c.nm_cidade = 'SALGADO DE SAO FELIX' );
