--APAC
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    COUNT(atendime.cd_procedimento)  AS quant_apac_lancado,
    CASE
        WHEN ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) ) < 0 THEN
            0
        ELSE ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) )
    END                                       AS resta,
    TO_CHAR(ROUND((COUNT(atendime.cd_procedimento) / NVL(teto_orcamentario_proced_sus.qt_fisico, 1)) * 100, 2)) || '%'  AS Percentual,
    teto_orcamentario_proced_sus.vl_orcamento AS valor_orçado,
    (teto_orcamentario_proced_sus.vl_orcamento/teto_orcamentario_proced_sus.qt_fisico)* COUNT(atendime.cd_procedimento) AS total_lancado
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
--BPA
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    COUNT(atendime.cd_procedimento)  AS lancado,
    CASE
        WHEN ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) ) < 0 THEN
            0
        ELSE ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) )
    END                                       AS resta,
    TO_CHAR(ROUND((COUNT(atendime.cd_procedimento) / NVL(teto_orcamentario_proced_sus.qt_fisico, 1)) * 100, 2)) || '%'  AS Percentual,
    teto_orcamentario_proced_sus.vl_orcamento AS valor_orçado,
    (teto_orcamentario_proced_sus.vl_orcamento/teto_orcamentario_proced_sus.qt_fisico)* COUNT(atendime.cd_procedimento) AS total_lancado
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

--------------------------------------------------------------------------------
--PROCEDIMENTOS CIRÚRGICOS
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    COUNT(atendime.cd_procedimento)  AS lancado,
    CASE
        WHEN ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) ) < 0 THEN
            0
        ELSE ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) )
    END                                       AS resta,
    TO_CHAR(ROUND((COUNT(atendime.cd_procedimento) / NVL(teto_orcamentario_proced_sus.qt_fisico, 1)) * 100, 2)) || '%'  AS Percentual,
    teto_orcamentario_proced_sus.vl_orcamento AS valor_orçado,
    (teto_orcamentario_proced_sus.vl_orcamento/teto_orcamentario_proced_sus.qt_fisico)* COUNT(atendime.cd_procedimento) AS total_lancado
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

--------------------------------------------------------------------------------
-- BPA
SELECT
    atendime.cd_procedimento  AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    -- Quantitativo por mês (use TO_CHAR para extrair ano e mês no formato 'MM/YYYY')
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '04/2024' THEN 1 END) AS "Abr/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '05/2024' THEN 1 END) AS "Mai/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '06/2024' THEN 1 END) AS "Jun/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '07/2024' THEN 1 END) AS "Jul/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '08/2024' THEN 1 END) AS "Ago/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '09/2024' THEN 1 END) AS "Set/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '10/2024' THEN 1 END) AS "Out/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '11/2024' THEN 1 END) AS "Nov/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '12/2024' THEN 1 END) AS "Dez/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '01/2025' THEN 1 END) AS "Jan/2025",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '02/2025' THEN 1 END) AS "Fev/2025",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '03/2025' THEN 1 END) AS "Mar/2025",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '04/2025' THEN 1 END) AS "Abr/2025"
FROM
         atendime atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.cd_procedimento IN ( '0201010020', '0201010046', '0201010194', '0201010232', '0201010275',
                                  '0201010321', '0201010372', '0201010380', '0201010410', '0201010470',
                                  '0201010518', '0201010526', '0201010542', '0201010569', '0201010631',
                                  '0202010120', '0202010180', '0202010201', '0202010210', '0202010279',
                                  '0202010287', '0202010295', '0202010317', '0202010368', '0202010392',
                                  '0202010414', '0202010422', '0202010430', '0202010465', '0202010473',
                                  '0202010562', '0202010600', '0202010627', '0202010635', '0202010643',
                                  '0202010651', '0202010678', '0202010694', '0202010724', '0202020029',
                                  '0202020096', '0202020134', '0202020142', '0202020150', '0202020380',
                                  '0202020398', '0202020495', '0202030091', '0202030105', '0202030202',
                                  '0202030237', '0202030474', '0202030962', '0202050017', '0202060217',
                                  '0202060373', '0202060390', '0202080013', '0202080080', '0202090051',
                                  '0202090191', '0203010035', '0203010043', '0203020014', '0203020030',
                                  '0203020049', '0203020081', '0204010055', '0204010063', '0204010080',
                                  '0204010144', '0204020034', '0204020069', '0204020093', '0204020107',
                                  '0204030153', '0204030170', '0204040019', '0204040051', '0204040078',
                                  '0204040094', '0204040116', '0204040124', '0204050138', '0204060036',
                                  '0204060060', '0204060095', '0204060109', '0204060117', '0204060125',
                                  '0204060150', '0204060168', '0205010040', '0205020046', '0205020054',
                                  '0205020097', '0205020100', '0205020127', '0205020160', '0205020186',
                                  '0205020070', '0205020194', '0206010010', '0206010028', '0206010036',
                                  '0206010044', '0206010052', '0206010060', '0206010079', '0206020015',
                                  '0206020023', '0206020031', '0206030010', '0206030029', '0206030037',
                                  '0207010013', '0207010021', '0207010030', '0207010048', '0207010056',
                                  '0207010064', '0207010072', '0207020027', '0207020035', '0207030014',
                                  '0207030022', '0207030030', '0207030049', '0208020012', '0208020020',
                                  '0208030026', '0208030042', '0209010029', '0209010037', '0209010053',
                                  '0209040041', '0211020036', '0211070017', '0211070033', '0211070041',
                                  '0211070050', '0211070068', '0211070076', '0211070084', '0211070114',
                                  '0211070149', '0211070157', '0211070203', '0211070211', '0211070262',
                                  '0301010048', '0301010072', '0301060029', '0301060061', '0302020012',
                                  '0302020020', '0302020039', '0303020016', '0401010015', '0404010121',
                                  '0404020097', '0406020205', '0407040196', '0417010060' )
    AND atendime.dt_atendimento BETWEEN TO_DATE('01/04/2024', 'DD/MM/YYYY') AND TO_DATE('30/04/2025', 'DD/MM/YYYY')
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento
ORDER BY
    atendime.cd_procedimento;

-- Código trazendo os zerados
WITH codigos_procedimento AS (
    SELECT '0204030030' AS cd_procedimento FROM dual
    UNION ALL
    SELECT '0204030188' FROM dual
    UNION ALL
    SELECT '0206010095' FROM dual
    UNION ALL
    SELECT '0304090050' FROM dual
    UNION ALL
    SELECT '0304090069' FROM dual
    UNION ALL
    SELECT '0404010121' FROM dual
    )
SELECT
    codigos_procedimento.cd_procedimento,
    procedimento_sus.ds_procedimento,
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '04/2024' THEN 1 END) AS "Abr/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '05/2024' THEN 1 END) AS "Mai/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '06/2024' THEN 1 END) AS "Jun/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '07/2024' THEN 1 END) AS "Jul/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '08/2024' THEN 1 END) AS "Ago/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '09/2024' THEN 1 END) AS "Set/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '10/2024' THEN 1 END) AS "Out/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '11/2024' THEN 1 END) AS "Nov/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '12/2024' THEN 1 END) AS "Dez/2024",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '01/2025' THEN 1 END) AS "Jan/2025",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '02/2025' THEN 1 END) AS "Fev/2025",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '03/2025' THEN 1 END) AS "Mar/2025",
    COUNT(CASE WHEN TO_CHAR(atendime.dt_atendimento, 'MM/YYYY') = '04/2025' THEN 1 END) AS "Abr/2025"
FROM
    codigos_procedimento codigos_procedimento
    LEFT JOIN procedimento_sus ON codigos_procedimento.cd_procedimento = procedimento_sus.cd_procedimento
    LEFT JOIN atendime ON atendime.cd_procedimento = codigos_procedimento.cd_procedimento
        AND atendime.dt_atendimento BETWEEN TO_DATE('01/04/2024', 'DD/MM/YYYY') AND TO_DATE('30/04/2025', 'DD/MM/YYYY')
GROUP BY
    codigos_procedimento.cd_procedimento,
    procedimento_sus.ds_procedimento
ORDER BY
    codigos_procedimento.cd_procedimento;
    cp.cd_procedimento;
