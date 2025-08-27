SELECT 
    cd_con_pag,
    DECODE(RANK() OVER(PARTITION BY cd_con_pag ORDER BY prestacao), 1, dt_pagamento, NULL) AS dt_pagamento,
    ds_fornecedor as Fornecedor,
    nr_cgc_cpf as CNPJ,
    DECODE(RANK() OVER(PARTITION BY cd_con_pag ORDER BY prestacao), 1, nr_documento, NULL) AS nr_documento,
    ds_tip_doc as tipo_de_documento,
    cd_usuario_criador_oc as criador_da_oc,
    ds_cotador as comprador,
    DECODE(RANK() OVER(PARTITION BY cd_con_pag ORDER BY prestacao), 1, NVL(vl_adiantamento, 0), NULL) AS vl_adiantamento,
    dt_prestacao_contas as Data_da_Prestação,
    NVL(vl_prestacao, 0) AS vl_prestacao,
    
    -- Cálculo do saldo ajustado
    vl_saldo - NVL(vl_recebido, 0) - NVL(vl_prest_acumulado, 0) + NVL(vl_pago, 0) AS vl_saldo_final
FROM (
    SELECT DISTINCT
        c.cd_con_pag,
        p.dt_pagamento,
        c.cd_fornecedor,
        f.nr_cgc_cpf,
        c.ds_fornecedor,
        c.nr_documento || '/' || i.nr_parcela AS nr_documento,
        c.sn_prestacao_realizada,
        c.cd_con_rec_prest,
        NVL(i.vl_duplicata, 0) AS vl_adiantamento,
        c.cd_con_pag_prest,
        c.cd_multi_empresa,
        d.dt_prestacao_contas,
        sc.cd_usuario,
        co.ds_cotador,
        oc.cd_usuario_criador_oc,
        td.ds_tip_doc,
        d.prestacao,
        NVL(d.vl_prestacao, 0) AS vl_prestacao,

        -- Acumulado das prestações por cd_con_pag
        SUM(NVL(d.vl_prestacao, 0)) OVER (PARTITION BY c.cd_con_pag ORDER BY d.prestacao) AS vl_prest_acumulado,

        -- Valor recebido referente ao código de recebimento
        (
            SELECT SUM(rr.vl_recebido)
            FROM con_rec cr, itcon_rec ir, reccon_rec rr
            WHERE cr.cd_con_rec = c.cd_con_rec_prest
              AND cr.cd_con_rec = ir.cd_con_rec
              AND ir.cd_itcon_rec = rr.cd_itcon_rec
              AND TRUNC(rr.dt_recebimento) BETWEEN TO_DATE('01/07/2025', 'DD/MM/YYYY') AND TO_DATE('31/07/2025', 'DD/MM/YYYY')
        ) AS vl_recebido,

        -- Total de imposto vinculado ao pagamento
        (
            SELECT SUM(vl_detalhamento)
            FROM tip_detcon_pag
            WHERE cd_con_pag_pai = c.cd_con_pag
        ) AS vl_imposto,

        -- Total pago na prestação
        (
            SELECT SUM(it.vl_duplicata)
            FROM con_pag cp, itcon_pag it
            WHERE cp.cd_con_pag = c.cd_con_pag_prest
              AND cp.cd_con_pag = it.cd_con_pag
              AND TRUNC(cp.dt_lancamento) BETWEEN TO_DATE('01/07/2025', 'DD/MM/YYYY') AND TO_DATE('31/07/2025', 'DD/MM/YYYY')
        ) AS vl_pago,

        -- Saldo total de adiantamento ainda não prestado
        NVL((
            SELECT SUM(NVL(vl_duplicata, 0))
            FROM con_pag cp, dbamv.itcon_pag ip, dbamv.pagcon_pag pp
            WHERE cp.cd_con_pag = ip.cd_con_pag
              AND ip.cd_itcon_pag = pp.cd_itcon_pag
              AND tp_adiantamento IS NOT NULL
              AND pp.dt_estorno IS NULL
              AND NVL(pp.sn_estorno, 'N') <> 'S'
              AND cp.cd_con_pag = c.cd_con_pag
        ), 0) AS vl_saldo

    FROM 
        con_pag c
        JOIN itcon_pag i ON c.cd_con_pag = i.cd_con_pag
        JOIN pagcon_pag p ON i.cd_itcon_pag = p.cd_itcon_pag
        JOIN fornecedor f ON c.cd_fornecedor = f.cd_fornecedor
        JOIN tip_doc td ON td.cd_tip_doc = c.cd_tip_doc
        LEFT JOIN ord_com oc ON oc.cd_ord_com = TO_NUMBER(REGEXP_SUBSTR(c.nr_documento, '^\d+'))
        LEFT JOIN sol_com sc ON sc.cd_sol_com = oc.cd_sol_com
        LEFT JOIN cotador co ON co.cd_cotador = sc.cd_cotador
        LEFT JOIN (
            SELECT 
                d.cd_con_pag AS cd_con_pag_prest,
                d.dt_prestacao_contas,
                NVL(d.vl_prestacao, 0) AS vl_prestacao,
                d.cd_prestacao_contas AS prestacao
            FROM 
                prestacao_de_contas d
                JOIN 
                con_pag c ON d.cd_con_pag = c.cd_con_pag
            WHERE 
                c.cd_multi_empresa = 1
                AND TRUNC(d.dt_prestacao_contas) BETWEEN TO_DATE('01/07/2025','DD/MM/YYYY') AND TO_DATE('31/07/2025','DD/MM/YYYY')
                AND c.cd_fornecedor IS NOT NULL
        ) d ON d.cd_con_pag_prest = c.cd_con_pag

    WHERE 
        c.cd_multi_empresa = 1
        AND NVL(p.sn_estorno, 'N') <> 'S'
        AND p.tp_pagamento NOT IN ('B')
        AND TRUNC(p.dt_pagamento) BETWEEN TO_DATE('01/07/2025','DD/MM/YYYY') AND TO_DATE('31/07/2025','DD/MM/YYYY')
        AND tp_adiantamento IS NOT NULL
        AND p.dt_estorno IS NULL
        AND c.cd_fornecedor IS NOT NULL
        AND c.cd_con_pag NOT IN (
            SELECT d.cd_con_pag
            FROM prestacao_de_contas d
            WHERE d.cd_con_pag = c.cd_con_pag
              AND TRUNC(d.dt_prestacao_contas) BETWEEN TO_DATE('01/07/2025','DD/MM/YYYY') AND TO_DATE('31/07/2025','DD/MM/YYYY')
            GROUP BY d.cd_con_pag
            HAVING 
                i.vl_soma_pago 
                - SUM(d.vl_prestacao) 
                - NVL((
                    SELECT SUM(rr.vl_recebido)
                    FROM con_rec cr
                        JOIN itcon_rec ir ON cr.cd_con_rec = ir.cd_con_rec
                        JOIN reccon_rec rr ON ir.cd_itcon_rec = rr.cd_itcon_rec
                    WHERE rr.dt_estorno IS NULL
                      AND cr.cd_con_rec = c.cd_con_rec_prest
                ), 0) <= 0
        )
)
ORDER BY 
    ds_fornecedor, 
    cd_con_pag, 
    dt_prestacao_contas, 
    prestacao;
