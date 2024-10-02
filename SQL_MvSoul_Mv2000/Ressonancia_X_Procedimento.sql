SELECT
    itped_rx.cd_ped_rx,
    exa_rx.cd_procedimento_sia,
    exa_rx.ds_exa_rx,
    laudo_rx.cd_prestador_assinatura
FROM
         itped_rx
    INNER JOIN exa_rx ON itped_rx.cd_exa_rx = exa_rx.cd_exa_rx
    INNER JOIN ped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    LEFT JOIN laudo_rx ON laudo_rx.cd_laudo = itped_rx.cd_laudo
WHERE
    itped_rx.dt_realizado BETWEEN TO_DATE('01/09/2024', 'DD/MM/YYYY') AND TO_DATE('30/09/2024', 'DD/MM/YYYY')
    AND ped_rx.cd_set_exa = 31
    AND exa_rx.ds_exa_rx LIKE '%RM%'
    AND ( exa_rx.cd_exa_rx <> '715'
          AND exa_rx.cd_exa_rx <> '232'
          AND exa_rx.cd_exa_rx <> '393' )
    AND laudo_rx.cd_prestador_assinatura IS NOT NULL
GROUP BY
    itped_rx.cd_ped_rx,
    exa_rx.cd_procedimento_sia,
    exa_rx.ds_exa_rx,
    laudo_rx.cd_prestador_assinatura
ORDER BY
    cd_procedimento_sia
