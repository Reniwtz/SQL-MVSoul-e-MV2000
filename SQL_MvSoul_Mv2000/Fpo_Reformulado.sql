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
    atendime.cd_procedimento                  AS procedimento,
    procedimento_sus.ds_procedimento          AS descricao,
    teto_orcamentario_proced_sus.qt_fisico    AS acordado,
    COUNT(atendime.cd_procedimento)           AS quantidade_feita,
    teto_orcamentario_proced_sus.vl_orcamento AS valor_orçado,
    CASE
        WHEN ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) ) < 0 THEN
            0
        ELSE ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) )
    END                                       AS resta,
    CONCAT(ROUND(((COUNT(atendime.cd_procedimento)) / teto_orcamentario_proced_sus.qt_fisico) * 100, 2), '%') AS porcentagem,
    ((teto_orcamentario_proced_sus.vl_orcamento/teto_orcamentario_proced_sus.qt_fisico)* COUNT(atendime.cd_procedimento)) AS total_lançado
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

-----------------------------------------------------------------------

SELECT
    eve_siasus.cd_procedimento        cod_procedimento,
    COUNT(eve_siasus.cd_procedimento) qt_lancada
FROM
    eve_siasus eve_siasus,
    fat_sia    fat_sia
WHERE
        eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '01/2023'
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento;

----------------------------------------------------------------------

SELECT
    eve_siasus.cd_procedimento AS cod_procedimento,
    SUM(1)                     AS qt_lancada
FROM
    eve_siasus eve_siasus,
    fat_sia    fat_sia
WHERE
        eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '01/2023'
    AND tipo_fatura like 'BPA'
    --AND tipo_fatura like 'SISM'
    --AND tipo_fatura like 'APAC'
    AND (eve_siasus.cd_procedimento <> '204030030' OR eve_siasus.cd_procedimento <> '204030188')
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento; 
