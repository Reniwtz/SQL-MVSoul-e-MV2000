SELECT
    con_pag.nr_documento,
    itcon_pag.tp_quitacao,
    itcon_pag.vl_duplicata
FROM
    ent_pro ent_pro
    left join con_pag on con_pag.nr_documento = ent_pro.nr_documento 
    left join itcon_pag on itcon_pag.cd_con_pag = con_pag.cd_con_pag
WHERE
    ent_pro.cd_ord_com LIKE '50245';

--------------------------------------------------------------------------------
    
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
    AND sol_com.cd_sol_com = 22007
ORDER BY
    sol_com.cd_sol_com

-----------------------------------------------------------------------
SELECT
    sol_com.cd_sol_com                                           AS código_da_solic_de_compra,
    sol_com.dt_sol_com                                           AS dt_solicitação_de_compra,
    sol_com.cd_usuario                                           AS usuário_da_solicitação,
    setor.nm_setor                                               AS setor_solicitante,
    ord_com.cd_ord_com                                           AS ordem_de_compra,
    ord_com.dt_ord_com                                           AS dt_ordem_de_compra,
    ord_com.cd_usuario_criador_oc                                AS usuário_criador_da_oc,
    ord_com.dt_prev_entrega_intervalo                            AS previsão_de_entrega,
    ord_com.cd_fornecedor                                        AS código_do_fornecedor,
    fornecedor.nm_fornecedor                                     AS nome_do_fornecedor,
    itord_pro.cd_produto                                         AS código_do_produto,
    produto.ds_produto                                           AS descrição_do_produto,
    est_pro.qt_estoque_atual                                     AS quantida_atual_de_estoque,
    estoque.ds_estoque                                           AS descrição_do_estoque,
    itord_pro.qt_comprada                                        AS quantidade_comprada,
    itord_pro.qt_recebida                                        AS quantidade_recebida,
    itord_pro.qt_atendida                                        AS quantidade_atendida,
    itord_pro.vl_unitario                                        AS valor_unitário,
    itord_pro.vl_total                                           AS valor_total_dos_item,
    ord_com.vl_total                                             AS valor_total_da_ordem,
    decode(ord_com.tp_situacao, 'U', 'AUTORIZADA', 'T', 'ATENDIDA',
           'A', 'AGUARDANDO PROXIMO NIVEL', ord_com.tp_situacao) AS status_da_solic_compra,
    (
        SELECT
            LISTAGG(autorizador_ordem_compra.cd_usuario
                    || ' - '
                    || to_char(autorizador_ordem_compra.dt_autorizacao, 'DD/MM/YYYY HH24:MI:SS'), ' | ') WITHIN GROUP(
            ORDER BY
                autorizador_ordem_compra.dt_autorizacao
            )
        FROM
            autorizador_ordem_compra autorizador_ordem_compra
        WHERE
            autorizador_ordem_compra.cd_ord_com = ord_com.cd_ord_com
    )                                                            AS autorizadores_com_datas,
    ent_pro.cd_ent_pro                                           AS código_da_entrada_do_produto,
    ent_pro.cd_estoque                                           AS estoque_de_entrada,
    ent_pro.hr_entrada                                           AS data_da_entrada,
    ent_pro.nr_documento                                         AS nota_fiscal,
    ent_pro.vl_total                                             AS valor_total_da_nota,
    con_pag.cd_con_pag                                           AS código_contas_a_pagar,
    con_pag.dt_lancamento                                        AS dt_lancamentento,
    con_pag.cd_reduzido                                          AS conta_contábil
FROM
         ord_com ord_com
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = ord_com.cd_fornecedor
    INNER JOIN itord_pro ON itord_pro.cd_ord_com = ord_com.cd_ord_com
    INNER JOIN produto ON produto.cd_produto = itord_pro.cd_produto
    INNER JOIN sol_com ON sol_com.cd_sol_com = ord_com.cd_sol_com
    INNER JOIN setor ON setor.cd_setor = sol_com.cd_setor
    LEFT JOIN ent_pro ON ent_pro.cd_ord_com = ord_com.cd_ord_com
    LEFT JOIN con_pag ON con_pag.cd_con_pag = ent_pro.cd_con_pag
    LEFT JOIN est_pro ON est_pro.qt_estoque_atual = produto.cd_produto
    LEFT JOIN estoque ON estoque.cd_estoque = est_pro.cd_estoque
WHERE
        con_pag.cd_fornecedor = '2'
    AND con_pag.nr_documento = '61495'
    AND con_pag.dt_emissao = TO_DATE('30/01/26', 'DD/MM/YY')
ORDER BY
    sol_com.cd_sol_com,
    ord_com.cd_ord_com,
    ent_pro.nr_documento
