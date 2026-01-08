SELECT
    banco.nm_banco             AS nome_do_banco,
    con_cor.ds_con_cor         AS descrição_da_conta,
    con_cor.nr_conta           AS número_da_conta,
    mov_concor.ds_movimentacao AS descrição_da_movimentação,
    mov_concor.vl_movimentacao AS valor_da_movimentação,
    mov_concor.dt_movimentacao AS data_da_movimentação,
    CASE
        WHEN lan_concor.tp_operacao_saldo_conta = '+' THEN 'Crédito'
        WHEN lan_concor.tp_operacao_saldo_conta = '-' THEN 'Débito'
        ELSE 'Indefinido'
    END AS tipo_operacao 
FROM
         con_cor con_cor
    INNER JOIN banco ON banco.cd_banco = con_cor.cd_banco
    INNER JOIN mov_concor ON mov_concor.cd_con_cor = con_cor.cd_con_cor
    INNER JOIN lan_concor ON lan_concor.cd_lan_concor = mov_concor.cd_lan_concor
WHERE
    con_cor.sn_ativo LIKE 'S'
    AND mov_concor.dt_movimentacao BETWEEN TO_DATE('01/01/2026', 'DD/MM/YYYY') AND TO_DATE('08/01/2026', 'DD/MM/YYYY')
ORDER BY
    banco.nm_banco,
    con_cor.ds_con_cor;
--------------------------------------------------------------------------------

SELECT
    nvl(
        CASE
            WHEN lan_concor.tp_operacao_saldo_conta = '+' THEN
                'Crédito'
            WHEN lan_concor.tp_operacao_saldo_conta = '-' THEN
                'Débito'
            ELSE
                'Indefinido'
        END, 'TOTAL GERAL')                AS tipo_operacao,
    SUM(mov_concor.vl_movimentacao) AS total_movimentado
FROM
         con_cor
    INNER JOIN banco ON banco.cd_banco = con_cor.cd_banco
    INNER JOIN mov_concor ON mov_concor.cd_con_cor = con_cor.cd_con_cor
    INNER JOIN lan_concor ON lan_concor.cd_lan_concor = mov_concor.cd_lan_concor
WHERE
        con_cor.sn_ativo = 'S'
    AND mov_concor.dt_movimentacao BETWEEN TO_DATE('01/01/2026', 'DD/MM/YYYY') AND TO_DATE('08/01/2026', 'DD/MM/YYYY')
GROUP BY
    ROLLUP(
        CASE
            WHEN lan_concor.tp_operacao_saldo_conta = '+' THEN
                'Crédito'
            WHEN lan_concor.tp_operacao_saldo_conta = '-' THEN
                'Débito'
            ELSE
                'Indefinido'
        END
    )
ORDER BY
    CASE
        WHEN tipo_operacao = 'Crédito' THEN
            1
        WHEN tipo_operacao = 'Débito'  THEN
            2
        ELSE
            3
    END;

