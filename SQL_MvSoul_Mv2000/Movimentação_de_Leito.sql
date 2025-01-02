SELECT
    leito.cd_leito     AS codigo_do_paciente,
    leito.ds_leito     AS nome_do_leito,
    mov_int.hr_mov_int AS horario_da_movimentacao
FROM
         leito leito
    INNER JOIN mov_int ON leito.cd_leito = mov_int.cd_leito
WHERE
    --leito.ds_leito LIKE '%UTI 00%'
    --AND leito.tp_situacao LIKE '%A%'
    mov_int.cd_atendimento LIKE '4041845'
GROUP BY
    leito.cd_leito,
    leito.ds_leito,
    mov_int.hr_mov_int
ORDER BY
    mov_int.hr_mov_int DESC,
    leito.ds_leito;
