--Particular: Cartão de Crédito, Débito e PIX
SELECT
    cd_caucao,
    to_char(caucao.dt_caucao, 'dd/mm/yyyy')                    AS compentencia,
    decode(caucao.tp_pagamento, 'D', 'DÉBITO', 'C', 'CRÉDITO') AS tipo_de_recebimento,
    caucao.nm_proprietário as nome_do_cliente,
    to_char(caucao.dt_caucao, 'dd/mm/yyyy')                    AS data_do_recebimento,
    caucao.vl_caucao                                           AS valor_recebido,
    caucao.cd_atendimento as código_do_cliente
FROM
    caucao
WHERE
    caucao.dt_caucao BETWEEN TO_DATE('01/07/2025', 'DD/MM/YYYY') AND TO_DATE('01/07/2025', 'DD/MM/YYYY')
GROUP BY
    cd_caucao,
    to_char(caucao.dt_caucao, 'dd/mm/yyyy'),
    decode(caucao.tp_pagamento, 'D', 'DÉBITO', 'C', 'CARTÃO'),
    caucao.vl_caucao;                       
    
    SELECT * FROM CAUCAO WHERE caucao.dt_caucao BETWEEN TO_DATE('01/07/2025', 'DD/MM/YYYY') AND TO_DATE('01/07/2025', 'DD/MM/YYYY');
    
--Particular: PIX
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
    con_rec
    left JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    left JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    left JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    con_rec.dt_emissao  BETWEEN TO_DATE('01/07/2025', 'DD/MM/YYYY') AND TO_DATE('01/07/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido LIKE '2915'
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
     data_do_recebimento;
     
     
     
     
     SELECT
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy') AS compentencia,
    'P'                                       AS tipo_de_recebimento,
    SUM(vl_previsto)                          AS valor
FROM
    con_rec
WHERE
    con_rec.cd_reduzido LIKE '2915'
    AND con_rec.dt_emissao  BETWEEN TO_DATE('01/07/2025', 'DD/MM/YYYY') AND TO_DATE('01/07/2025', 'DD/MM/YYYY')
GROUP BY
    'P',
    con_rec.dt_emissao
ORDER BY
    compentencia DESC;
       
--------------------------------------------------------------------------------
/* Convênios: 
   1302 - UNIMED, 1303 - ASSEFAZ, 1305 - FACENE BAYEUX / VALENTINA / HUNE, 1306 - POSTAL SAÚDE,
   1307 - CAMED, 1308 - FUNCEF, 1311 - FUNASA, 1313 - AFRAFEP, 1314 - GEAP,
   1315 - CAPESAÚDE, 1316 - AMI SAÚDE, 1317 - PETROBRAS, 1318 - SUL AMÉRICA, 1319 - CASSI,
   1323 - COMSEDER, 1324 - BRADESCO SAÚDE / OPERADORA, 1325 - AMIL, 1326 - MEDSERVICE, 1328 - HAPVIDA,
   1332 - FUSMA, 1333 - GAMA, 1336 - FCA, 1341 - PREFEITURAS, 1346 - ASTRAZENECA, 1424 - UNIMED CEDAPP  */
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido,
     'convênio'                           AS convênio
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido IN ( '1302', '1303', '1306', '1307', '1308',
                                 '1311', '1313', '1314', '1315', '1316',
                                 '1317', '1318', '1319', '1323', '1324',
                                 '1325', '1326', '1328', '1332', '1333',
                                 '1336', '1341', '1346', '1424' )
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
UNION ALL
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido,
    'convênio'                           AS convênio
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido IN ( '1305' )
    AND ( con_rec.nm_cliente LIKE ( '%FACENE%' )
          OR con_rec.nm_cliente LIKE ( '%FUNDAÇÃO JOSÉ LEITE DE SOUZA%' ) )
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    data_do_recebimento;
    
--------------------------------------------------------------------------------
/*  Escola Superiores:
    1339 - FACULDADE DE CIÊNCIAS MÉDICAS, 1343 - UNIESP, 1340 - FACENE/FAMEN    */
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    con_rec.cd_reduzido IN ( '1339', '1343', '1340' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');
    
--------------------------------------------------------------------------------
/*  SUS:
    1301 - JPA FUNDO MUNICIPAL DE SAÚDE */
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido            
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    con_rec.cd_reduzido IN ( '1301' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');

--------------------------------------------------------------------------------
/*  Aluguéis
    '1433', 'LANCHONETE MARIA JOSÉ', '1428', 'ILANA','1432', 'SAL DA TERRA',
    '1426', 'ALEXANDRE CEDAP', '1425','ANA CEDAP'   */
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    con_rec.cd_reduzido IN ( '1433', '1428', '1432', '1426', '1425' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');
 
--------------------------------------------------------------------------------
/*  Estacionamento
    1422 - ESTAPAR  */
    SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    con_rec.cd_reduzido LIKE ( '1422' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');
 
--------------------------------------------------------------------------------
/*  OUTROS
    1429 - CAMISAS E EVENTOS, 1312 - ENERGISA PARAIBA   */
SELECT
     con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    con_rec.cd_reduzido IN ( '1429', '1312' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');

--------------------------------------------------------------------------------
/*  Doações 
    3504 - DOAÇÕES TELEMARKETING - LCTO 80 E SETOR 127,
    3508 - DOAÇÕES PREFEITURAS - LCTO 143 E SETOR 38,
    3507 - DOAÇÕES CAGEPA - LCTO 141 E SETOR 38,
    3502 - DOAÇÕES CAMPANHAS - LCTO 76 E SETOR 1,
    3801 - DOAÇÕES CAIXA - LCTO 7 E SETOR 38    */
SELECT
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS competência,
    mov_concor.cd_reduzido                            AS conta_contábil,
    ''                                                AS código_do_cliente,
    mov_concor.ds_movimentacao_padrao                 AS nome_do_cliente,
    ''                                                AS cpf_cnpj_do_cliente,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS data_do_recebimento,
    mov_concor.vl_movimentacao                        AS valor_recebido
FROM
    mov_concor
WHERE
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND cd_reduzido IN ( '3504', '3508', '3507', '3502', '3801' )
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;
    
/*  Doações 
    1431 - DOAÇÕES TELEMARKETING, 1341 - DOAÇÕES PREFEITURAS  */
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    con_rec.nm_cliente                               AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    con_rec.cd_reduzido IN ( '1431', '1341' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('31/01/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    data_do_recebimento;

--------------------------------------------------------------------------------

/*  Doações 
    3504 - DOAÇÕES GERAIS - LCTO 22 E SETOR 1   */
SELECT
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS competência,
    mov_concor.cd_reduzido                            AS conta_contábil,
    ''                                                AS código_do_cliente,
    mov_concor.ds_movimentacao_padrao                 AS nome_do_cliente,
    ''                                                AS cpf_cnpj_do_cliente,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS data_do_recebimento,
    mov_concor.vl_movimentacao                        AS valor_recebido
FROM
    mov_concor
WHERE
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '3501' )
    AND mov_concor.cd_lan_concor LIKE '22'
    AND mov_concor.cd_setor LIKE '1'
    AND mov_concor.ds_movimentacao LIKE '%GERAIS%'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;

/*  Doações 
    3504 - DOAÇÕES CORREIOS - LCTO 153 E SETOR 38   */
SELECT
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS competência,
    mov_concor.cd_reduzido                            AS conta_contábil,
    ''                                                AS código_do_cliente,
    mov_concor.ds_movimentacao_padrao                 AS nome_do_cliente,
    ''                                                AS cpf_cnpj_do_cliente,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS data_do_recebimento,
    mov_concor.vl_movimentacao                        AS valor_recebido
FROM
    mov_concor
WHERE
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '3501' )
    AND mov_concor.cd_lan_concor LIKE '153'
    AND mov_concor.cd_setor LIKE '38'
    AND mov_concor.ds_movimentacao LIKE '%CORREIOS%'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;

/*  Doações 
    3504 - DOAÇÕES DA ASSEMBLEIA - LCTO 22 E SETOR 1    */
SELECT
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS competência,
    mov_concor.cd_reduzido                            AS conta_contábil,
    ''                                                AS código_do_cliente,
    mov_concor.ds_movimentacao_padrao                 AS nome_do_cliente,
    ''                                                AS cpf_cnpj_do_cliente,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS data_do_recebimento,
    mov_concor.vl_movimentacao                        AS valor_recebido
FROM
    mov_concor
WHERE
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '3501' )
    AND mov_concor.cd_lan_concor LIKE '22'
    AND mov_concor.cd_setor LIKE '1'
    AND mov_concor.ds_movimentacao LIKE '%ASSEMBLE%'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;
    
--------------------------------------------------------------------------------
/*  Ordem Judicial
    3504 - DOAÇÕES DA ASSEMBLEIA - LCTO 121 E SETOR 38    */
SELECT
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS competência,
    mov_concor.cd_reduzido                            AS conta_contábil,
    ''                                                AS código_do_cliente,
    mov_concor.ds_movimentacao_padrao                 AS nome_do_cliente,
    ''                                                AS cpf_cnpj_do_cliente,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') AS data_do_recebimento,
    mov_concor.vl_movimentacao                        AS valor_recebido
FROM
    mov_concor
WHERE
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('10/06/2024', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '22931' )
    AND mov_concor.cd_lan_concor LIKE '121'
    AND mov_concor.cd_setor LIKE '38'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;
