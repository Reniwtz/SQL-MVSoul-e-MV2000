SELECT * FROM (
    SELECT 
        nm_usuario AS nome_do_usuario,
        COUNT(nm_usuario) AS Quantidade
    FROM 
        ped_rx ped_rx
    WHERE 
        ped_rx.cd_set_exa LIKE '13'
        AND TRUNC(ped_rx.dt_pedido) BETWEEN TO_DATE('01/12/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
    GROUP BY 
        nm_usuario

    UNION ALL

    SELECT 
        'TOTAL' AS nome_do_usuario, 
        SUM(quantidade) AS Quantidade
    FROM (
        SELECT 
            COUNT(nm_usuario) AS quantidade
        FROM 
            ped_rx ped_rx
        WHERE 
            ped_rx.cd_set_exa LIKE '13'
            AND TRUNC(ped_rx.dt_pedido) BETWEEN TO_DATE('01/12/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
        GROUP BY 
            nm_usuario
    )
)
ORDER BY 
    CASE 
        WHEN nome_do_usuario = 'TOTAL' THEN 1 ELSE 0 
    END ASC, 
    Quantidade DESC

-- Produtividade por tipo de especialização médica
SELECT
    ped_rx.cd_ped_rx         AS pedido,
    ped_rx.cd_prestador      AS código_do_prestador,
    ped_rx.nm_prestador      AS nome_do_prestador,
    especialid.ds_especialid AS especialidade,
    ped_rx.cd_atendimento    AS atendimento,
    ped_rx.hr_pedido         AS data_do_pedido,
    ped_rx.nr_controle       AS controle
FROM
         ped_rx ped_rx
    INNER JOIN prestador ON prestador.nm_prestador = ped_rx.nm_prestador
    INNER JOIN esp_med ON esp_med.cd_prestador = prestador.cd_prestador
    INNER JOIN especialid ON especialid.cd_especialid = esp_med.cd_especialid
WHERE
    ped_rx.cd_set_exa LIKE '13'
    AND ped_rx.dt_pedido BETWEEN TO_DATE('01/11/2025', 'DD/MM/YYYY') AND TO_DATE('30/11/2025', 'DD/MM/YYYY')
    AND esp_med.cd_especialid LIKE '56'
GROUP BY
    ped_rx.cd_ped_rx,
    ped_rx.cd_prestador,
    ped_rx.nm_prestador,
    especialid.ds_especialid,
    ped_rx.cd_atendimento,
    ped_rx.hr_pedido,
    ped_rx.nr_controle
