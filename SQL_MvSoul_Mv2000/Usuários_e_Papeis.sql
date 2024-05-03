SELECT distinct T1.CD_USUARIO, T1.NM_USUARIO, T3.CD_MODULO
    FROM DBASGU.USUARIOS T1, DBASGU.PAPEL_USUARIOS T2, DBASGU.PAPEL_MOD T3, DBASGU.PAPEL T4
WHERE
    T1.CD_USUARIO = T2.CD_USUARIO AND
    T3.CD_PAPEL = T2.CD_PAPEL AND
    T1.SN_ATIVO = 'S' AND
    T4.CD_PAPEL = T2.CD_PAPEL AND
    T3.CD_MODULO = 'CON_ATE'
ORDER BY T1.NM_USUARIO


--Papel Gerencial
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
    --INNER JOIN papel_mod ON papel_mod.cd_papel = papel.cd_papel
WHERE
        usuarios.sn_ativo LIKE 'S'
    AND usuarios.tp_privilegio LIKE 'U'
    AND papel.ds_papel like '%GERENCIAL%'
