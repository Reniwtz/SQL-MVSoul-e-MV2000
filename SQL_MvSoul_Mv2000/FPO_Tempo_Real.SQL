--APAC
SELECT
    atendime.cd_procedimento         AS procedimento,
    COUNT(atendime.cd_procedimento)  AS quant_apac_lancado
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia 
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND atendime.sn_atendimento_apac LIKE 'S'
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;

--------------------------------------------------------------------------------
--BPA ATENDIMENTO
SELECT
    atendime.cd_procedimento         AS procedimento,
    COUNT(atendime.cd_procedimento)  AS lancado
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia 
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/01/2023', 'DD/MM/YYYY')
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/01/2023', 'DD/MM/YYYY')
    AND tp_atendimento <> 'I'
    AND atendime.sn_atendimento_apac LIKE 'N'
    AND sn_retorno LIKE 'N'
    AND (atendime.cd_procedimento <> '204030030' 
        OR atendime.cd_procedimento <> '204030188')
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;
    
        
--BPA FATURA
SELECT
    eve_siasus.cd_procedimento AS cod_procedimento,
    COUNT(*)                   AS lancada
FROM
         eve_siasus eve_siasus
    INNER JOIN fat_sia ON eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    INNER JOIN atendime ON atendime.cd_atendimento = eve_siasus.cd_atendimento
WHERE
        eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/01/2024', 'DD/MM/YYYY')
    AND atendime.dt_atendimento < TO_DATE('2024-01-01', 'YYYY-MM-DD')
    AND tipo_fatura LIKE 'BPA'
    AND ( eve_siasus.cd_procedimento <> '204030030'
          OR eve_siasus.cd_procedimento <> '204030188' )
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento;
    

--BPA PEDIDO 


--------------------------------------------------------------------------------    
--TETO FPO
SELECT
    teto_orcamentario_proced_sus.cd_procedimento AS cod_procedimento,
    procedimento_sus.ds_procedimento             AS descricao,
    teto_orcamentario_proced_sus.qt_fisico       AS acordado
FROM
         teto_orcamentario_proced_sus teto_orcamentario_proced_sus
    INNER JOIN procedimento_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia
WHERE
    dt_periodo_inicial BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('31/01/24', 'DD/MM/YY');
    
--------------------------------------------------------------------------------
--PROCEDIMENTOS CIRÚRGICOS
SELECT
    atendime.cd_procedimento         AS procedimento,
    COUNT(atendime.cd_procedimento)  AS lancado
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = teto_orcamentario_proced_sus.cd_fat_sia 
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND ( atendime.cd_procedimento LIKE '0401010015'
        OR atendime.cd_procedimento LIKE '0404010121'
        OR atendime.cd_procedimento LIKE '0407040196'
        OR atendime.cd_procedimento LIKE '0417010060' )
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento 
ORDER BY
    atendime.cd_procedimento;

-- QUIMIOTERAPIA
SELECT
    atendime.cd_atendimento                                                            AS codigo_do_atendimento,
    atendime.cd_paciente                                                               AS codigo_do_paciente,
    paciente.nm_paciente                                                               AS nome_do_paciente,
    atendime.dt_atendimento                                                            AS data_do_atendimento,
    atendime.cd_procedimento                                                           AS codigo_do_procedimento,
    procedimento_sus.ds_procedimento                                                   AS descricao_do_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico AS valor_unitário
FROM
         atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    LEFT JOIN (
        SELECT
            t1.*
        FROM
            teto_orcamentario_proced_sus t1
        WHERE
            t1.cd_fat_sia = (
                SELECT
                    MAX(cd_fat_sia)
                FROM
                    teto_orcamentario_proced_sus
            )
    ) teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/06/25', 'DD/MM/YY') AND TO_DATE('30/06/25', 'DD/MM/YY')
    AND atendime.cd_loc_proced = '5'
    AND atendime.sn_atendimento_apac = 'S'
    AND atendime.cd_atendimento_pai IS NULL
    AND atendime.cd_procedimento IN ( '0304070025', '0304070041', '0304070050', '0304070068', '0304070076',
                                      '0304080012', '0304080055', '0304080071', '0304090050', '0304090069',
                                      '0304030252', '0304030260', '0304030244', '0304040010', '0304040029',
                                      '0304040045', '0304040053', '0304040061', '0304040070', '0304040088',
                                      '0304040096', '0304040100', '0304040118', '0304040126', '0304040134',
                                      '0304040142', '0304040150', '0304040169', '0304040177', '0304040185',
                                      '0304040193', '0304040207', '0304050016', '0304050024', '0304050032',
                                      '0304050040', '0304050067', '0304050075', '0304050113', '0304050121',
                                      '0304050130', '0304050172', '0304050180', '0304050202', '0304050210',
                                      '0304050229', '0304050253', '0304050261', '0304050270', '0304050288',
                                      '0304050296', '0304050300', '0304050318', '0304050326', '0304050334',
                                      '0304050342', '0304060011', '0304060038', '0304060046', '0304060070',
                                      '0304060089', '0304060097', '0304060100', '0304060119', '0304060127',
                                      '0304060135', '0304060151', '0304060160', '0304060178', '0304060186',
                                      '0304060208', '0304060216', '0304060224', '0304060232', '0304060240',
                                      '0304070017', '0304020079', '0304020010', '0304020028', '0304020036',
                                      '0304020044', '0304020052', '0304020060', '0304020087', '0304020095',
                                      '0304020109', '0304020117', '0304020125', '0304020133', '0304020141',
                                      '0304020150', '0304020168', '0304020176', '0304020184', '0304020192',
                                      '0304020206', '0304020214', '0304020222', '0304020230', '0304020249',
                                      '0304020257', '0304020265', '0304020273', '0304020281', '0304020290',
                                      '0304020303', '0304020311', '0304020320', '0304020338', '0304020346',
                                      '0304020362', '0304020370', '0304020389', '0304020397', '0304020400',
                                      '0304020419', '0304020427', '0304020443', '0304030015', '0304030031',
                                      '0304030040', '0304030058', '0304030066', '0304030074', '0304030082',
                                      '0304030090', '0304030104', '0304030112', '0304030120', '0304030139',
                                      '0304030147', '0304030155', '0304030163', '0304030171', '0304030180',
                                      '0304030198', '0304030201', '0304030210', '0304030228', '0304030236' )
GROUP BY
    atendime.cd_atendimento,
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.dt_atendimento,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico
UNION ALL
SELECT
    atendime.cd_atendimento                                                            AS codigo_do_atendimento,
    atendime.cd_paciente                                                               AS codigo_do_paciente,
    paciente.nm_paciente                                                               AS nome_do_paciente,
    atendime.dt_atendimento                                                            AS data_do_atendimento,
    atendime.cd_procedimento                                                           AS codigo_do_procedimento,
    procedimento_sus.ds_procedimento                                                   AS descricao_do_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico AS valor_unitário
FROM
         atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    LEFT JOIN (
        SELECT
            t1.*
        FROM
            teto_orcamentario_proced_sus t1
        WHERE
            t1.cd_fat_sia = (
                SELECT
                    MAX(cd_fat_sia)
                FROM
                    teto_orcamentario_proced_sus
            )
    ) teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/06/25', 'DD/MM/YY') AND TO_DATE('30/06/25', 'DD/MM/YY')
    AND atendime.cd_loc_proced <> '5'
    AND atendime.sn_atendimento_apac = 'S'
    AND atendime.cd_atendimento_pai IS NULL
    AND atendime.cd_procedimento IN ( '0304070025', '0304070041', '0304070050', '0304070068', '0304070076',
                                      '0304080012', '0304080055', '0304080071', '0304090050', '0304090069',
                                      '0304030252', '0304030260', '0304030244', '0304040010', '0304040029',
                                      '0304040045', '0304040053', '0304040061', '0304040070', '0304040088',
                                      '0304040096', '0304040100', '0304040118', '0304040126', '0304040134',
                                      '0304040142', '0304040150', '0304040169', '0304040177', '0304040185',
                                      '0304040193', '0304040207', '0304050016', '0304050024', '0304050032',
                                      '0304050040', '0304050067', '0304050075', '0304050113', '0304050121',
                                      '0304050130', '0304050172', '0304050180', '0304050202', '0304050210',
                                      '0304050229', '0304050253', '0304050261', '0304050270', '0304050288',
                                      '0304050296', '0304050300', '0304050318', '0304050326', '0304050334',
                                      '0304050342', '0304060011', '0304060038', '0304060046', '0304060070',
                                      '0304060089', '0304060097', '0304060100', '0304060119', '0304060127',
                                      '0304060135', '0304060151', '0304060160', '0304060178', '0304060186',
                                      '0304060208', '0304060216', '0304060224', '0304060232', '0304060240',
                                      '0304070017', '0304020079', '0304020010', '0304020028', '0304020036',
                                      '0304020044', '0304020052', '0304020060', '0304020087', '0304020095',
                                      '0304020109', '0304020117', '0304020125', '0304020133', '0304020141',
                                      '0304020150', '0304020168', '0304020176', '0304020184', '0304020192',
                                      '0304020206', '0304020214', '0304020222', '0304020230', '0304020249',
                                      '0304020257', '0304020265', '0304020273', '0304020281', '0304020290',
                                      '0304020303', '0304020311', '0304020320', '0304020338', '0304020346',
                                      '0304020362', '0304020370', '0304020389', '0304020397', '0304020400',
                                      '0304020419', '0304020427', '0304020443', '0304030015', '0304030031',
                                      '0304030040', '0304030058', '0304030066', '0304030074', '0304030082',
                                      '0304030090', '0304030104', '0304030112', '0304030120', '0304030139',
                                      '0304030147', '0304030155', '0304030163', '0304030171', '0304030180',
                                      '0304030198', '0304030201', '0304030210', '0304030228', '0304030236' )
GROUP BY
    atendime.cd_atendimento,
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.dt_atendimento,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico
UNION ALL
SELECT
    atendime.cd_atendimento                                                            AS codigo_do_atendimento,
    atendime.cd_paciente                                                               AS codigo_do_paciente,
    paciente.nm_paciente                                                               AS nome_do_paciente,
    atendime.dt_atendimento                                                            AS data_do_atendimento,
    atendime.cd_procedimento                                                           AS codigo_do_procedimento,
    procedimento_sus.ds_procedimento                                                   AS descricao_do_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico AS valor_unitário
FROM
         atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    LEFT JOIN (
        SELECT
            t1.*
        FROM
            teto_orcamentario_proced_sus t1
        WHERE
            t1.cd_fat_sia = (
                SELECT
                    MAX(cd_fat_sia)
                FROM
                    teto_orcamentario_proced_sus
            )
    ) teto_orcamentario_proced_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/06/25', 'DD/MM/YY') AND TO_DATE('30/06/25', 'DD/MM/YY')
    AND atendime.cd_loc_proced IS NULL
    AND cd_ser_dis = '76'
    AND atendime.sn_atendimento_apac = 'S'
    AND atendime.cd_atendimento_pai IS NULL
    AND atendime.cd_procedimento IN ( '0304070025', '0304070041', '0304070050', '0304070068', '0304070076',
                                      '0304080012', '0304080055', '0304080071', '0304090050', '0304090069',
                                      '0304030252', '0304030260', '0304030244', '0304040010', '0304040029',
                                      '0304040045', '0304040053', '0304040061', '0304040070', '0304040088',
                                      '0304040096', '0304040100', '0304040118', '0304040126', '0304040134',
                                      '0304040142', '0304040150', '0304040169', '0304040177', '0304040185',
                                      '0304040193', '0304040207', '0304050016', '0304050024', '0304050032',
                                      '0304050040', '0304050067', '0304050075', '0304050113', '0304050121',
                                      '0304050130', '0304050172', '0304050180', '0304050202', '0304050210',
                                      '0304050229', '0304050253', '0304050261', '0304050270', '0304050288',
                                      '0304050296', '0304050300', '0304050318', '0304050326', '0304050334',
                                      '0304050342', '0304060011', '0304060038', '0304060046', '0304060070',
                                      '0304060089', '0304060097', '0304060100', '0304060119', '0304060127',
                                      '0304060135', '0304060151', '0304060160', '0304060178', '0304060186',
                                      '0304060208', '0304060216', '0304060224', '0304060232', '0304060240',
                                      '0304070017', '0304020079', '0304020010', '0304020028', '0304020036',
                                      '0304020044', '0304020052', '0304020060', '0304020087', '0304020095',
                                      '0304020109', '0304020117', '0304020125', '0304020133', '0304020141',
                                      '0304020150', '0304020168', '0304020176', '0304020184', '0304020192',
                                      '0304020206', '0304020214', '0304020222', '0304020230', '0304020249',
                                      '0304020257', '0304020265', '0304020273', '0304020281', '0304020290',
                                      '0304020303', '0304020311', '0304020320', '0304020338', '0304020346',
                                      '0304020362', '0304020370', '0304020389', '0304020397', '0304020400',
                                      '0304020419', '0304020427', '0304020443', '0304030015', '0304030031',
                                      '0304030040', '0304030058', '0304030066', '0304030074', '0304030082',
                                      '0304030090', '0304030104', '0304030112', '0304030120', '0304030139',
                                      '0304030147', '0304030155', '0304030163', '0304030171', '0304030180',
                                      '0304030198', '0304030201', '0304030210', '0304030228', '0304030236' )
GROUP BY
    atendime.cd_atendimento,
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.dt_atendimento,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.vl_orcamento / teto_orcamentario_proced_sus.qt_fisico
ORDER BY
    data_do_atendimento;
