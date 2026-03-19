SELECT
    mvto_estoque.cd_mvto_estoque                                          AS codigo_da_movimentacao,
    mvto_estoque.cd_estoque                                               AS codigo_do_estoque,
    mvto_estoque.dt_mvto_estoque                                          AS data_da_movimentacao,
    mvto_estoque.cd_atendimento                                           AS codigo_do_atendimento,
    atendime.cd_paciente                                                  AS codigo_do_paciente,
    produto.ds_produto                                                    AS descricao,
    SUM(itmvto_estoque_custo.qt_movimento)                                AS quantidade_movimentada,
    produto.vl_ultima_compra_ipi                                          AS valor_da_ultima_compra,
    SUM(itmvto_estoque_custo.qt_movimento) * produto.vl_ultima_compra_ipi AS valor_gasto,
    produto.vl_custo_medio                                                AS valor_do_custo_medio
FROM
         mvto_estoque
    INNER JOIN itmvto_estoque_custo ON itmvto_estoque_custo.cd_mvto_estoque = mvto_estoque.cd_mvto_estoque
    INNER JOIN produto ON produto.cd_produto = itmvto_estoque_custo.cd_produto
    INNER JOIN atendime ON mvto_estoque.cd_atendimento = atendime.cd_atendimento
WHERE
    mvto_estoque.cd_atendimento IN (
        SELECT
            cd_atendimento
        FROM
            atendime
        WHERE
                cd_atendimento = 417181
            AND tp_atendimento = 'I'
            AND cd_servico = 1
            AND cd_convenio = 1
    )
GROUP BY
    mvto_estoque.cd_mvto_estoque,
    mvto_estoque.cd_estoque,
    mvto_estoque.dt_mvto_estoque,
    mvto_estoque.cd_atendimento,
    atendime.cd_paciente,
    itmvto_estoque_custo.cd_produto,
    produto.ds_produto,
    produto.vl_ultima_compra_ipi,
    produto.vl_custo_medio
ORDER BY
    atendime.cd_paciente,
    mvto_estoque.cd_atendimento;
    
--------------------------------------------------------------------------------
SELECT
    reg_fat.cd_atendimento           AS código_do_atendimento,
    atendime.cd_paciente             AS código_do_paciente,
    reg_fat.cd_cid_principal         AS cid_principal,
    cid.ds_cid                       AS descrição_do_cid,
    itreg_fat.vl_sp                  AS valor_do_prestador,
    pro_fat.cd_pro_fat               AS código_do_procedimento,
    pro_fat.ds_pro_fat               AS descrição_do_procedimento,
    procedimento_sus.cd_procedimento AS código_do_procedimento,
    procedimento_sus.ds_procedimento AS descrição_do_procedimento,
    itreg_fat.vl_sh                  AS valor_do_hospitalar,
    mot_alt.ds_mot_alt               AS motivo_da_alta
FROM
         reg_fat reg_fat
    INNER JOIN itreg_fat ON itreg_fat.cd_reg_fat = reg_fat.cd_reg_fat
    INNER JOIN atendime ON atendime.cd_atendimento = reg_fat.cd_atendimento
    INNER JOIN mot_alt ON mot_alt.cd_mot_alt = atendime.cd_mot_alt
    INNER JOIN cid ON cid.cd_cid = reg_fat.cd_cid_principal
    INNER JOIN pro_fat ON pro_fat.cd_pro_fat = itreg_fat.cd_pro_fat
    INNER JOIN procedimento_sus ON procedimento_sus.cd_procedimento = itreg_fat.cd_procedimento
WHERE
    reg_fat.cd_atendimento LIKE '417181'
