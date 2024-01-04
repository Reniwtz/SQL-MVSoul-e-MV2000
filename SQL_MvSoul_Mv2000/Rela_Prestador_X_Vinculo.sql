SELECT
    *
FROM
    prestador
WHERE
    cd_prestador LIKE '2498';

    
SELECT
    cd_prestador AS cad_prestador,
    nm_prestador  AS prestador,
    nr_cns        AS cns,
    nr_cpf_cgc    AS cpf,
    cd_cbos       AS cbo_vinculado
FROM
    prestador
WHERE
    cd_prestador like '2498'
    AND tip_situacao like 'A';
