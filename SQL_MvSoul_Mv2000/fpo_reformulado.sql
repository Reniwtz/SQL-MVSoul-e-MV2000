SELECT
    teto_orcamentario_proced_sus.cd_procedimento AS codigo_do_procedimento,
    procedimento_sus.ds_procedimento  AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    teto_orcamentario_proced_sus.vl_orcamento AS valor
FROM
    teto_orcamentario_proced_sus teto_orcamentario_proced_sus
    INNER JOIN fat_sia ON teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia
    INNER JOIN procedimento_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '03/2023'
ORDER BY
    teto_orcamentario_proced_sus.cd_procedimento;

--------------------------------------------------------------------------------

SELECT
    cd_procedimento        cod_procedimento,
    COUNT(cd_procedimento) qt_lancada
FROM
    eve_siasus eve_siasus
    INNER JOIN fat_sia ON eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
WHERE
        to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '03/2023' 
    AND to_char(eve_siasus.dt_eve_siasus, 'mm/yyyy') = '03/2023'
    AND eve_siasus.qt_lancada <> 0
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento;
  
--------------------------------------------------------------------------------    
    
SELECT
    teto_orcamentario_proced_sus.cd_procedimento AS codigo_do_procedimento,
    procedimento_sus.ds_procedimento  AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    teto_orcamentario_proced_sus.vl_orcamento AS valor,
    COUNT(eve_siasus.cd_procedimento) qt_lancada
FROM
    teto_orcamentario_proced_sus teto_orcamentario_proced_sus
    INNER JOIN fat_sia on teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia
    INNER JOIN procedimento_sus on teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento,
    eve_siasus eve_siasus
WHERE
        to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '03/2023'
    AND to_char(eve_siasus.dt_eve_siasus, 'mm/yyyy') = '03/2023'
    AND eve_siasus.qt_lancada <> 0
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    teto_orcamentario_proced_sus.cd_procedimento,
    eve_siasus.cd_procedimento;
  
  
-------------------------------------------------------------------------

SELECT
    atendime.cd_procedimento AS Procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    count(atendime.cd_procedimento) AS Quantidade_Feita,
    teto_orcamentario_proced_sus.vl_orcamento AS valor
FROM
    atendime atendime
    INNER JOIN teto_orcamentario_proced_sus ON atendime.cd_procedimento = teto_orcamentario_proced_sus.cd_procedimento
    INNER JOIN procedimento_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia
WHERE
        atendime.dt_atendimento BETWEEN ( '01/04/2023' ) AND ( '30/04/2023' )
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '04/2023'
    AND atendime.sn_atendimento_apac LIKE 'S'
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico, 
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;
    
