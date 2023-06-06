SELECT
    teto_orcamentario_proced_sus.cd_procedimento AS codigo_do_procedimento,
    procedimento_sus.ds_procedimento  AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    teto_orcamentario_proced_sus.vl_orcamento AS valor
FROM
    teto_orcamentario_proced_sus teto_orcamentario_proced_sus
    INNER JOIN fat_sia ON teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia
    INNER JOIN procedimento_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '03/2023'
ORDER BY
    teto_orcamentario_proced_sus.cd_procedimento;

--------------------------------------------------------------------------------

SELECT
    cd_procedimento        cod_procedimento,
    COUNT(cd_procedimento) qt_lancada
FROM
    eve_siasus eve_siasus
    INNER JOIN fat_sia ON eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
WHERE
        to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '03/2023' 
    AND to_char(eve_siasus.dt_eve_siasus, 'mm/yyyy') = '03/2023'
    AND eve_siasus.qt_lancada <> 0
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento;
  
--------------------------------------------------------------------------------    
    
SELECT
    teto_orcamentario_proced_sus.cd_procedimento AS codigo_do_procedimento,
    procedimento_sus.ds_procedimento  AS descricao,
    teto_orcamentario_proced_sus.qt_fisico AS acordado,
    teto_orcamentario_proced_sus.vl_orcamento AS valor,
    COUNT(eve_siasus.cd_procedimento) qt_lancada
FROM
    teto_orcamentario_proced_sus teto_orcamentario_proced_sus
    INNER JOIN fat_sia on teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia
    INNER JOIN procedimento_sus on teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento,
    eve_siasus eve_siasus
WHERE
        to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '03/2023'
    AND to_char(eve_siasus.dt_eve_siasus, 'mm/yyyy') = '03/2023'
    AND eve_siasus.qt_lancada <> 0
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    teto_orcamentario_proced_sus.cd_procedimento,
    eve_siasus.cd_procedimento;
  
  
-------------------------------------------------------------------------

SELECT
    atendime.cd_procedimento                  AS procedimento,
    procedimento_sus.ds_procedimento          AS descricao,
    teto_orcamentario_proced_sus.qt_fisico    AS acordado,
    COUNT(atendime.cd_procedimento)           AS quantidade_feita,
    teto_orcamentario_proced_sus.vl_orcamento AS valor_orçado,
    CASE
        WHEN ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) ) < 0 THEN
            0
        ELSE ( teto_orcamentario_proced_sus.qt_fisico - COUNT(atendime.cd_procedimento) )
    END                                       AS resta,
    CONCAT(ROUND(((COUNT(atendime.cd_procedimento)) / teto_orcamentario_proced_sus.qt_fisico) * 100, 2), '%') AS porcentagem,
    ((teto_orcamentario_proced_sus.vl_orcamento/teto_orcamentario_proced_sus.qt_fisico)* COUNT(atendime.cd_procedimento)) AS total_lançado
FROM
         atendime atendime
    INNER JOIN teto_orcamentario_proced_sus ON atendime.cd_procedimento = teto_orcamentario_proced_sus.cd_procedimento
    INNER JOIN procedimento_sus ON teto_orcamentario_proced_sus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN fat_sia ON teto_orcamentario_proced_sus.cd_fat_sia = fat_sia.cd_fat_sia
WHERE
    atendime.dt_atendimento BETWEEN ( '01/04/2023' ) AND ( '30/04/2023' )
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '04/2023'
    AND atendime.sn_atendimento_apac LIKE 'S'
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    teto_orcamentario_proced_sus.qt_fisico,
    teto_orcamentario_proced_sus.vl_orcamento
ORDER BY
    atendime.cd_procedimento;
    
-----------------------------------------------------------------------

SELECT
    eve_siasus.cd_procedimento        cod_procedimento,
    COUNT(eve_siasus.cd_procedimento) qt_lancada
FROM
    eve_siasus eve_siasus,
    fat_sia    fat_sia
WHERE
        eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '01/2023'
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento;
    
----------------------------------------------------------------------


-- BPA
SELECT
    eve_siasus.cd_procedimento AS cod_procedimento,
    SUM(1)                     AS qt_lancada
FROM
    eve_siasus eve_siasus,
    fat_sia    fat_sia
WHERE
        eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '01/2023'
    AND ( eve_siasus.cd_procedimento LIKE '0201010232'
          OR eve_siasus.cd_procedimento LIKE '0201010410'
          OR eve_siasus.cd_procedimento LIKE '0201010542'
          OR eve_siasus.cd_procedimento LIKE '0202010120'
          OR eve_siasus.cd_procedimento LIKE '0202010180'
          OR eve_siasus.cd_procedimento LIKE '0202010201'
          OR eve_siasus.cd_procedimento LIKE '0202010210'
          OR eve_siasus.cd_procedimento LIKE '0202010228'
          OR eve_siasus.cd_procedimento LIKE '0202010279'
          OR eve_siasus.cd_procedimento LIKE '0202010287'
          OR eve_siasus.cd_procedimento LIKE '0202010295'
          OR eve_siasus.cd_procedimento LIKE '0202010317'
          OR eve_siasus.cd_procedimento LIKE '0202010368'
          OR eve_siasus.cd_procedimento LIKE '0202010392'
          OR eve_siasus.cd_procedimento LIKE '0202010422'
          OR eve_siasus.cd_procedimento LIKE '0202010430'
          OR eve_siasus.cd_procedimento LIKE '0202010465'
          OR eve_siasus.cd_procedimento LIKE '0202010473'
          OR eve_siasus.cd_procedimento LIKE '0202010562'
          OR eve_siasus.cd_procedimento LIKE '0202010600'
          OR eve_siasus.cd_procedimento LIKE '0202010627'
          OR eve_siasus.cd_procedimento LIKE '0202010635'
          OR eve_siasus.cd_procedimento LIKE '0202010643'
          OR eve_siasus.cd_procedimento LIKE '0202010651'
          OR eve_siasus.cd_procedimento LIKE '0202010678'
          OR eve_siasus.cd_procedimento LIKE '0202010694'
          OR eve_siasus.cd_procedimento LIKE '0202010724'
          OR eve_siasus.cd_procedimento LIKE '0202020037'
          OR eve_siasus.cd_procedimento LIKE '0202020070'
          OR eve_siasus.cd_procedimento LIKE '0202020096'
          OR eve_siasus.cd_procedimento LIKE '0202020134'
          OR eve_siasus.cd_procedimento LIKE '0202020142'
          OR eve_siasus.cd_procedimento LIKE '0202020150'
          OR eve_siasus.cd_procedimento LIKE '0202020380'
          OR eve_siasus.cd_procedimento LIKE '0202020495'
          OR eve_siasus.cd_procedimento LIKE '0202030091'
          OR eve_siasus.cd_procedimento LIKE '0202030105'
          OR eve_siasus.cd_procedimento LIKE '0202030202'
          OR eve_siasus.cd_procedimento LIKE '0202030237'
          OR eve_siasus.cd_procedimento LIKE '0202050017'
          OR eve_siasus.cd_procedimento LIKE '0202060217'
          OR eve_siasus.cd_procedimento LIKE '0202060373'
          OR eve_siasus.cd_procedimento LIKE '0202060390'
          OR eve_siasus.cd_procedimento LIKE '0202080080'
          OR eve_siasus.cd_procedimento LIKE '0202090191'
          OR eve_siasus.cd_procedimento LIKE '0203010035'
          OR eve_siasus.cd_procedimento LIKE '0203020014'
          OR eve_siasus.cd_procedimento LIKE '0203020030'
          OR eve_siasus.cd_procedimento LIKE '0203020049'
          OR eve_siasus.cd_procedimento LIKE '0204010055'
          OR eve_siasus.cd_procedimento LIKE '0204010080'
          OR eve_siasus.cd_procedimento LIKE '0204010144'
          OR eve_siasus.cd_procedimento LIKE '0204020069'
          OR eve_siasus.cd_procedimento LIKE '0204020107'
          OR eve_siasus.cd_procedimento LIKE '0204030030'
          OR eve_siasus.cd_procedimento LIKE '0204030153'
          OR eve_siasus.cd_procedimento LIKE '0204030170'
          OR eve_siasus.cd_procedimento LIKE '0204030188'
          OR eve_siasus.cd_procedimento LIKE '0204040051'
          OR eve_siasus.cd_procedimento LIKE '0204040078'
          OR eve_siasus.cd_procedimento LIKE '0204040094'
          OR eve_siasus.cd_procedimento LIKE '0204040116'
          OR eve_siasus.cd_procedimento LIKE '0204050138'
          OR eve_siasus.cd_procedimento LIKE '0204060060'
          OR eve_siasus.cd_procedimento LIKE '0204060095'
          OR eve_siasus.cd_procedimento LIKE '0204060117'
          OR eve_siasus.cd_procedimento LIKE '0204060125'
          OR eve_siasus.cd_procedimento LIKE '0204060150'
          OR eve_siasus.cd_procedimento LIKE '0204060168'
          OR eve_siasus.cd_procedimento LIKE '0205010040'
          OR eve_siasus.cd_procedimento LIKE '0205020046'
          OR eve_siasus.cd_procedimento LIKE '0205020097'
          OR eve_siasus.cd_procedimento LIKE '0205020100'
          OR eve_siasus.cd_procedimento LIKE '0205020127'
          OR eve_siasus.cd_procedimento LIKE '0205020160'
          OR eve_siasus.cd_procedimento LIKE '0205020186'
          OR eve_siasus.cd_procedimento LIKE '0206010010'
          OR eve_siasus.cd_procedimento LIKE '0206010028'
          OR eve_siasus.cd_procedimento LIKE '0206010036'
          OR eve_siasus.cd_procedimento LIKE '0206010044'
          OR eve_siasus.cd_procedimento LIKE '0206010052'
          OR eve_siasus.cd_procedimento LIKE '0206010060'
          OR eve_siasus.cd_procedimento LIKE '0206010079'
          OR eve_siasus.cd_procedimento LIKE '0206020015'
          OR eve_siasus.cd_procedimento LIKE '0206020023'
          OR eve_siasus.cd_procedimento LIKE '0206020031'
          OR eve_siasus.cd_procedimento LIKE '0206030010'
          OR eve_siasus.cd_procedimento LIKE '0206030037'
          OR eve_siasus.cd_procedimento LIKE '0207010013'
          OR eve_siasus.cd_procedimento LIKE '0207010030'
          OR eve_siasus.cd_procedimento LIKE '0207010048'
          OR eve_siasus.cd_procedimento LIKE '0207010056'
          OR eve_siasus.cd_procedimento LIKE '0207010064'
          OR eve_siasus.cd_procedimento LIKE '0207010072'
          OR eve_siasus.cd_procedimento LIKE '0207020027'
          OR eve_siasus.cd_procedimento LIKE '0207020035'
          OR eve_siasus.cd_procedimento LIKE '0207030014'
          OR eve_siasus.cd_procedimento LIKE '0207030022'
          OR eve_siasus.cd_procedimento LIKE '0207030030'
          OR eve_siasus.cd_procedimento LIKE '0207030049'
          OR eve_siasus.cd_procedimento LIKE '0208010025'
          OR eve_siasus.cd_procedimento LIKE '0208010033'
          OR eve_siasus.cd_procedimento LIKE '0208030026'
          OR eve_siasus.cd_procedimento LIKE '0208040056'
          OR eve_siasus.cd_procedimento LIKE '0208050035'
          OR eve_siasus.cd_procedimento LIKE '0209010029'
          OR eve_siasus.cd_procedimento LIKE '0209010037'
          OR eve_siasus.cd_procedimento LIKE '0209010053'
          OR eve_siasus.cd_procedimento LIKE '0211020036'
          OR eve_siasus.cd_procedimento LIKE '0211070017'
          OR eve_siasus.cd_procedimento LIKE '0211070033'
          OR eve_siasus.cd_procedimento LIKE '0211070041'
          OR eve_siasus.cd_procedimento LIKE '0211070076'
          OR eve_siasus.cd_procedimento LIKE '0211070084'
          OR eve_siasus.cd_procedimento LIKE '0211070114'
          OR eve_siasus.cd_procedimento LIKE '0211070157'
          OR eve_siasus.cd_procedimento LIKE '0211070203'
          OR eve_siasus.cd_procedimento LIKE '0211070211'
          OR eve_siasus.cd_procedimento LIKE '0301010048'
          OR eve_siasus.cd_procedimento LIKE '0301010072'
          OR eve_siasus.cd_procedimento LIKE '0301060029'
          OR eve_siasus.cd_procedimento LIKE '0302020039'
          OR eve_siasus.cd_procedimento LIKE '0302040021'
          OR eve_siasus.cd_procedimento LIKE '0303020016'
          OR eve_siasus.cd_procedimento LIKE '0401010015'
          OR eve_siasus.cd_procedimento LIKE '0404010121'
          OR eve_siasus.cd_procedimento LIKE '0404020097'
          OR eve_siasus.cd_procedimento LIKE '0417010060')
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento;
    
 
 -- APAC
SELECT
    eve_siasus.cd_procedimento AS cod_procedimento,
    SUM(1)                     AS qt_lancada
FROM
    eve_siasus eve_siasus,
    fat_sia    fat_sia
WHERE
        eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '01/2023'
    AND ( eve_siasus.cd_procedimento LIKE '0206010095'
          OR eve_siasus.cd_procedimento LIKE '0304010340'
          OR eve_siasus.cd_procedimento LIKE '0304010367'
          OR eve_siasus.cd_procedimento LIKE '0304010375'
          OR eve_siasus.cd_procedimento LIKE '0304010383'
          OR eve_siasus.cd_procedimento LIKE '0304010391'
          OR eve_siasus.cd_procedimento LIKE '0304010405'
          OR eve_siasus.cd_procedimento LIKE '0304010413'
          OR eve_siasus.cd_procedimento LIKE '0304010421'
          OR eve_siasus.cd_procedimento LIKE '0304010430'
          OR eve_siasus.cd_procedimento LIKE '0304010456'
          OR eve_siasus.cd_procedimento LIKE '0304010472'
          OR eve_siasus.cd_procedimento LIKE '0304010502'
          OR eve_siasus.cd_procedimento LIKE '0304010529'
          OR eve_siasus.cd_procedimento LIKE '0304010537'
          OR eve_siasus.cd_procedimento LIKE '0304010545'
          OR eve_siasus.cd_procedimento LIKE '0304010553'
          OR eve_siasus.cd_procedimento LIKE '0304020010'
          OR eve_siasus.cd_procedimento LIKE '0304020028'
          OR eve_siasus.cd_procedimento LIKE '0304020036'
          OR eve_siasus.cd_procedimento LIKE '0304020044'
          OR eve_siasus.cd_procedimento LIKE '0304020052'
          OR eve_siasus.cd_procedimento LIKE '0304020060'
          OR eve_siasus.cd_procedimento LIKE '0304020079'
          OR eve_siasus.cd_procedimento LIKE '0304020087'
          OR eve_siasus.cd_procedimento LIKE '0304020095'
          OR eve_siasus.cd_procedimento LIKE '0304020109'
          OR eve_siasus.cd_procedimento LIKE '0304020117'
          OR eve_siasus.cd_procedimento LIKE '0304020133'
          OR eve_siasus.cd_procedimento LIKE '0304020141'
          OR eve_siasus.cd_procedimento LIKE '0304020176'
          OR eve_siasus.cd_procedimento LIKE '0304020184'
          OR eve_siasus.cd_procedimento LIKE '0304020192'
          OR eve_siasus.cd_procedimento LIKE '0304020206'
          OR eve_siasus.cd_procedimento LIKE '0304020214'
          OR eve_siasus.cd_procedimento LIKE '0304020222'
          OR eve_siasus.cd_procedimento LIKE '0304020230'
          OR eve_siasus.cd_procedimento LIKE '0304020249'
          OR eve_siasus.cd_procedimento LIKE '0304020257'
          OR eve_siasus.cd_procedimento LIKE '0304020265'
          OR eve_siasus.cd_procedimento LIKE '0304020273'
          OR eve_siasus.cd_procedimento LIKE '0304020281'
          OR eve_siasus.cd_procedimento LIKE '0304020290'
          OR eve_siasus.cd_procedimento LIKE '0304020311'
          OR eve_siasus.cd_procedimento LIKE '0304020320'
          OR eve_siasus.cd_procedimento LIKE '0304020338'
          OR eve_siasus.cd_procedimento LIKE '0304020346'
          OR eve_siasus.cd_procedimento LIKE '0304020389'
          OR eve_siasus.cd_procedimento LIKE '0304020419'
          OR eve_siasus.cd_procedimento LIKE '0304020427'
          OR eve_siasus.cd_procedimento LIKE '0304020435'
          OR eve_siasus.cd_procedimento LIKE '0304030031'
          OR eve_siasus.cd_procedimento LIKE '0304030040'
          OR eve_siasus.cd_procedimento LIKE '0304030058'
          OR eve_siasus.cd_procedimento LIKE '0304030066'
          OR eve_siasus.cd_procedimento LIKE '0304030074'
          OR eve_siasus.cd_procedimento LIKE '0304030082'
          OR eve_siasus.cd_procedimento LIKE '0304030090'
          OR eve_siasus.cd_procedimento LIKE '0304030112'
          OR eve_siasus.cd_procedimento LIKE '0304030147'
          OR eve_siasus.cd_procedimento LIKE '0304030163'
          OR eve_siasus.cd_procedimento LIKE '0304030171'
          OR eve_siasus.cd_procedimento LIKE '0304030198'
          OR eve_siasus.cd_procedimento LIKE '0304030210'
          OR eve_siasus.cd_procedimento LIKE '0304030228'
          OR eve_siasus.cd_procedimento LIKE '0304030236'
          OR eve_siasus.cd_procedimento LIKE '0304030252'
          OR eve_siasus.cd_procedimento LIKE '0304030260'
          OR eve_siasus.cd_procedimento LIKE '0304040010'
          OR eve_siasus.cd_procedimento LIKE '0304040029'
          OR eve_siasus.cd_procedimento LIKE '0304040045'
          OR eve_siasus.cd_procedimento LIKE '0304040053'
          OR eve_siasus.cd_procedimento LIKE '0304040061'
          OR eve_siasus.cd_procedimento LIKE '0304040070'
          OR eve_siasus.cd_procedimento LIKE '0304040088'
          OR eve_siasus.cd_procedimento LIKE '0304040096'
          OR eve_siasus.cd_procedimento LIKE '0304040100'
          OR eve_siasus.cd_procedimento LIKE '0304040118'
          OR eve_siasus.cd_procedimento LIKE '0304040126'
          OR eve_siasus.cd_procedimento LIKE '0304040169'
          OR eve_siasus.cd_procedimento LIKE '0304040177'
          OR eve_siasus.cd_procedimento LIKE '0304040185'
          OR eve_siasus.cd_procedimento LIKE '0304040193'
          OR eve_siasus.cd_procedimento LIKE '0304040207'
          OR eve_siasus.cd_procedimento LIKE '0304050016'
          OR eve_siasus.cd_procedimento LIKE '0304050024'
          OR eve_siasus.cd_procedimento LIKE '0304050040'
          OR eve_siasus.cd_procedimento LIKE '0304050067'
          OR eve_siasus.cd_procedimento LIKE '0304050075'
          OR eve_siasus.cd_procedimento LIKE '0304050113'
          OR eve_siasus.cd_procedimento LIKE '0304050121'
          OR eve_siasus.cd_procedimento LIKE '0304050130'
          OR eve_siasus.cd_procedimento LIKE '0304050172'
          OR eve_siasus.cd_procedimento LIKE '0304050202'
          OR eve_siasus.cd_procedimento LIKE '0304050229'
          OR eve_siasus.cd_procedimento LIKE '0304050253'
          OR eve_siasus.cd_procedimento LIKE '0304050270'
          OR eve_siasus.cd_procedimento LIKE '0304050296'
          OR eve_siasus.cd_procedimento LIKE '0304050300'
          OR eve_siasus.cd_procedimento LIKE '0304050318'
          OR eve_siasus.cd_procedimento LIKE '0304050334'
          OR eve_siasus.cd_procedimento LIKE '0304050342'
          OR eve_siasus.cd_procedimento LIKE '0304060011'
          OR eve_siasus.cd_procedimento LIKE '0304060038'
          OR eve_siasus.cd_procedimento LIKE '0304060070'
          OR eve_siasus.cd_procedimento LIKE '0304060089'
          OR eve_siasus.cd_procedimento LIKE '0304060119'
          OR eve_siasus.cd_procedimento LIKE '0304060135'
          OR eve_siasus.cd_procedimento LIKE '0304060178'
          OR eve_siasus.cd_procedimento LIKE '0304060186'
          OR eve_siasus.cd_procedimento LIKE '0304060208'
          OR eve_siasus.cd_procedimento LIKE '0304060224'
          OR eve_siasus.cd_procedimento LIKE '0304060232'
          OR eve_siasus.cd_procedimento LIKE '0304060240'
          OR eve_siasus.cd_procedimento LIKE '0304070017'
          OR eve_siasus.cd_procedimento LIKE '0304070025'
          OR eve_siasus.cd_procedimento LIKE '0304070068'
          OR eve_siasus.cd_procedimento LIKE '0304070076'
          OR eve_siasus.cd_procedimento LIKE '0304080012'
          OR eve_siasus.cd_procedimento LIKE '0304080071'
          OR eve_siasus.cd_procedimento LIKE '0404010121' )
GROUP BY
    eve_siasus.cd_procedimento
    
    
------------------------------------------------------------

SELECT
    eve_siasus.cd_procedimento AS cod_procedimento,
    SUM(1)                     AS qt_lancada
FROM
    eve_siasus eve_siasus,
    fat_sia    fat_sia
WHERE
        eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    AND to_char(fat_sia.dt_periodo_inicial, 'MM/YYYY') = '01/2023'
    AND tipo_fatura like 'BPA'
    --AND tipo_fatura like 'SISM'
    --AND tipo_fatura like 'APAC'
GROUP BY
    eve_siasus.cd_procedimento
ORDER BY
    eve_siasus.cd_procedimento; 
