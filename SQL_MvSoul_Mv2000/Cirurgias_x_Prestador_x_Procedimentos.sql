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

-----------------------------------------------------------------------------------------------------------
SELECT
    atendime.cd_atendimento,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    cirurgia.ds_cirurgia,
    aviso_cirurgia.dt_realizacao
FROM
         aviso_cirurgia
    INNER JOIN atendime ON atendime.cd_atendimento = aviso_cirurgia.cd_atendimento
    INNER JOIN cirurgia_aviso ON aviso_cirurgia.cd_aviso_cirurgia = cirurgia_aviso.cd_aviso_cirurgia
    INNER JOIN cirurgia ON cirurgia.cd_cirurgia = cirurgia_aviso.cd_cirurgia
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
        aviso_cirurgia.tp_situacao = 'R'
    AND aviso_cirurgia.cd_cen_cir = '1'
    AND aviso_cirurgia.dt_realizacao >= TO_DATE('01/01/2021', 'DD/MM/YYYY')
    AND aviso_cirurgia.dt_realizacao < TO_DATE('31/12/2026', 'DD/MM/YYYY') + 1
    AND atendime.cd_procedimento IN ( '0416030068', '0416030076', '0416030190', '0416030173', '0416030181',
                                      '0416030211', '0416030220', '0404010172', '0404010180', '0404010199',
                                      '0416030254' )
    AND ( cirurgia.ds_cirurgia LIKE '%MAXI%'
          OR cirurgia.ds_cirurgia LIKE '%PELVI%'
          OR cirurgia.ds_cirurgia LIKE '%LARINGECT%'
          OR cirurgia.ds_cirurgia LIKE '%GLOSS%' )
GROUP BY
    atendime.cd_atendimento,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    cirurgia.ds_cirurgia,
    aviso_cirurgia.dt_realizacao
ORDER BY
    aviso_cirurgia.dt_realizacao,
    atendime.cd_atendimento;
