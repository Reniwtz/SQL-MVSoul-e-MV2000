SELECT
    prestador.cd_prestador AS cad_prestador,
    prestador.nm_prestador AS prestador,
    prestador.nr_cns       AS cns,
    prestador.nr_cpf_cgc   AS cpf,
    prestador_cbo.cd_cbo   AS cbo_vinculado,
    cbo.ds_cbos            AS descrição
FROM
         prestador prestador
    INNER JOIN prestador_cbo ON prestador.cd_prestador = prestador_cbo.cd_prestador
    INNER JOIN cbo ON prestador_cbo.cd_cbo = cbo.cd_cbos
WHERE
        prestador.tp_situacao LIKE 'A'
    AND cbo.ds_cbos LIKE 'MÉDICO%'
GROUP BY
    prestador.cd_prestador,  
    prestador.nm_prestador,
    prestador.nr_cns,
    prestador.nr_cpf_cgc,
    prestador_cbo.cd_cbo,
    cbo.ds_cbos
order by 
    prestador.cd_prestador

------------------------------------------------------------------------------------------
-- Prestador
WITH empresa AS (
    SELECT DISTINCT
        prestador.cd_prestador        AS codigo_do_prestador,
        prestador.nm_prestador        AS nome_do_prestador,
        prestador.cd_prestador_muitos AS codigo_do_chefe,
        prestador.nr_cpf_cgc          AS cpf,
        tip_presta.nm_tip_presta      AS tipo_de_prestador,
        especialid.ds_especialid      AS descrição_de_especialidade,
        esp_med.sn_especial_principal AS especialidade_principal
    FROM
             prestador prestador
        INNER JOIN tip_presta ON tip_presta.cd_tip_presta = prestador.cd_tip_presta
        LEFT JOIN esp_med ON esp_med.cd_prestador = prestador.cd_prestador
        LEFT JOIN especialid ON especialid.cd_especialid = esp_med.cd_especialid
    WHERE
        prestador.tp_situacao LIKE 'A'
        AND prestador.cd_tip_presta IN ( 8, 7, 12, 17, 20,
                                         21, 22, 23, 24, 25,
                                         26, 33, 38, 41, 44,
                                         48 )
        --AND esp_med.sn_especial_principal LIKE '%S%'
)
SELECT DISTINCT
    empresa.codigo_do_prestador,
    empresa.nome_do_prestador,
    empresa.codigo_do_chefe,
    empresa.cpf,
    empresa.tipo_de_prestador,
    empresa.descrição_de_especialidade,
    especialidade_principal,
    prestador.nm_prestador AS nome_do_chefe,
    prestador.nr_cpf_cgc   AS cnpj
    /*fornecedor.cd_fornecedor,
    fornecedor.nm_fantasia*/
FROM
    empresa
    LEFT JOIN prestador ON prestador.cd_prestador = empresa.codigo_do_chefe
    --INNER JOIN fornecedor ON fornecedor.nr_cgc_cpf = prestador.nr_cpf_cgc
ORDER BY
    empresa.codigo_do_prestador,
    empresa.nome_do_prestador,
    empresa.tipo_de_prestador;
