-- Total geral de outros atendimentos
SELECT
    COUNT(a.cd_atendimento)
FROM
    atendime a
WHERE
    a.dt_atendimento BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY');
    
    
-- Outros atendimentos por Municípios
SELECT
    cidade,
    total_de_atendimento
FROM
    (
        SELECT
            c.nm_cidade AS cidade,
            COUNT(*) AS total_de_atendimento,
            CASE
                WHEN c.nm_cidade = 'JOAO PESSOA' THEN 1
                WHEN c.nm_cidade = 'CABEDELO' THEN 2
                WHEN c.nm_cidade = 'BAYEUX' THEN 3
                WHEN c.nm_cidade = 'SANTA RITA' THEN 4
                WHEN c.nm_cidade = 'GUARABIRA' THEN 5
                WHEN c.nm_cidade = 'CONDE' THEN 6
                WHEN c.nm_cidade = 'MAMANGUAPE' THEN 7
                WHEN c.nm_cidade = 'SAPE' THEN 8
                WHEN c.nm_cidade = 'GUARABIRA' THEN 9
                WHEN c.nm_cidade = 'PEDRAS DE FOGO' THEN 10
                WHEN c.nm_cidade = 'BAIA DA TRAICAO' THEN 11
                WHEN c.nm_cidade = 'PATOS' THEN 12
                WHEN c.nm_cidade = 'ALHANDRA' THEN 13
                WHEN c.nm_cidade = 'CAJAZEIRAS' THEN 14
                WHEN c.nm_cidade = 'CAMPINA GRANDE' THEN 15
                WHEN c.nm_cidade = 'RIO TINTO' THEN 16
                WHEN c.nm_cidade = 'CAAPORA' THEN 17
                WHEN c.nm_cidade = 'LUCENA' THEN 18
                WHEN c.nm_cidade = 'GURINHEM' THEN 19
                WHEN c.nm_cidade = 'ITAPOROROCA' THEN 20
                WHEN c.nm_cidade = 'SOUSA' THEN 21
            END AS ordem
        FROM
            atendime a
            JOIN paciente q ON a.cd_paciente = q.cd_paciente
            JOIN cidade c ON c.cd_cidade = q.cd_cidade
        WHERE
            a.dt_atendimento BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
            AND c.nm_cidade IN ('JOAO PESSOA', 'CABEDELO', 'BAYEUX', 'SANTA RITA', 'GUARABIRA', 'CONDE', 'MAMANGUAPE', 'SAPE', 'GUARABIRA', 'PEDRAS DE FOGO', 'BAIA DA TRAICAO', 'PATOS', 'ALHANDRA', 'CAJAZEIRAS', 'CAMPINA GRANDE', 'RIO TINTO', 'CAAPORA', 'LUCENA', 'GURINHEM', 'ITAPOROROCA', 'SOUSA')
        GROUP BY
            c.nm_cidade
    )
ORDER BY
    ordem;


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
    AND a.dt_atendimento BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
           AND ( nm_cidade = 'JOAO PESSOA'
          OR c.nm_cidade = 'CABEDELO'
          OR c.nm_cidade = 'BAYEUX'
          OR c.nm_cidade = 'SANTA RITA'
          OR c.nm_cidade = 'GUARABIRA'
          OR c.nm_cidade = 'CONDE'
          OR c.nm_cidade = 'MAMANGUAPE'
          OR c.nm_cidade = 'SAPE'
          OR c.nm_cidade = 'GUARABIRA'
          OR c.nm_cidade = 'PEDRAS DE FOGO'
          OR c.nm_cidade = 'BAIA DA TRAICAO'
          OR c.nm_cidade = 'PATOS'
          OR c.nm_cidade = 'ALHANDRA'
          OR c.nm_cidade = 'CAJAZEIRAS'
          OR c.nm_cidade = 'CAMPINA GRANDE'
          OR c.nm_cidade = 'RIO TINTO'
          OR c.nm_cidade = 'CAAPORA'
          OR c.nm_cidade = 'LUCENA'
          OR c.nm_cidade = 'GURINHEM'
          OR c.nm_cidade = 'ITAPOROROCA'
          OR c.nm_cidade = 'SOUSA' )
