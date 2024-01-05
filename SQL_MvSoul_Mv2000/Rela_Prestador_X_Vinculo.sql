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
        prestador.cd_prestador LIKE '2498'
    AND prestador.tp_situacao LIKE 'A'
GROUP BY
    prestador.cd_prestador,  
    prestador.nm_prestador,
    prestador.nr_cns,
    prestador.nr_cpf_cgc,
    prestador_cbo.cd_cbo;
