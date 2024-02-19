--APAC
SELECT
    atendime.cd_procedimento         AS procedimento,
    COUNT(atendime.cd_procedimento)  AS quant_apac_lancado
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

--------------------------------------------------------------------------------
--BPA ATENDIMENTO
SELECT
    atendime.cd_procedimento         AS procedimento,
    COUNT(atendime.cd_procedimento)  AS lancado
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia 
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/01/2023', 'DD/MM/YYYY')
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/01/2023', 'DD/MM/YYYY')
    AND tp_atendimento <> 'I'
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
    
        
--BPA FATURA
SELECT
    eve_siasus.cd_procedimento AS cod_procedimento,
    COUNT(*)                   AS lancada
FROM
         eve_siasus eve_siasus
    INNER JOIN fat_sia ON eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    INNER JOIN atendime ON atendime.cd_atendimento = eve_siasus.cd_atendimento
WHERE
        eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/01/2024', 'DD/MM/YYYY')
    AND atendime.dt_atendimento < TO_DATE('2024-01-01', 'YYYY-MM-DD')
    AND tipo_fatura LIKE 'BPA'
    AND ( eve_siasus.cd_procedimento <> '204030030'
          OR eve_siasus.cd_procedimento <> '204030188' )
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento;
    

--BPA PEDIDO 


--------------------------------------------------------------------------------    
--TETO FPO
SELECT
    teto_orcamentario_proced_sus.cd_procedimento cod_procedimento,
    procedimento_sus.ds_procedimento             descricao,
    teto_orcamentario_proced_sus.qt_fisico       acordado
FROM
         teto_orcamentario_proced_sus teto_orcamentario_proced_sus
    INNER JOIN procedimento_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia
WHERE
    dt_periodo_inicial BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/01/24', 'DD/MM/YY');

    
--------------------------------------------------------------------------------
--PROCEDIMENTOS CIRÚRGICOS
SELECT
    atendime.cd_procedimento         AS procedimento,
    COUNT(atendime.cd_procedimento)  AS lancado
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
    
