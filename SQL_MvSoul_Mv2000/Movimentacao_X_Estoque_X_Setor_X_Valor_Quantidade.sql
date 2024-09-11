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
