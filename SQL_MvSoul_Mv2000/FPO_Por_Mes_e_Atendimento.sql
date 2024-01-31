SELECT
    t1.cd_procedimento                                     AS código,
    t3.ds_procedimento                                     AS descrição,
    t2.qt_fisico                                           AS orçado,
    COUNT(t1.cd_procedimento)                              AS lançada,
    case when (t2.qt_fisico - COUNT(t1.cd_procedimento)) < 0 
        then 0
        else ( t2.qt_fisico - COUNT(t1.cd_procedimento) ) end AS resta,
    ROUND( ( COUNT(t1.cd_procedimento) / t2.qt_fisico ) * 100, 2)  AS porcentagem
FROM
    eve_siasus                   t1,
    teto_orcamentario_proced_sus t2,
    procedimento_sus             t3
WHERE
    t1.cd_procedimento IN (
        SELECT
            cd_procedimento
        FROM
            procedimento_sus
    )
    AND t1.cd_fat_sia IN (
        SELECT
            cd_fat_sia
        FROM
            fat_sia
        WHERE
            to_char(dt_periodo_inicial, 'MM/YYYY') = '03/2023'
    )
    AND to_char(t1.dt_eve_siasus, 'mm/yyyy') = '03/2023'
    AND t2.cd_fat_sia IN (
        SELECT
            cd_fat_sia
        FROM
            fat_sia
        WHERE
            to_char(dt_periodo_inicial, 'mm/yyyy') = '03/2023'
    )
    AND t1.cd_procedimento = t2.cd_procedimento
    AND t1.cd_procedimento = t3.cd_procedimento
    AND t1.qt_lancada <> 0
GROUP BY
    t1.cd_procedimento,
    t3.ds_procedimento,
    t2.qt_fisico
ORDER BY
    t1.cd_procedimento   


--------------------------------------------------------------------------

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
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '04/2023'
    AND atendime.sn_atendimento_apac LIKE 'S'
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;
    
--------------------------------------------------------------------------------------------------------------------------    

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
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '04/2023'
    AND (atendime.cd_procedimento LIKE '0401010015'
        OR atendime.cd_procedimento LIKE '0404010121'
        OR atendime.cd_procedimento LIKE '0407040196'
        OR atendime.cd_procedimento LIKE '0417010060')
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;

--------------------------------------------------------------------------------

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
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND tp_atendimento like 'A'
    AND atendime.sn_atendimento_apac LIKE 'N'
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;




