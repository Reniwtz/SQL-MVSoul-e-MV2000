SELECT
    usuarios.cd_usuario,
    usuarios.nm_usuario,
    usuarios.cd_prestador,
    papel_usuarios.cd_papel,
    papel.ds_papel
FROM
         usuarios usuarios
    INNER JOIN papel_usuarios ON usuarios.cd_usuario = papel_usuarios.cd_usuario
    INNER JOIN papel ON papel.cd_papel = papel_usuarios.cd_papel
    INNER JOIN papel_mod ON papel_mod.cd_papel = papel.cd_papel
WHERE
    usuarios.sn_ativo LIKE 'S'
    AND usuarios.tp_privilegio LIKE 'U'
    --AND papel.cd_papel like  '29'
    AND papel_mod.cd_modulo = 'C_ORDCOM'
    --AND papel.ds_papel like '%GERENCIAL%'
    AND usuarios.sn_ativo LIKE 'S'
GROUP BY
    usuarios.cd_usuario,
    usuarios.nm_usuario,
    usuarios.cd_prestador,
    papel_usuarios.cd_papel,
    papel.ds_papel
