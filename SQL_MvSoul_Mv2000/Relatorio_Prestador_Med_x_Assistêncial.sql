SELECT
    prestador.nm_prestador,
    prestador.nr_cpf_cgc,
    tip_presta.nm_tip_presta
FROM
         prestador prestador
    INNER JOIN tip_presta ON tip_presta.cd_tip_presta = prestador.cd_tip_presta
WHERE
    prestador.tp_situacao LIKE 'A'
    AND prestador.cd_tip_presta IN ( 1, 3, 4, 5, 6,8, 9, 10, 11, 14, 26, 30, 32, 38, 43 )
group by
    prestador.nm_prestador,
    prestador.nr_cpf_cgc,
    tip_presta.nm_tip_presta
ORDER BY
    tip_presta.nm_tip_presta
