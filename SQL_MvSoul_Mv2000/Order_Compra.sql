SELECT DISTINCT
    sol_com.cd_sol_com,
    sol_com.dt_sol_com,
    sol_com.cd_usuario,
    ord_com.cd_ord_com,
    ord_com.dt_ord_com,
    ord_com.dt_prev_entrega,
    ord_com.ds_ordem_de_compra,
    cotador.ds_cotador,
    setor.nm_setor,
    ord_com.cd_id_usuario_autorizou
FROM
    dbamv.ord_com
    INNER JOIN dbamv.estoque ON estoque.cd_estoque = ord_com.cd_estoque
    INNER JOIN dbamv.fornecedor ON fornecedor.cd_fornecedor = ord_com.cd_fornecedor
    LEFT JOIN dbamv.sol_com ON sol_com.cd_sol_com = ord_com.cd_sol_com
    LEFT JOIN dbamv.setor ON setor.cd_setor = sol_com.cd_setor
    LEFT JOIN dbamv.cotador ON cotador.cd_cotador = sol_com.cd_cotador
    LEFT JOIN dbamv.conta ON conta.cd_conta = sol_com.cd_conta
WHERE
    fornecedor.tp_cliente_forn IN ('F', 'A', 'R', 'T')
    AND sol_com.dt_sol_com BETWEEN TO_DATE('01/02/2024', 'DD/MM/YYYY') AND TO_DATE('29/02/2024', 'DD/MM/YYYY')
    --AND ord_com.cd_id_usuario_autorizou  -- senao estiver null pq esta finalizado
    --and sol_com.cd_sol_com is not NULL
ORDER BY
    sol_com.cd_sol_com;


-- Ultimo aprovador
SELECT
    *
FROM
    autorizador_ordem_compra
WHERE
    cd_ord_com = 56246
ORDER BY
    dt_autorizacao DESC
FETCH FIRST 1 ROW ONLY;
