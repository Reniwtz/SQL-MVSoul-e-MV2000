--Particular
SELECT
    caucao.tp_pagamento   AS tipo_de_recebimento,
    SUM(caucao.vl_caucao) AS valor,
    caucao.dt_caucao      AS compentencia
FROM
    caucao
WHERE
    caucao.dt_caucao BETWEEN TO_DATE('10/06/2025', 'DD/MM/YYYY') AND TO_DATE('10/06/2025', 'DD/MM/YYYY')
GROUP BY
    caucao.tp_pagamento,
    caucao.dt_caucao
UNION ALL
SELECT
    'P'                AS tipo_de_recebimento,
    SUM(vl_previsto)   AS valor,
    con_rec.dt_emissao AS compentencia
FROM
    con_rec
WHERE
    con_rec.cd_reduzido LIKE '2915'
    AND con_rec.dt_emissao BETWEEN TO_DATE('10/06/2025', 'DD/MM/YYYY') AND TO_DATE('10/06/2025', 'DD/MM/YYYY')
GROUP BY
    'P',
    con_rec.dt_emissao;

--------------------------------------------------------------------------------
--Convênio
SELECT
    con_rec.cd_con_rec                               AS id_da_operação,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competencia,
    con_rec.cd_reduzido                              AS conta_contábil,
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
           'UNIMED CEDAPP', 'DESCONHECIDO')          AS convenio,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
WHERE
    reccon_rec.dt_recebimento BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('31/01/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido IN ( '1302', '1303', '1305', '1306', '1307',
                                 '1308', '1311', '1313', '1314', '1315',
                                 '1316', '1317', '1318', '1319', '1323',
                                 '1324', '1325', '1326', '1328', '1332',
                                 '1333', '1336', '1341', '1346', '1424' )
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
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
           'UNIMED CEDAPP', 'DESCONHECIDO'),
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');

--------------------------------------------------------------------------------
--Convênio - escolas superiores
SELECT
    con_rec.cd_con_rec                               AS id_da_operação,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competencia,
    con_rec.cd_reduzido                              AS conta_contábil,
    decode(con_rec.cd_reduzido, '1339', 'FACULDADE DE CIÊNCIAS MÉDICAS', '1343', 'UNIESP',
           '1340', 'FACENE', 'DESCONHECIDO')         AS convenio_escolas_superiores,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
WHERE
    con_rec.cd_reduzido IN ( '1339', '1343', '1340' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('31/01/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    decode(con_rec.cd_reduzido, '1339', 'FACULDADE DE CIÊNCIAS MÉDICAS', '1343', 'UNIESP',
           '1340', 'FACENE', 'DESCONHECIDO'),
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');
    
--------------------------------------------------------------------------------
--SUS
SELECT
    con_rec.cd_con_rec                                                                     AS id_da_operação,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')                                              AS competencia,
    con_rec.cd_reduzido                                                                    AS conta_contábil,
    decode(con_rec.cd_reduzido, '1301', 'FUNDO MUNICIPAL DE SAÚDE DE JPA', 'DESCONHECIDO') AS convenio_escolas_superiores,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy')                                       AS data_do_recebimento,
    reccon_rec.vl_recebido                                                                 AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
WHERE
    con_rec.cd_reduzido IN ( '1301' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    decode(con_rec.cd_reduzido, '1301', 'FUNDO MUNICIPAL DE SAÚDE DE JPA', 'DESCONHECIDO'),
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');

--------------------------------------------------------------------------------
--Aluguéis
SELECT
    con_rec.cd_con_rec                               AS id_da_operação,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competencia,
    con_rec.cd_reduzido                              AS conta_contábil,
    decode(con_rec.cd_reduzido, '1433', 'LANCHONETE MARIA JOSÉ', '1428', 'ILANA',
           '1432', 'SAL DA TERRA', '1426', 'ALEXANDRE CEDAP', '1425',
           'ANA CEDAP', 'DESCONHECIDO')              AS convenio_escolas_superiores,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
WHERE
    con_rec.cd_reduzido IN ( '1433', '1428', '1432', '1426', '1425' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('31/01/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    decode(con_rec.cd_reduzido, '1433', 'LANCHONETE MARIA JOSÉ', '1428', 'ILANA',
           '1432', 'SAL DA TERRA', '1426', 'ALEXANDRE CEDAP', '1425',
           'ANA CEDAP', 'DESCONHECIDO'),
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');

--------------------------------------------------------------------------------
--Camisas e Eventos



--------------------------------------------------------------------------------
--Doações



--------------------------------------------------------------------------------
SELECT
    *
FROM
    reccon_rec
WHERE
    cd_itcon_rec LIKE '138815';


select * from con_rec where cd_con_rec like '138911'
select * from itcon_rec where cd_con_rec like '138911'



SELECT
    *
FROM
    mov_concor
WHERE
    dt_movimentacao BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('10/06/2025', 'DD/MM/YYYY')
order by
    dt_movimentacao desc;
    
select * from controle
