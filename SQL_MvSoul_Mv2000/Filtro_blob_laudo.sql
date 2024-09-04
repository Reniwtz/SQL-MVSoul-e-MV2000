SELECT
    ged_conteudo.blob_conteudo
FROM
         laudo_rx laudo_rx
    INNER JOIN ged_conteudo ON ged_conteudo.cd_documento (+) = laudo_rx.cd_ged_documento
WHERE
    laudo_rx.cd_laudo = 987283;
