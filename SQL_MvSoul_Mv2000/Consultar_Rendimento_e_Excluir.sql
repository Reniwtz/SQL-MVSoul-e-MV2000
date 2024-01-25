SELECT
    *
FROM
    mov_concor
WHERE
        dt_movimentacao BETWEEN TO_DATE('01/07/2023', 'DD/MM/YYYY') AND TO_DATE('04/07/2023', 'DD/MM/YYYY')
    AND cd_con_cor = 69;



delete mov_concor
where cd_mov_concor in (2915940, 215941);
