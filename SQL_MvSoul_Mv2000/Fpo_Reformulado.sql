--BPA
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    COUNT(atendime.cd_procedimento)  AS lancado,
    CASE
        WHEN ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) ) < 0 THEN
            0
        ELSE ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) )
    END                                       AS resta,
    teto_orcamentario_proced_sus.vl_orcamento AS valor_orçado,
    (teto_orcamentario_proced_sus.vl_orcamento/teto_orcamentario_proced_sus.qt_fisico)* COUNT(atendime.cd_procedimento) AS total_lancado
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia 
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND ( tp_atendimento LIKE 'A'
          OR tp_atendimento LIKE 'E' )
    AND atendime.sn_atendimento_apac LIKE 'N'
    AND sn_retorno LIKE 'N'
    AND (atendime.cd_procedimento <> '204030030' 
        OR atendime.cd_procedimento <> '204030188')
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;

--------------------------------------------------------------------------------
--PROCEDIMENTOS CIRÚRGICOS
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    COUNT(atendime.cd_procedimento)  AS lancado,
    CASE
        WHEN ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) ) < 0 THEN
            0
        ELSE ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) )
    END                                       AS resta,
    teto_orcamentario_proced_sus.vl_orcamento AS valor_orçado,
    (teto_orcamentario_proced_sus.vl_orcamento/teto_orcamentario_proced_sus.qt_fisico)* COUNT(atendime.cd_procedimento) AS total_lancado
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia 
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND ( atendime.cd_procedimento LIKE '0401010015'
        OR atendime.cd_procedimento LIKE '0404010121'
        OR atendime.cd_procedimento LIKE '0407040196'
        OR atendime.cd_procedimento LIKE '0417010060' )
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento 
ORDER BY
    atendime.cd_procedimento;

--------------------------------------------------------------------------------
--APAC
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    COUNT(atendime.cd_procedimento)  AS quant_apac_lancado,
    CASE
        WHEN ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) ) < 0 THEN
            0
        ELSE ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) )
    END                                       AS resta,
    teto_orcamentario_proced_sus.vl_orcamento AS valor_orçado,
    (teto_orcamentario_proced_sus.vl_orcamento/teto_orcamentario_proced_sus.qt_fisico)* COUNT(atendime.cd_procedimento) AS total_lancado
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia 
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND atendime.sn_atendimento_apac LIKE 'S'
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;



