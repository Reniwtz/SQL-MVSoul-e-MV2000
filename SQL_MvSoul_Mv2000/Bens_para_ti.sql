SELECT
    /*dt_compra,
    dt_vcto_garantia,
    ds_bem,
    ds_marca,
    ds_modelo,
    ds_plaqueta*/
    *
FROM
    bens
WHERE
    cd_setor LIKE '68'
    AND dt_baixa IS NULl
order by
    dt_compra desc
