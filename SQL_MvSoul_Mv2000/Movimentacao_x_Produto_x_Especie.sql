SELECT
    itmvto_estoque_custo.cd_produto        AS código_do_produto,
    produto.ds_produto                     AS descrição,
    SUM(itmvto_estoque_custo.qt_movimento) AS quantidade_movimentada,
    produto.vl_ultima_compra_ipi           AS valor_da_última_compra,
    produto.vl_custo_medio                 AS valor_do_custo_médio
FROM
         itmvto_estoque_custo itmvto_estoque_custo
    INNER JOIN produto ON produto.cd_produto = itmvto_estoque_custo.cd_produto
    INNER JOIN especie ON especie.cd_especie = produto.cd_especie
WHERE
    itmvto_estoque_custo.dh_mvto_estoque BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/05/24', 'DD/MM/YY')
    AND ( produto.cd_especie LIKE '2'
          OR produto.cd_especie LIKE '9'
          OR produto.cd_especie LIKE '22' )
GROUP BY
    itmvto_estoque_custo.cd_produto,
    produto.ds_produto,
    produto.vl_ultima_compra_ipi,
    produto.vl_custo_medio 
ORDER BY
    quantidade_movimentada
