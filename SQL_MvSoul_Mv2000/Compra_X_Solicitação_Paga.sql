SELECT
    sol_com.cd_sol_com,
    sol_com.dt_sol_com,
    sol_com.cd_usuario,
    ord_com.cd_ord_com,
    ord_com.dt_ord_com,
    ord_com.dt_prev_entrega,
    ord_com.ds_ordem_de_compra,
    cotador.ds_cotador,
    setor.nm_setor,
    ord_com.cd_id_usuario_autorizou,
    sol_com.tp_sol_com,
    (
        SELECT
            cd_usuario
        FROM
            autorizador_ordem_compra
        WHERE
            cd_ord_com = ord_com.cd_ord_com
        ORDER BY
            dt_autorizacao DESC
        FETCH FIRST 1 ROW ONLY
    ) AS autorizador_cd_usuario,
    con_pag.nr_documento,
    itcon_pag.tp_quitacao,
    itcon_pag.vl_duplicata
FROM
         ord_com
    INNER JOIN estoque ON estoque.cd_estoque = ord_com.cd_estoque
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = ord_com.cd_fornecedor
    LEFT JOIN sol_com ON sol_com.cd_sol_com = ord_com.cd_sol_com
    LEFT JOIN setor ON setor.cd_setor = sol_com.cd_setor
    LEFT JOIN cotador ON cotador.cd_cotador = sol_com.cd_cotador
    LEFT JOIN conta ON conta.cd_conta = sol_com.cd_conta
    LEFT JOIN ent_pro ON ent_pro.cd_ord_com = ord_com.cd_ord_com
    LEFT JOIN con_pag ON con_pag.nr_documento = ent_pro.nr_documento
    LEFT JOIN itcon_pag ON itcon_pag.cd_con_pag = con_pag.cd_con_pag
WHERE
    fornecedor.tp_cliente_forn IN ( 'F', 'A', 'R', 'T' )
    --AND sol_com.dt_sol_com BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND ent_pro.cd_ord_com LIKE '50245'
ORDER BY
    sol_com.cd_sol_com
 
