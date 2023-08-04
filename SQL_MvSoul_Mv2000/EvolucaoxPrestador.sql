SELECT
    *
FROM
    pw_documento_clinico
WHERE
        pw_documento_clinico.cd_prestador LIKE '5662'
    And cd_tipo_documento LIKE '33'
    AND pw_documento_clinico.dh_criacao BETWEEN ( '01/07/2023' ) AND ( '31/07/2023' )
