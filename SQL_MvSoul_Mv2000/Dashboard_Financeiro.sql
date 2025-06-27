--Particular
SELECT
    caucao.tp_pagamento   AS tipo_de_recebimento,
    SUM(caucao.vl_caucao) AS valor
FROM
    caucao
WHERE
    caucao.dt_caucao BETWEEN TO_DATE('10/06/2025', 'DD/MM/YYYY') AND TO_DATE('10/06/2025', 'DD/MM/YYYY')
GROUP BY
    caucao.tp_pagamento
UNION ALL
SELECT
    'P'              AS tipo_de_recebimento,
    SUM(vl_previsto) AS valor
FROM
    con_rec
WHERE
    cd_reduzido LIKE '2915'
    AND dt_emissao BETWEEN TO_DATE('10/06/2025', 'DD/MM/YYYY') AND TO_DATE('10/06/2025', 'DD/MM/YYYY');



--Convênio
SELECT
    *
FROM
    con_rec con_rec
WHERE
    cd_reduzido IN ( '1302', '1303', '1305', '1306', '1307',
                     '1308', '1311', '1313', '1314', '1315',
                     '1316', '1317', '1318', '1319', '1323',
                     '1324', '1325', '1326', '1328', '1332',
                     '1333', '1336', '1341', '1346', '1424' )


select * from reccon_rec where cd_itcon_rec like '138815'

select * from con_rec where cd_con_rec like '138911'
select * from itcon_rec where cd_con_rec like '138911'
