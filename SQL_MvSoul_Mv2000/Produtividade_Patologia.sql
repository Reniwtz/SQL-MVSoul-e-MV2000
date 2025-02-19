SELECT * FROM (
    SELECT 
        nm_usuario AS nome_do_usuario,
        COUNT(nm_usuario) AS Quantidade
    FROM 
        ped_rx ped_rx
    WHERE 
        ped_rx.cd_set_exa LIKE '13'
        AND TRUNC(ped_rx.dt_pedido) BETWEEN TRUNC(@INICIAL) AND TRUNC(@FINAL)
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
            AND TRUNC(ped_rx.dt_pedido) BETWEEN TRUNC(@INICIAL) AND TRUNC(@FINAL)
        GROUP BY 
            nm_usuario
    )
)
ORDER BY 
    CASE 
        WHEN nome_do_usuario = 'TOTAL' THEN 1 ELSE 0 
    END ASC, 
    Quantidade DESC
