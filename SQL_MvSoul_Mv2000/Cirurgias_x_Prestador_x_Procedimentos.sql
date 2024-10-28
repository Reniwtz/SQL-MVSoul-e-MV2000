SELECT
    --cirurgia_aviso.cd_aviso_cirurgia,
    cirurgia.ds_cirurgia
FROM
         aviso_cirurgia aviso_cirurgia
    INNER JOIN cirurgia_aviso ON aviso_cirurgia.cd_aviso_cirurgia = cirurgia_aviso.cd_aviso_cirurgia
    INNER JOIN cirurgia ON cirurgia.cd_cirurgia = cirurgia_aviso.cd_cirurgia
    INNER JOIN prestador_aviso ON aviso_cirurgia.cd_aviso_cirurgia = prestador_aviso.cd_aviso_cirurgia
WHERE
    aviso_cirurgia.tp_situacao LIKE 'R'
    AND dt_cancelamento IS NULL
    AND aviso_cirurgia.dt_realizacao BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
    AND prestador_aviso.nm_prestador LIKE '%MARMO%'
GROUP BY
    cirurgia_aviso.cd_aviso_cirurgia,
    cirurgia.ds_cirurgia
ORDER BY
    ds_cirurgia
