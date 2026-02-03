-- Atendimento de primeira vez por Municipio especifico
SELECT
    c.nm_cidade AS Cidade,
    c.cd_uf AS Estado,
    COUNT(*) AS Total_de_Atendimento
FROM
    paciente p,
    cidade   c
WHERE
    p.dt_cadastro BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
    AND c.cd_cidade = p.cd_cidade
    AND c.cd_uf = 'PB'
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
GROUP BY
    c.nm_cidade,
    c.cd_uf
ORDER BY
    COUNT(*) desc;
    
    
-- Total de atendimento de primeira vez
SELECT COUNT(p.cd_paciente)
  FROM paciente p
 WHERE p.dt_cadastro BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY');


-- Total de atendimento de primeira vez por Municipio especifico
SELECT
    COUNT(p.cd_paciente)
FROM
    paciente p,
    cidade   c
WHERE
    p.dt_cadastro BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
    AND c.cd_cidade = p.cd_cidade
    AND c.cd_uf = 'PB'
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


--------------------------------------------------------------------------
-- Atual sql usado por mim
    WITH base AS (
    SELECT
        CIDADE.CD_CIDADE,
        CIDADE.NM_CIDADE,
        EXTRACT(YEAR FROM PACIENTE.DT_CADASTRO) AS ANO,
        COUNT(*) AS QT_PACIENTES
    FROM PACIENTE
    INNER JOIN CIDADE
        ON CIDADE.CD_CIDADE = PACIENTE.CD_CIDADE
    WHERE
            PACIENTE.DT_CADASTRO >= DATE '2022-01-01'
        AND PACIENTE.DT_CADASTRO <  DATE '2026-01-01'
        AND CIDADE.CD_UF = 'PB'
    GROUP BY
        CIDADE.CD_CIDADE,
        CIDADE.NM_CIDADE,
        EXTRACT(YEAR FROM PACIENTE.DT_CADASTRO)
),

top20 AS (
    SELECT
        BASE.CD_CIDADE
    FROM BASE
    WHERE BASE.ANO = 2025
    GROUP BY BASE.CD_CIDADE
    ORDER BY SUM(BASE.QT_PACIENTES) DESC
    FETCH FIRST 20 ROWS ONLY
),

resultado AS (
    -- =========================
    -- TOP 20 CIDADES (ANO BASE: 2025)
    -- =========================
    SELECT
        1 AS ORDEM,
        BASE.CD_CIDADE,
        BASE.NM_CIDADE,
        NVL(SUM(CASE WHEN BASE.ANO = 2022 THEN BASE.QT_PACIENTES END), 0) AS Y2022,
        NVL(SUM(CASE WHEN BASE.ANO = 2023 THEN BASE.QT_PACIENTES END), 0) AS Y2023,
        NVL(SUM(CASE WHEN BASE.ANO = 2024 THEN BASE.QT_PACIENTES END), 0) AS Y2024,
        NVL(SUM(CASE WHEN BASE.ANO = 2025 THEN BASE.QT_PACIENTES END), 0) AS Y2025
    FROM BASE
    INNER JOIN TOP20
        ON TOP20.CD_CIDADE = BASE.CD_CIDADE
    GROUP BY
        BASE.CD_CIDADE,
        BASE.NM_CIDADE

    UNION ALL

    -- =========================
    -- DEMAIS CIDADES (FORA DO TOP 20)
    -- =========================
    SELECT
        2 AS ORDEM,
        NULL AS CD_CIDADE,
        'OUTRAS CIDADES' AS NM_CIDADE,
        NVL(SUM(CASE WHEN BASE.ANO = 2022 THEN BASE.QT_PACIENTES END), 0) AS Y2022,
        NVL(SUM(CASE WHEN BASE.ANO = 2023 THEN BASE.QT_PACIENTES END), 0) AS Y2023,
        NVL(SUM(CASE WHEN BASE.ANO = 2024 THEN BASE.QT_PACIENTES END), 0) AS Y2024,
        NVL(SUM(CASE WHEN BASE.ANO = 2025 THEN BASE.QT_PACIENTES END), 0) AS Y2025
    FROM BASE
    WHERE NOT EXISTS (
        SELECT 1
        FROM TOP20
        WHERE TOP20.CD_CIDADE = BASE.CD_CIDADE
    )
)

SELECT
    RESULTADO.CD_CIDADE,
    RESULTADO.NM_CIDADE,
    RESULTADO.Y2022 AS "2022",
    RESULTADO.Y2023 AS "2023",
    RESULTADO.Y2024 AS "2024",
    RESULTADO.Y2025 AS "2025"
FROM RESULTADO
ORDER BY
    RESULTADO.ORDEM,
    RESULTADO.Y2025 DESC;

