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
    con_rec
WHERE
    dt_emissao BETWEEN TO_DATE('01/07/2024', 'DD/MM/YYYY') AND TO_DATE('15/07/2024', 'DD/MM/YYYY')
ORDER BY
    cd_con_rec DESC

-------------------------------------------------------------------------------------------------
