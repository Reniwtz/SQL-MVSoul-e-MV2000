SELECT
    sol_com.cd_sol_com AS código_solicitação,
    sol_com.dt_sol_com AS data_da_solicitação,
    sol_com.cd_usuario AS usuário_solicitante,
    ord_com.cd_ord_com AS código_ordem_compra,
    ord_com.dt_ord_com AS data_da_ordem_compra,
    cotador.ds_cotador AS comprador,
    (
        SELECT
            autorizador_ordem_compra.cd_usuario
        FROM
            autorizador_ordem_compra
        WHERE
            cd_ord_com = ord_com.cd_ord_com
        ORDER BY
            dt_autorizacao DESC
        FETCH FIRST 1 ROW ONLY
    )                  AS usuario_autorizador,
    (
        SELECT
            autorizador_ordem_compra.dt_autorizacao
        FROM
            autorizador_ordem_compra
        WHERE
            cd_ord_com = ord_com.cd_ord_com
        ORDER BY
            dt_autorizacao DESC
        FETCH FIRST 1 ROW ONLY
    )                  AS data_da_autorização,
    itcon_pag.dt_quitacao
FROM
         dbamv.ord_com
    INNER JOIN dbamv.estoque ON estoque.cd_estoque = ord_com.cd_estoque
    INNER JOIN dbamv.fornecedor ON fornecedor.cd_fornecedor = ord_com.cd_fornecedor
    LEFT JOIN dbamv.sol_com ON sol_com.cd_sol_com = ord_com.cd_sol_com
    LEFT JOIN dbamv.setor ON setor.cd_setor = sol_com.cd_setor
    LEFT JOIN dbamv.cotador ON cotador.cd_cotador = sol_com.cd_cotador
    LEFT JOIN dbamv.conta ON conta.cd_conta = sol_com.cd_conta
    LEFT JOIN dbamv.ent_pro ON ent_pro.cd_ord_com = ord_com.cd_ord_com
    LEFT JOIN dbamv.con_pag ON con_pag.nr_documento = ent_pro.nr_documento
    LEFT JOIN dbamv.itcon_pag ON itcon_pag.cd_con_pag = con_pag.cd_con_pag
WHERE
    fornecedor.tp_cliente_forn IN ( 'F', 'A', 'R', 'T' )
    AND sol_com.dt_sol_com BETWEEN TO_DATE('01/09/2025', 'DD/MM/YYYY') AND TO_DATE('30/09/2025', 'DD/MM/YYYY')
ORDER BY
    sol_com.cd_sol_com DESC,
    sol_com.cd_sol_com

----------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- Relatório do Gerente
SELECT
    sol_com.cd_sol_com                                           AS código_solicitação,
    sol_com.dt_sol_com                                           AS data_da_solicitação,
    sol_com.cd_usuario                                           AS usuário_solicitante,
    ord_com.cd_ord_com                                           AS código_ordem_compra,
    ord_com.dt_ord_com                                           AS data_da_ordem_compra,
    cotador.ds_cotador                                           AS comprador,
    (
        SELECT
            autorizador_ordem_compra.cd_usuario
        FROM
            autorizador_ordem_compra
        WHERE
            cd_ord_com = ord_com.cd_ord_com
        ORDER BY
            dt_autorizacao DESC
        FETCH FIRST 1 ROW ONLY
    )                                                            AS usuario_autorizador,
    (
        SELECT
            autorizador_ordem_compra.dt_autorizacao
        FROM
            autorizador_ordem_compra
        WHERE
            cd_ord_com = ord_com.cd_ord_com
        ORDER BY
            dt_autorizacao DESC
        FETCH FIRST 1 ROW ONLY
    )                                                            AS data_da_autorização,
    itcon_pag.dt_quitacao,
    decode(ord_com.tp_situacao, 'U', 'AUTORIZADA', 'T', 'ATENDIDA',
           'A', 'AGUARDANDO PROXIMO NIVEL', ord_com.tp_situacao) AS situação,
    produto.ds_produto,
    itsol_com.qt_solic                                           AS quantidade_solicitada,
    itsol_com.qt_atendida                                        AS quantidade_atendida,
    produto.vl_ultima_entrada                                    AS valor_da_ultima,
    ord_com.vl_total                                             AS valor_total_da_ordem
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
    LEFT JOIN itsol_com ON itsol_com.cd_sol_com = sol_com.cd_sol_com
    LEFT JOIN produto ON produto.cd_produto = itsol_com.cd_produto
WHERE
    fornecedor.tp_cliente_forn IN ( 'F', 'A', 'R', 'T' )
    AND sol_com.dt_sol_com BETWEEN TO_DATE('01/02/2026', 'DD/MM/YYYY') AND TO_DATE('19/02/2026', 'DD/MM/YYYY')
ORDER BY
    sol_com.cd_sol_com DESC,
    sol_com.cd_sol_com
