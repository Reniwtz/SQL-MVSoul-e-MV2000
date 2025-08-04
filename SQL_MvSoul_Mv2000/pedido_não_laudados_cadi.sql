SELECT
    ped_rx.cd_ped_rx      AS pedido,
    ped_rx.cd_atendimento AS atendimento,
    ped_rx.hr_pedido      AS data_do_pedido,
    set_exa.nm_set_exa    AS exame
FROM
         ped_rx ped_rx
    INNER JOIN itped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    INNER JOIN atendime ON atendime.cd_atendimento = ped_rx.cd_atendimento
    INNER JOIN set_exa ON set_exa.cd_set_exa = ped_rx.cd_set_exa
WHERE
    ped_rx.hr_pedido BETWEEN TO_DATE('01/07/25', 'DD/MM/YY') AND TO_DATE('31/07/25', 'DD/MM/YY')
    AND itped_rx.cd_laudo IS NULL
    AND atendime.cd_convenio LIKE '1'
    AND ped_rx.cd_set_exa IN ( '4', '27', '31' )
GROUP BY
    ped_rx.cd_ped_rx,
    ped_rx.cd_atendimento,
    ped_rx.hr_pedido,
    set_exa.nm_set_exa
ORDER BY
    set_exa.nm_set_exa
