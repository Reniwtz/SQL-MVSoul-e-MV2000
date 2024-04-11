SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    COUNT(*)                         AS quantidade,
    valor                            AS valor_individual,
    ( valor * COUNT(*) )             AS valor_total
FROM
         ped_rx ped_rx
    INNER JOIN atendime ON ped_rx.cd_atendimento = atendime.cd_atendimento
    INNER JOIN procedimento_sus ON procedimento_sus.cd_procedimento = atendime.cd_procedimento
    LEFT JOIN (
        SELECT
            cd_procedimento,
            vl_orcamento / qt_fisico AS valor
        FROM
                 teto_orcamentario_proced_sus
            INNER JOIN fat_sia ON teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia
        WHERE
            EXTRACT(MONTH FROM fat_sia.dt_periodo_inicial) = EXTRACT(MONTH FROM CURRENT_DATE)
            AND EXTRACT(YEAR FROM fat_sia.dt_periodo_inicial) = EXTRACT(YEAR FROM CURRENT_DATE)
    ) valor ON valor.cd_procedimento = atendime.cd_procedimento
WHERE
    ped_rx.ds_observacao LIKE 'REGU%'
    AND ped_rx.dt_pedido BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/01/24', 'DD/MM/YY')
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    valor;
