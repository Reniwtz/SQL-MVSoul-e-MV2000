-- Atendimento de primeira vez por Municipio especifico
SELECT
    c.nm_cidade AS Cidade,
    c.cd_uf AS Estado,
    COUNT(*) AS Total_de_Atendimento
FROM
    paciente p,
    cidade   c
WHERE
    p.dt_cadastro BETWEEN ( '01/01/2021' ) AND ( '31/12/2021' )
    AND c.cd_cidade = p.cd_cidade
    AND c.cd_uf = 'PB'
    AND ( nm_cidade = 'JOAO PESSOA'
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
    c.nm_cidade,
    c.cd_uf
ORDER BY
    COUNT(*);
    
    
-- Total de atendimento de primeira vez
SELECT COUNT(p.cd_paciente)
  FROM paciente p
 WHERE p.dt_cadastro BETWEEN ( '01/01/2021' ) AND ( '31/12/2021' );


-- Total de atendimento de primeira vez por Municipio especifico
SELECT
    COUNT(p.cd_paciente)
FROM
    paciente p,
    cidade   c
WHERE
    p.dt_cadastro BETWEEN ( '01/01/2021' ) AND ( '31/12/2021' )
    AND c.cd_cidade = p.cd_cidade
    AND c.cd_uf = 'PB'
    AND ( nm_cidade = 'JOAO PESSOA'
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
