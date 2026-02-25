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

--------------------------------------------------------------------------------
-- Relatório do Gerente
--Em Desenvolvimento
SELECT
    sol_com.cd_sol_com       AS código_da_solic_de_compra,
    sol_com.nm_solicitante   AS nome_do_solicitante,
    sol_com.cd_usuario       AS descrição_do_usuário_logado,
    sol_com.dt_sol_com       AS dt_solicitação_de_compra,
    ord_com.cd_ord_com       AS ordem_de_compra,
    ord_com.dt_ord_com       AS dt_ordem_de_compra,
    ord_com.cd_fornecedor    AS codigo_do_fornecedor,
    fornecedor.nm_fornecedor AS nome_do_fornecedor,
    itord_pro.cd_produto     AS codigo_do_produto,
    produto.ds_produto       AS descricao_do_produto,
    itord_pro.qt_comprada    AS quantidade_comprada,
    itord_pro.qt_recebida    AS quantidade_recebida,
    itord_pro.qt_atendida    AS quantidade_atendida,
    itord_pro.vl_unitario    AS valor_unitario,
    itord_pro.vl_total       AS valor_total_item,
    ord_com.vl_total         AS valor_total_da_ordem,
    decode(ord_com.tp_situacao, 'U', 'AUTORIZADA', 'T', 'ATENDIDA',
           'A', 'AGUARDANDO PROXIMO NIVEL', ord_com.tp_situacao) AS status_da_solic_compra,
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
    )                                                            AS último_usuario_autorizador,
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
    )                                                            AS data_da_autorização
FROM
         ord_com ord_com
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = ord_com.cd_fornecedor
    INNER JOIN itord_pro ON itord_pro.cd_ord_com = ord_com.cd_ord_com
    INNER JOIN produto ON produto.cd_produto = itord_pro.cd_produto
    INNER JOIN sol_com ON sol_com.cd_sol_com = ord_com.cd_sol_com
WHERE
    ord_com.cd_sol_com LIKE '27177'
    AND ord_com.dt_cancelamento IS NULL;
