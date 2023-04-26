SELECT 
    CASE 
        WHEN eve_siasus.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN eve_siasus.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    SUBSTR(TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH'),0,3) AS Mes_Atend,
    COUNT(qt_lancada) AS CONT_CONV
FROM 
    eve_siasus eve_siasus,
    convenio convenio,
    empresa_convenio
WHERE 
    empresa_convenio.cd_convenio = convenio.cd_convenio
    AND convenio.cd_convenio = '1'
    AND eve_siasus.dt_eve_siasus BETWEEN ( '01/01/2023' ) AND ( '31/03/2023' )
    AND eve_siasus.cd_apac IS NOT NULL
    AND eve_siasus.cd_procedimento LIKE ( '0304%' )
    AND eve_siasus.qt_lancada >= 1
    AND eve_siasus.sn_apac_principal = 'S'
    AND eve_siasus.cd_tip_ate = 29
GROUP BY 
    CASE 
        WHEN eve_siasus.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN eve_siasus.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    SUBSTR(TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH'),0,3),
    convenio.nm_convenio   
ORDER BY 
    Mes_Atend;
 
