SELECT
    itmvto_estoque_custo.cd_produto        AS código_do_produto,
    produto.ds_produto                     AS descrição,
    SUM(itmvto_estoque_custo.qt_movimento) AS quantidade_movimentada,
    produto.vl_ultima_compra_ipi           AS valor_da_última_compra,
    produto.vl_custo_medio                 AS valor_do_custo_médio
FROM
    mvto_estoque
    INNER JOIN itmvto_estoque_custo ON itmvto_estoque_custo.cd_mvto_estoque = mvto_estoque.cd_mvto_estoque
    INNER JOIN produto ON produto.cd_produto = itmvto_estoque_custo.cd_produto
WHERE
    cd_unid_int LIKE '6'
    AND dt_mvto_estoque BETWEEN TO_DATE('01/08/24', 'DD/MM/YY') AND TO_DATE('31/08/24', 'DD/MM/YY')
GROUP BY
    itmvto_estoque_custo.cd_produto,
    produto.ds_produto,
    produto.vl_ultima_compra_ipi,
    produto.vl_custo_medio 
ORDER BY
    quantidade_movimentada

--------------------------------------------------------------------------------------------------
-- update do código
SELECT
    mvto_estoque.cd_atendimento            AS atendimento,
    paciente.cd_paciente                   AS codigo_do_paciente,
    paciente.nm_paciente                   AS nome_do_paciente,
    mvto_estoque.hr_mvto_estoque           AS data_da_movimentação,
    unid_int.ds_unid_int                   AS unidade_de_internação,
    produto.ds_produto                     AS descrição_do_produto,
    produto.vl_ultima_compra_ipi           AS valor_da_última_compra,
    produto.vl_custo_medio                 AS valor_do_custo_médio
FROM
         mvto_estoque mvto_estoque
    INNER JOIN unid_int ON mvto_estoque.cd_unid_int = unid_int.cd_unid_int
    INNER JOIN atendime ON mvto_estoque.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN itmvto_estoque_custo ON itmvto_estoque_custo.cd_mvto_estoque = mvto_estoque.cd_mvto_estoque
    INNER JOIN produto ON produto.cd_produto = itmvto_estoque_custo.cd_produto
WHERE
    mvto_estoque.hr_mvto_estoque BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
    AND atendime.cd_atendimento IS NOT NULL
    AND mvto_estoque.cd_unid_int = '6'
GROUP BY
    mvto_estoque.cd_atendimento,
    paciente.cd_paciente,
    paciente.nm_paciente,
    mvto_estoque.hr_mvto_estoque,
    unid_int.ds_unid_int,
    produto.ds_produto,
    produto.vl_ultima_compra_ipi,
    produto.vl_custo_medio
ORDER BY
    paciente.cd_paciente,
    mvto_estoque.hr_mvto_estoque
