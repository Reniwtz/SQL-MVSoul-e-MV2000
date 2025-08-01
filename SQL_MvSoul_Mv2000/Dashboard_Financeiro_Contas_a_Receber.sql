--Particular: Cartão, Dinheiro e Crédito em Conta Corrente
SELECT
    cd_caucao,
    to_char(caucao.dt_caucao, 'dd/mm/yyyy')  AS compentencia,
    decode(caucao.tp_pagamento, 'D', 'DINHEIRO', 'C', 'CARTÃO',
           'E', 'CREDITO_EM_CONTA_CORRENTE') AS tipo_de_recebimento,
    caucao.cd_atendimento                    AS código_do_cliente,
    caucao.nm_proprietario                   AS nome_do_cliente,
    paciente.nr_cpf                          AS cpf,
    to_char(caucao.dt_caucao, 'dd/mm/yyyy')  AS data_do_recebimento,
    caucao.vl_caucao                         AS valor_recebido
FROM
         caucao
    INNER JOIN atendime ON atendime.cd_atendimento = caucao.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
WHERE
    caucao.dt_caucao BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
    cd_caucao,
    to_char(caucao.dt_caucao, 'dd/mm/yyyy'),
    decode(caucao.tp_pagamento, 'D', 'DINHEIRO', 'C', 'CARTÃO',
           'E', 'CREDITO_EM_CONTA_CORRENTE'),
    caucao.nm_proprietario,
    to_char(caucao.dt_caucao, 'dd/mm/yyyy'),
    caucao.vl_caucao,
    paciente.nr_cpf,
    caucao.cd_atendimento
ORDER BY
    data_do_recebimento;
    
--Particular Adiantamento em Caixa: Cartão, Dinheiro e crédito em conta corrente
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')                AS competência,
    decode(reccon_rec.tp_recebimento, '2', 'CARTÃO', '3', 'DINHEIRO',
           '4', 'CREDITO_EM_CONTA_CORRENTE', '', 'DINHEIRO') AS tipo_de_recebimento,
    con_rec.cd_reduzido                                      AS conta_contábil,
    ''                                                       AS código_do_cliente,
    con_rec.nm_cliente                                       AS nome_do_cliente,
    ''                                                       AS cpf_cnpj_do_cliente,
    to_char(con_rec.dt_lancamento, 'dd/mm/yyyy')             AS data_do_recebimento,
    con_rec.vl_previsto                                      AS valor_recebido
FROM
    con_rec
    LEFT JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    LEFT JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
WHERE
    con_rec.dt_emissao BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido LIKE '2915'
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    decode(reccon_rec.tp_recebimento, '2', 'CARTÃO', '3', 'DINHEIRO',
          '4', 'CREDITO_EM_CONTA_CORRENTE', '', 'DINHEIRO'),
    con_rec.cd_reduzido,
    con_rec.nm_cliente,
    to_char(con_rec.dt_lancamento, 'dd/mm/yyyy'),
    con_rec.vl_previsto
ORDER BY
    data_do_recebimento;
    
/*  Total Particular:
    Cartão de Crédito e Débito 
    1302 - PIX  
SELECT
    to_char(caucao.dt_caucao, 'dd/mm/yyyy') AS compentencia,
    caucao.tp_pagamento                     AS tipo_de_recebimento,
    SUM(caucao.vl_caucao)                   AS valor_recebido
FROM
    caucao
WHERE
    caucao.dt_caucao BETWEEN TO_DATE('01/07/2025', 'DD/MM/YYYY') AND TO_DATE('01/07/2025', 'DD/MM/YYYY')
GROUP BY
    caucao.tp_pagamento,
    caucao.dt_caucao
UNION ALL
SELECT
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy') AS compentencia,
    'P'                                       AS tipo_de_recebimento,
    SUM(vl_previsto)                          AS valor
FROM
    con_rec
WHERE
    con_rec.cd_reduzido LIKE '2915'
    AND con_rec.dt_emissao BETWEEN TO_DATE('01/07/2025', 'DD/MM/YYYY') AND TO_DATE('01/07/2025', 'DD/MM/YYYY')
GROUP BY
    'P',
    con_rec.dt_emissao
ORDER BY
    compentencia DESC; */
       
--------------------------------------------------------------------------------
/* Convênios: 
   1302 - UNIMED, 1303 - ASSEFAZ, 1306 - POSTAL SAÚDE
   1307 - CAMED, 1308 - FUNCEF, 1311 - FUNASA, 1313 - AFRAFEP, 1314 - GEAP,
   1315 - CAPESAÚDE, 1316 - AMI SAÚDE, 1317 - PETROBRAS, 1318 - SUL AMÉRICA, 1319 - CASSI,
   1323 - COMSEDER, 1324 - BRADESCO SAÚDE / OPERADORA, 1325 - AMIL, 1326 - MEDSERVICE, 1328 - HAPVIDA,
   1332 - FUSMA, 1333 - GAMA, 1336 - FCA, 1331 - FUSEX, 1322 - CONAB, 1310 - SMILE*/   
SELECT
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
    TO_CHAR(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    CASE
        WHEN con_rec.cd_reduzido = '1302' THEN 'Unimed João Pessoa Cooperativa de Trabalho Médico (UNIMED)'
        WHEN con_rec.cd_reduzido = '1303' THEN 'Fundação Assistencial dos Servidores do Ministério da Fazenda (ASSEFAZ)'
        WHEN con_rec.cd_reduzido = '1306' THEN 'Caixa de Assistência e Saúde dos Empregados dos Correios (POSTAL SAÚDE)'
        WHEN con_rec.cd_reduzido = '1307' THEN 'Caixa de Assistência dos Funcionários do Bnb (CAMED)'
        WHEN con_rec.cd_reduzido = '1308' THEN 'Caixa Econômica Federal (FUNCEF)'
        WHEN con_rec.cd_reduzido = '1310' THEN 'Esmale Assitencia internacional de saúde LTDA (SMILE)'
        WHEN con_rec.cd_reduzido = '1311' THEN 'Funasa Saúde (FUNASA)'
        WHEN con_rec.cd_reduzido = '1313' THEN 'Associação dos Auditores Fiscais do Estado da Paraíba (AFRAFEP)'
        WHEN con_rec.cd_reduzido = '1314' THEN 'Geap Autogestão em Saúde (GEAP)'
        WHEN con_rec.cd_reduzido = '1315' THEN 'Cx. de Prev. e Assist. dos Serv. da Fund. Nac. de Saúde (CAPESAÚDE)'
        WHEN con_rec.cd_reduzido = '1316' THEN 'Amisaude Auto Programa de Saúde Ltda (AMI SAÚDE)'
        WHEN con_rec.cd_reduzido = '1317' THEN 'Associação Petrobras de Saúde - Aps (PETROBRAS)'
        WHEN con_rec.cd_reduzido = '1318' THEN 'Sul América Companhia de Seguro de Saúde (SUL AMÉRICA)'
        WHEN con_rec.cd_reduzido = '1319' THEN 'Caixa de Assistência dos Funcionários do Banco Brasil (CASSI)'
        WHEN con_rec.cd_reduzido = '1322' THEN 'Companhia Nacional de Abastecimento (CONAB)'
        WHEN con_rec.cd_reduzido = '1323' THEN 'Comseder Coop. de Ass. Med. dos Serv. da Suplan e do Der Ltda (COMSEDER)'
        WHEN con_rec.cd_reduzido = '1324' THEN 'Bradesco Saúde / Operadora de Planos S/A'
        WHEN con_rec.cd_reduzido = '1325' THEN 'Amil Assistência Médica (AMIL)'
        WHEN con_rec.cd_reduzido = '1326' THEN 'Mediservice Operadora de Planos de Saúde S.A (MEDSERVICE)'
        WHEN con_rec.cd_reduzido = '1328' THEN 'Hapvida Assistência Médica S.A (HAPVIDA)'
        WHEN con_rec.cd_reduzido = '1331' THEN 'Hospital de Guarnição de João Pessoa (FUSEX)'
        WHEN con_rec.cd_reduzido = '1332' THEN 'União Federal - Comando da Marinha - Capitania dos Portos (FUSMA)'
        WHEN con_rec.cd_reduzido = '1333' THEN 'Gama Saúde Ltda (GAMA)'
        WHEN con_rec.cd_reduzido = '1336' THEN 'Associação Fca Saúde (FCA)'
        ELSE 'Outro'
    END AS nome_do_cliente,
    fornecedor.nr_cgc_cpf                            AS cpf_cnpj_do_cliente,
    TO_CHAR(reccon_rec.dt_recebimento, 'dd/mm/yyyy') AS data_do_recebimento,
    reccon_rec.vl_recebido                           AS valor_recebido
FROM
         con_rec
    INNER JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    INNER JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
    INNER JOIN fornecedor ON fornecedor.cd_fornecedor = con_rec.cd_fornecedor
WHERE
    reccon_rec.dt_recebimento BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('23/07/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido IN ( '1302', '1303', '1306', '1307', '1308',
                                 '1311', '1313', '1314', '1315', '1316',
                                 '1317', '1318', '1319', '1323', '1324',
                                 '1325', '1326', '1328', '1332', '1333',
                                 '1336')
GROUP BY
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
    TO_CHAR(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    fornecedor.nr_cgc_cpf,
    TO_CHAR(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    data_do_recebimento;

/* Convênios Particulares
   1424 - UNIMED CEDAPP 
   1305 - FACENE, HUNE E PREFEITURAS
   1338 - HOSPITAL DE EMERGÊNCIA E TRAUMA
   1346 - ASTRAZENECA*/
SELECT
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    reccon_rec.dt_recebimento BETWEEN TO_DATE('14/02/2025', 'DD/MM/YYYY') AND TO_DATE('14/02/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido IN ( '1424', '1346' )
GROUP BY
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    reccon_rec.cd_reccon_rec,
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
    reccon_rec.dt_recebimento BETWEEN TO_DATE('14/02/2025', 'DD/MM/YYYY') AND TO_DATE('14/02/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido IN ( '1305' )
    AND ( con_rec.nm_cliente LIKE ( '%FACENE%' )
          OR con_rec.nm_cliente LIKE ( '%FUNDAÇÃO JOSÉ LEITE DE SOUZA%' )
          OR con_rec.nm_cliente LIKE ( '%PREF%' ) )
GROUP BY
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    reccon_rec.cd_reccon_rec,
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
    reccon_rec.cd_reccon_rec,
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
--  SUS
SELECT
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')        AS competência,
    con_rec.cd_reduzido                              AS conta_contábil,
    fornecedor.cd_fornecedor                         AS código_do_cliente,
    reccon_rec.ds_reccon_rec                         AS nome_do_cliente,
    CASE
        WHEN reccon_rec.ds_reccon_rec LIKE '%AIH%' THEN
                'autorização AIH'
        WHEN reccon_rec.ds_reccon_rec LIKE '%FAEC%' THEN
            'Fundo de Ações Estratégicas e Compensações(FAEC)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%CINTILOGRAFIA%' THEN
            'Produção Ambulatórial(Citilografia)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%IAC%' THEN
            'Incentivo de Adesão á Contratualização(IAC)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%CONTRASTE%' THEN
            'Produção Ambulatórial(Tomografia com Contraste)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%ANESTESIOLOGIA%' THEN
            'Anestesiologia'
        WHEN reccon_rec.ds_reccon_rec LIKE '%EXTRATETO%' THEN
            'Produção Ambulatórial(Extrateto)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%PET%' THEN
            'Produção Ambulatórial(Pet-scan)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%AMB%' THEN
            'Ambulatorial'
        ELSE
            NULL
    END as nome_do_cliente ,
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
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('30/04/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    reccon_rec.ds_reccon_rec,
    CASE
        WHEN reccon_rec.ds_reccon_rec LIKE '%AIH%' THEN
                'autorização AIH'
        WHEN reccon_rec.ds_reccon_rec LIKE '%FAEC%' THEN
            'Fundo de Ações Estratégicas e Compensações(FAEC)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%CINTILOGRAFIA%' THEN
            'Produção Ambulatórial(Citilografia)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%IAC%' THEN
            'Incentivo de Adesão á Contratualização(IAC)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%CONTRASTE%' THEN
            'Produção Ambulatórial(Tomografia com Contraste)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%ANESTESIOLOGIA%' THEN
            'Anestesiologia'
        WHEN reccon_rec.ds_reccon_rec LIKE '%EXTRATETO%' THEN
            'Produção Ambulatórial(Extrateto)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%PET%' THEN
            'Produção Ambulatórial(Pet-scan)'
        WHEN reccon_rec.ds_reccon_rec LIKE '%AMB%' THEN
            'Ambulatorial'
        ELSE
            NULL
    END,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy');

--------------------------------------------------------------------------------
/*  Aluguéis
    '1433', 'LANCHONETE MARIA JOSÉ', '1428', 'ILANA','1432', 'SAL DA TERRA',
    '1426', 'ALEXANDRE CEDAP', '1425','ANA CEDAP', '1424','CEDAP UNIMED'   */
SELECT
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    con_rec.cd_reduzido IN ( '1433', '1428', '1432', '1426', '1425', '1424' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('28/07/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    reccon_rec.cd_reccon_rec,
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
    reccon_rec.cd_reccon_rec,
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
    1429 - CAMISAS E EVENTOS   */
SELECT
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    con_rec.cd_reduzido IN ( '1429' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    3508 - DOAÇÕES PREFEITURAS - LCTO 143 E SETOR 38,
    3502 - DOAÇÕES CAMPANHAS - LCTO 76 E SETOR 1 */
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
    AND cd_reduzido IN ( '3508', '3502' )
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
    1341 - DOAÇÕES PREFEITURAS,
    1438 - DOAÇOES URNA CAPELA*/
SELECT
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    con_rec.cd_reduzido IN ( '1341', '1438' )
    AND reccon_rec.dt_recebimento BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
GROUP BY
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    con_rec.cd_reduzido,
    fornecedor.cd_fornecedor,
    con_rec.nm_cliente,
    fornecedor.nr_cgc_cpf,
    to_char(reccon_rec.dt_recebimento, 'dd/mm/yyyy'),
    reccon_rec.vl_recebido
ORDER BY
    data_do_recebimento;
    
/*  DOAÇÕES TELEMARKETING 
    1431 - DOAÇÕES MENSAGEIRO  */ 
SELECT
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')                AS competência,
    decode(reccon_rec.tp_recebimento, '2', 'CARTÃO', '3', 'DINHEIRO',
           '4', 'CREDITO_EM_CONTA_CORRENTE', '', 'DINHEIRO') AS tipo_de_recebimento,
    con_rec.cd_reduzido                                      AS conta_contábil,
    ''                                                       AS código_do_cliente,
    con_rec.nm_cliente                                       AS nome_do_cliente,
    ''                                                       AS cpf_cnpj_do_cliente,
    to_char(con_rec.dt_lancamento, 'dd/mm/yyyy')             AS data_do_recebimento,
    con_rec.vl_previsto                                      AS valor_recebido
FROM
    con_rec
    LEFT JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    LEFT JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
WHERE
    con_rec.dt_emissao BETWEEN TO_DATE('01/01/2025', 'DD/MM/YYYY') AND TO_DATE('17/07/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido LIKE '1431'
GROUP BY
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    decode(reccon_rec.tp_recebimento, '2', 'CARTÃO', '3', 'DINHEIRO',
          '4', 'CREDITO_EM_CONTA_CORRENTE', '', 'DINHEIRO'),
    con_rec.cd_reduzido,
    con_rec.nm_cliente,
    to_char(con_rec.dt_lancamento, 'dd/mm/yyyy'),
    con_rec.vl_previsto
ORDER BY
    tipo_de_recebimento;       

-- 3504 - DOAÇÕES TELEMARKETING - LCTO 80 E SETOR 127,   
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
    AND cd_reduzido IN ( '3504' )
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

/*  Doações 
    1439 - DOAÇOES CAIXA*/
SELECT
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy')                AS competência,
    decode(reccon_rec.tp_recebimento, '2', 'CARTÃO', '3', 'DINHEIRO',
           '4', 'CREDITO_EM_CONTA_CORRENTE', '', 'DINHEIRO') AS tipo_de_recebimento,
    con_rec.cd_reduzido                                      AS conta_contábil,
    ''                                                       AS código_do_cliente,
    con_rec.nm_cliente                                       AS nome_do_cliente,
    ''                                                       AS cpf_cnpj_do_cliente,
    to_char(con_rec.dt_lancamento, 'dd/mm/yyyy')             AS data_do_recebimento,
    con_rec.vl_previsto                                      AS valor_recebido
FROM
    con_rec
    LEFT JOIN itcon_rec ON itcon_rec.cd_con_rec = con_rec.cd_con_rec
    LEFT JOIN reccon_rec ON reccon_rec.cd_itcon_rec = itcon_rec.cd_itcon_rec
WHERE
    con_rec.dt_emissao BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND con_rec.cd_reduzido LIKE '1439'
GROUP BY
    con_rec.cd_con_rec,
    to_char(con_rec.dt_emissao, 'dd/mm/yyyy'),
    decode(reccon_rec.tp_recebimento, '2', 'CARTÃO', '3', 'DINHEIRO',
          '4', 'CREDITO_EM_CONTA_CORRENTE', '', 'DINHEIRO'),
    con_rec.cd_reduzido,
    con_rec.nm_cliente,
    to_char(con_rec.dt_lancamento, 'dd/mm/yyyy'),
    con_rec.vl_previsto
ORDER BY
    data_do_recebimento; 
     
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
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/02/2024', 'DD/MM/YYYY') AND TO_DATE('28/02/2025', 'DD/MM/YYYY')
    AND cd_reduzido IN ( '3801' )
    AND mov_concor.cd_lan_concor LIKE '7'
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




--------------------------------------------------------------------------------

/*  Doações 
    3501 - DOAÇÕES GERAIS - LCTO 22 E SETOR 1   */
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
    mov_concor.dt_movimentacao BETWEEN TO_DATE('12/02/2025', 'DD/MM/YYYY') AND TO_DATE('12/02/2025', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '3501' )
    AND mov_concor.cd_lan_concor LIKE '22'
    AND mov_concor.cd_setor LIKE '1'
    AND ( mov_concor.ds_movimentacao LIKE '%GERAIS%'
          OR mov_concor.ds_movimentacao LIKE '%GERAL%'
          OR mov_concor.ds_movimentacao LIKE '%MENOR%' )
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;

/*  Empresas/Orgãos Parceiros
    3504 - DOAÇÕES CORREIOS - LCTO 153 E SETOR 38 
    3507 - DOAÇÕES CAGEPA - LCTO 141 E SETOR 38,*/
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
union all
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
    AND mov_concor.cd_reduzido LIKE ( '3507' )
    AND mov_concor.cd_lan_concor LIKE '141'
    AND mov_concor.cd_setor LIKE '38'
    AND mov_concor.ds_movimentacao LIKE '%CORREIOS%'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao;

--  1312 - ENERGISA PARAIBA  
SELECT
    con_rec.cd_con_rec,
    reccon_rec.cd_reccon_rec,
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
    reccon_rec.cd_reccon_rec,
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
    3504 - DOAÇÕES DA ASSEMBLEIA LEGISLATIVA - LCTO 22 E SETOR 1    */
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
    22931 - ORDEM JUDICIAL - LCTO 121 E SETOR 38  */
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
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
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

--------------------------------------------------------------------------------
/*  SUS
    6909 - ADIANT DA PRODUÇÃO AMB DO SUS - LCTO 146 E SETOR 37  */
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
    AND mov_concor.cd_reduzido LIKE ( '6909' )
    AND mov_concor.cd_lan_concor LIKE '146'
    AND mov_concor.cd_setor LIKE '37'
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
/*  Redimentos de Aplicações
    3602 - RENDIMENTO - LCTO 68 E SETOR 38  */
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
    AND mov_concor.cd_reduzido LIKE ( '3602' )
    AND mov_concor.cd_lan_concor LIKE '68'
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
    
/*  Piso de Enfermagem
    22905 - CONV PISO DA ENFERMAGEM - LCTO 88 E SETOR 192  */
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
    AND mov_concor.cd_reduzido LIKE ( '22905' )
    AND mov_concor.cd_lan_concor LIKE '88'
    AND mov_concor.cd_setor LIKE '192'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;  
    
/*  Convênios Públicos
    8012 - Governo do Estado da Paraíba 006/2025 - LCTO 88 E SETOR 192  */
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
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/06/2024', 'DD/MM/YYYY') AND TO_DATE('01/06/2025', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '8012' )
    AND mov_concor.cd_lan_concor LIKE '88'
    AND mov_concor.cd_setor LIKE '192'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC; 
    
/*  Convênios Públicos
    8009 - CONV 072/2024 - LCTO 88 E SETOR 192  */
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
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/06/2024', 'DD/MM/YYYY') AND TO_DATE('01/06/2025', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '8009' )
    AND mov_concor.cd_lan_concor LIKE '88'
    AND mov_concor.cd_setor LIKE '192'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;
    
/*  Convênios Públicos
    8008 - CONV 059/2024 - LCTO 88 E SETOR 141  */
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
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/06/2024', 'DD/MM/YYYY') AND TO_DATE('01/06/2025', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '8008' )
    AND mov_concor.cd_lan_concor LIKE '88'
    AND mov_concor.cd_setor LIKE '141'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;  
    
/*  Convênios Públicos
    8010 - CONV 087/2024 - LCTO 88 E SETOR 192  */
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
    mov_concor.dt_movimentacao BETWEEN TO_DATE('01/06/2024', 'DD/MM/YYYY') AND TO_DATE('01/06/2025', 'DD/MM/YYYY')
    AND mov_concor.cd_reduzido LIKE ( '8010' )
    AND mov_concor.cd_lan_concor LIKE '88'
    AND mov_concor.cd_setor LIKE '192'
GROUP BY
    mov_concor.cd_mov_concor,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.cd_reduzido,
    mov_concor.ds_movimentacao_padrao,
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy'),
    mov_concor.vl_movimentacao
ORDER BY
    to_char(mov_concor.dt_movimentacao, 'dd/mm/yyyy') DESC;      
