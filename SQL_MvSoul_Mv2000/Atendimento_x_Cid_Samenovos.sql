SELECT
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid,
    same.nr_matricula_same
FROM
         atendime atendime
    INNER JOIN cid ON cid.cd_cid = atendime.cd_cid
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    LEFT JOIN same ON same.cd_paciente = paciente.cd_paciente
WHERE
        atendime.dt_atendimento >= TO_DATE('01/01/2026', 'DD/MM/YYYY')
    AND atendime.dt_atendimento < TO_DATE('30/04/2026', 'DD/MM/YYYY') + 1 
    AND atendime.cd_cid LIKE 'C51%'
GROUP BY
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid,
    same.nr_matricula_same
ORDER BY
    atendime.cd_cid

----------------------------------------------------------------------------------------------------------------
    
SELECT
    atendime.cd_paciente                                                        AS cad,
    same.nr_matricula_same                                                      AS same,
    paciente.nm_paciente                                                        AS nome,
    atendime.cd_cid                                                             AS cid,
    cid.ds_cid                                                                  AS descrição,
    paciente.nm_bairro                                                          AS bairro,
    cidade.nm_cidade                                                            AS cidade,
    trunc(months_between(atendime.dt_atendimento, paciente.dt_nascimento) / 12) AS idade_na_data_atendimento,
    tipo_sexo.nm_sexo                                                           AS sexo
FROM
         atendime atendime
    INNER JOIN cid ON cid.cd_cid = atendime.cd_cid
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    LEFT JOIN same ON same.cd_paciente = paciente.cd_paciente
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
    INNER JOIN tipo_sexo ON tipo_sexo.tp_sexo = paciente.tp_sexo
WHERE
        atendime.dt_atendimento >= TO_DATE('01/01/2026', 'DD/MM/YYYY')
    AND atendime.dt_atendimento < TO_DATE('30/04/2026', 'DD/MM/YYYY') + 1 
    AND atendime.cd_cid LIKE 'C51%'
    AND same.dt_cadastro >= TO_DATE('01/01/2026', 'DD/MM/YYYY')
    AND same.dt_cadastro < TO_DATE('30/04/2026', 'DD/MM/YYYY') + 1 
    AND nr_volume LIKE '1'
GROUP BY
    atendime.cd_paciente,
    same.nr_matricula_same,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid,
    paciente.nm_bairro,
    cidade.nm_cidade,
    trunc(months_between(atendime.dt_atendimento, paciente.dt_nascimento) / 12),
    tipo_sexo.nm_sexo
ORDER BY
    atendime.cd_paciente,
    atendime.cd_cid
    
----------------------------------------------------------------------------------------
-- Avaliar a fpo pela ordem de uma planilha em determinado periodo
WITH lista AS (
    SELECT
        LEVEL AS ordem,
        REGEXP_SUBSTR(codigos, '[^[:space:]]+', 1, LEVEL) AS cd_procedimento
    FROM (
        SELECT q'[
0201010410
0201010470
0201010542
.....
]' AS codigos
        FROM dual
    )
    CONNECT BY REGEXP_SUBSTR(codigos, '[^[:space:]]+', 1, LEVEL) IS NOT NULL
),
contagem AS (
    SELECT
        a.cd_procedimento,
        COUNT(*) AS qtd
    FROM atendime a
    WHERE a.cd_procedimento IN (
        SELECT cd_procedimento
        FROM lista
    )
    AND a.dt_atendimento >= TO_DATE('01/01/2025', 'DD/MM/YYYY')
    AND a.dt_atendimento <  TO_DATE('31/01/2025', 'DD/MM/YYYY') + 1
    AND a.cd_convenio in ('1', '2')
    GROUP BY a.cd_procedimento
)
SELECT
    l.cd_procedimento,
    NVL(c.qtd, 0) AS qtd
FROM lista l
LEFT JOIN contagem c
    ON c.cd_procedimento = l.cd_procedimento
ORDER BY
    l.ordem;


-- Pedidos de imagem e anatomopatologico
WITH lista AS (
    SELECT
        LEVEL AS ordem,
        REGEXP_SUBSTR(codigos, '[^[:space:]]+', 1, LEVEL) AS cd_procedimento
    FROM (
        SELECT q'[
0201010410
0201010470
0201010542
....
]' AS codigos
        FROM dual
    )
    CONNECT BY REGEXP_SUBSTR(codigos, '[^[:space:]]+', 1, LEVEL) IS NOT NULL
),
contagem AS (
    SELECT
        e.cd_procedimento_sia AS cd_procedimento,
        COUNT(*) AS qtd
    FROM ped_rx p
    INNER JOIN exa_rx e
        ON e.cd_exa_rx = p.cd_exa_rx
    WHERE p.dt_pedido >= TO_DATE('01/01/2025', 'DD/MM/YYYY')
      AND p.dt_pedido <  TO_DATE('31/01/2025', 'DD/MM/YYYY') + 1
      AND p.cd_convenio in ('1', '2')
      AND e.cd_procedimento_sia IN (
            SELECT cd_procedimento
            FROM lista
      )
    GROUP BY
        e.cd_procedimento_sia
)
SELECT
    l.cd_procedimento,
    NVL(c.qtd, 0) AS qtd
FROM lista l
LEFT JOIN contagem c
    ON c.cd_procedimento = l.cd_procedimento
ORDER BY
    l.ordem;
