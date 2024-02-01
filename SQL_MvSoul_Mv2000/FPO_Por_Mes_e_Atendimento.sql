SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    COUNT(atendime.cd_procedimento)  AS quant_bpa,
    teto_orcamentario_proced_sus.qt_fisico AS acordado
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
    teto_orcamentario_proced_sus.qt_fisico 
ORDER BY
    atendime.cd_procedimento;

--------------------------------------------------------------------------------
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    COUNT(atendime.cd_procedimento)  AS quant_proc_cirurgico,
    teto_orcamentario_proced_sus.qt_fisico AS acordado
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
    teto_orcamentario_proced_sus.qt_fisico 
ORDER BY
    atendime.cd_procedimento;

--------------------------------------------------------------------------------
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    COUNT(atendime.cd_procedimento)  AS quant_apac,
    teto_orcamentario_proced_sus.qt_fisico AS acordado
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
    teto_orcamentario_proced_sus.qt_fisico 
ORDER BY
    atendime.cd_procedimento;




