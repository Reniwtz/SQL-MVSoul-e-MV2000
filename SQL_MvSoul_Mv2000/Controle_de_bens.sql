SELECT
    bens.cd_bem                      AS código_do_bem,
    bens.ds_bem                      AS descrição_do_bem,
    bens.ds_especificacoes           AS especificações,
    bens.ds_marca                    AS marca,
    bens.nr_serie                    AS número_de_série,
    bens.dt_compra                   AS data_da_compra,
    bens.vl_compra                   AS valor_da_compra,
    ent_pro.cd_ent_pro               AS código_da_entrada,
    ent_pro.dt_entrada               AS data_da_entrada,
    ent_pro.nr_documento             AS nr_notafiscal,
    ent_pro.cd_fornecedor            AS fornecedor,
    ent_pro.vl_total                 AS valor_da_entrada,
    ent_pro.cd_ord_com               AS ordem_de_compra,
    ent_pro.cd_con_pag               AS código_conta_a_pagar,
    bens.dt_vcto_garantia            AS garantia,
    setor.nm_setor                   AS setor,
    localidade.ds_localidade         AS localidade_especifica,
    bens.dt_baixa                    AS data_da_baixa,
    classe.ds_classe                 AS classe,
    especie.ds_especie               AS especie,
    tipo_aquisicao.ds_tipo_aquisicao AS tipo_de_aquisição,
    dt_deprecia                      AS data_da_depreciação,
    itdeprecia.vl_deprecia_antes     AS valor_deprecia_anterior,
    itdeprecia.vl_deprecia_atual     AS valor_deprecia_anterior,
    itdeprecia.tx_depreciacao        AS taxa_de_depreciacao
FROM
         bens bens
    INNER JOIN classe ON classe.cd_classe = bens.cd_classe
                         AND classe.cd_especie = bens.cd_especie
    INNER JOIN especie ON especie.cd_especie = bens.cd_especie
    INNER JOIN setor ON setor.cd_setor = bens.cd_setor
    INNER JOIN tipo_aquisicao ON tipo_aquisicao.cd_tipo_aquisicao = bens.cd_tipo_aquisicao
    INNER JOIN ent_pro ON ent_pro.cd_ent_pro = bens.cd_ent_pro
    LEFT JOIN localidade ON localidade.cd_localidade = bens.cd_localidade
    LEFT JOIN itdeprecia ON itdeprecia.cd_bem = bens.cd_bem
    LEFT JOIN deprecia ON deprecia.cd_deprecia = itdeprecia.cd_deprecia
WHERE
       /* bens.cd_setor = '68'
    AND bens.dt_baixa IS NULL
    AND bens.cd_bem = '10310'*/
    bens.cd_bem = '7131'
GROUP BY
    bens.cd_bem,
    bens.ds_bem,
    bens.ds_especificacoes,
    bens.ds_marca,
    bens.nr_serie,
    bens.dt_compra,
    bens.vl_compra,
    ent_pro.cd_ent_pro,
    ent_pro.dt_entrada,
    ent_pro.nr_documento,
    ent_pro.cd_fornecedor,
    ent_pro.vl_total,
    ent_pro.cd_ord_com,
    ent_pro.cd_con_pag,
    bens.dt_vcto_garantia,
    setor.nm_setor,
    localidade.ds_localidade,
    bens.dt_baixa,
    classe.ds_classe,
    especie.ds_especie,
    tipo_aquisicao.ds_tipo_aquisicao,
    dt_deprecia,
    itdeprecia.cd_itdeprecia,
    itdeprecia.vl_deprecia_antes,
    itdeprecia.vl_deprecia_atual,
    itdeprecia.tx_depreciacao
ORDER BY
    bens.cd_bem,
    itdeprecia.cd_itdeprecia
