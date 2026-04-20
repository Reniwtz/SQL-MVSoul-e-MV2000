SELECT DISTINCT
    contrato_adiantamento.cd_contrato_adiant,
    contrato_adiantamento.cd_atendimento,
    to_char(contrato_adiantamento.cd_contratante),
    caucao.cd_caucao,
    caucao.cd_atendimento,
    caucao.nm_proprietario,
    itreg_amb.cd_reg_amb,
    itreg_amb.cd_lancamento,
    itreg_amb.hr_lancamento,
    itreg_amb.qt_lancamento,
    itreg_amb.vl_unitario,
    itreg_amb.vl_desconto,
    itreg_amb.vl_total_conta,
    itreg_amb.cd_convenio,
    itreg_amb.cd_pro_fat,
    pro_fat.ds_pro_fat,
    itreg_amb.dt_fechamento,
    itreg_amb.nm_usuario_fechou,
    reg_amb.cd_remessa,
    reccon_rec.nr_documento,
    reccon_rec.ds_reccon_rec,
    con_rec.cd_con_rec,
    con_rec.tp_quitacao,
    con_rec.vl_previsto,
    con_rec.cd_reduzido,
    itcon_rec.nr_parcela,
    con_rec.vl_recebido,
    lcto_contabil.cd_lcto_contabil,
    lcto_contabil.dt_lcto,
    lcto_contabil.cd_reduzido_credito,
    lcto_contabil.cd_reduzido_debito,
    lcto_contabil.vl_lancado
FROM
    contrato_adiantamento
    FULL OUTER JOIN caucao ON contrato_adiantamento.cd_atendimento = caucao.cd_atendimento
    LEFT JOIN itreg_amb ON itreg_amb.cd_atendimento = coalesce(contrato_adiantamento.cd_atendimento, caucao.cd_atendimento)
    LEFT JOIN pro_fat ON pro_fat.cd_pro_fat = itreg_amb.cd_pro_fat
    LEFT JOIN reg_amb ON reg_amb.cd_reg_amb = itreg_amb.cd_reg_amb
    LEFT JOIN reccon_rec ON reccon_rec.cd_caucao = caucao.cd_caucao
                            OR reccon_rec.cd_contrato_adiant = contrato_adiantamento.cd_contrato_adiant
    LEFT JOIN itcon_rec ON itcon_rec.cd_itcon_rec = reccon_rec.cd_itcon_rec
    LEFT JOIN con_rec ON con_rec.cd_con_rec = itcon_rec.cd_con_rec
    LEFT JOIN rec_mov_con ON rec_mov_con.cd_reccon_rec = reccon_rec.cd_reccon_rec
    LEFT JOIN lcto_contabil ON lcto_contabil.cd_lcto_movimento = con_rec.cd_lcto_movimento
WHERE
        caucao.cd_atendimento like '4303395'
