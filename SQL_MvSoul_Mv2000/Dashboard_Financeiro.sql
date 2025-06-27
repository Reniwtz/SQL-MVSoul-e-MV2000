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
    con_rec.dt_emissao                      AS competencia,
    reccon_rec.vl_recebido                  AS valor_recebido,
    con_rec.cd_reduzido,
    decode(con_rec.cd_reduzido, '1302', 'UNIMED', '1303', 'ASSEFAZ',
           '1305', 'FACENE BAYEUX / VALENTINA / HUNE', '1306', 'POSTAL SAÚDE', '1307',
           'CAMED', '1308', 'FUNCEF', '1311', 'FUNASA',
           '1313', 'AFRAFEP', '1314', 'GEAP', '1315',
           'CAPESAÚDE', '1316', 'AMI SAÚDE', '1317', 'PETROBRAS',
           '1318', 'SUL AMÉRICA', '1319', 'CASSI', '1323',
           'COMSEDER', '1324', 'BRADESCO SAÚDE / OPERADORA', '1325', 'AMIL',
           '1326', 'MEDSERVICE', '1328', 'HAPVIDA', '1332',
           'FUSMA', '1333', 'GAMA', '1336', 'FCA',
           '1341', 'PREFEITURAS', '1346', 'ASTRAZENECA', '1424',
           'UNIMED CEDAPP', 'DESCONHECIDO' -- valor default
           ) AS convenio
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
WHERE
    con_rec.cd_con_rec LIKE '138911'
    AND con_rec.cd_reduzido IN ( '1302', '1303', '1305', '1306', '1307',
                                 '1308', '1311', '1313', '1314', '1315',
                                 '1316', '1317', '1318', '1319', '1323',
                                 '1324', '1325', '1326', '1328', '1332',
                                 '1333', '1336', '1341', '1346', '1424' );


select * from reccon_rec where cd_itcon_rec like '138815'

select * from con_rec where cd_con_rec like '138911'
select * from itcon_rec where cd_con_rec like '138911'
