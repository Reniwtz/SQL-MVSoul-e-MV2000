SELECT
    cd_con_rec,
    dt_emissao,
    tp_con_rec,
    ds_con_rec,
    vl_previsto,
    cd_remessa,
    cd_tip_doc,
    nr_documento,
    nm_cliente,
    cd_reg_amb,
    cd_atendimento,
    cd_usuario,
    dt_lancamento
FROM
    con_rec con_rec
WHERE
    dt_emissao BETWEEN TO_DATE('01/07/2024', 'DD/MM/YYYY') AND TO_DATE('15/07/2024', 'DD/MM/YYYY')
ORDER BY
    cd_con_rec DESC;
    
--------------------------------------------------------------------------------

SELECT
    cd_reccon_rec,
    cd_itcon_rec,
    nr_documento,
    ds_reccon_rec,
    cd_fin_car,
    cd_caixa,
    tp_recebimento,
    dt_recebimento,
    vl_recebido,
    cd_exp_contabilidade,
    cd_caucao,
    vl_moeda,
    cd_doc_caixa,
    cd_mov_caixa,
    cd_processo
FROM
    reccon_rec reccon_rec
WHERE
    dt_recebimento BETWEEN TO_DATE('01/07/2024', 'DD/MM/YYYY') AND TO_DATE('15/07/2024', 'DD/MM/YYYY');
 
--------------------------------------------------------------------------------

SELECT
    cd_itcon_rec,
    cd_con_rec,
    nr_parcela,
    dt_prevista_recebimento,
    dt_vencimento,
    vl_duplicata,
    vl_soma_recebido
FROM
    itcon_rec
WHERE
    dt_prevista_recebimento BETWEEN TO_DATE('01/07/2024', 'DD/MM/YYYY') AND TO_DATE('15/07/2024', 'DD/MM/YYYY');
 
--------------------------------------------------------------------------------
 
SELECT
    cd_con_pag,
    nr_documento,
    dt_lancamento,
    dt_emissao,
    sn_contabiliza,
    tp_vencimento
    tp_vencimento,
    ds_con_pag,
    cd_fornecedor,
    cd_tip_doc,
    vl_bruto_conta,
    ds_fornecedor,
    cd_reduzido,
    vl_base_irrf,
    vl_moeda,
    cd_processo,
    cd_usuario_ins,
    tp_status
FROM
    con_pag
WHERE
    dt_lancamento BETWEEN TO_DATE('01/07/2024', 'DD/MM/YYYY') AND TO_DATE('15/07/2024', 'DD/MM/YYYY');
 
--------------------------------------------------------------------------------

SELECT
    cd_itcon_pag,
    cd_con_pag,
    nr_parcela,
    dt_vencimento,
    vl_duplicata,
    tp_quitacao,
    dt_quitacao,
    vl_soma_pago,
    dt_prevista_pag,
    vl_soma_baixada,
    vl_moeda
FROM
    itcon_pag
Where
    dt_vencimento BETWEEN TO_DATE('01/07/2024', 'DD/MM/YYYY') AND TO_DATE('15/07/2024', 'DD/MM/YYYY'); 
