SELECT 
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    SUBSTR(TO_CHAR(atendime.dt_atendimento, 'MONTH'),0,3) AS Mes_Atend,
    COUNT(atendime.cd_convenio) AS CONT_CONV
FROM 
    atendime atendime,
    convenio convenio,
    empresa_convenio
WHERE 
    empresa_convenio.cd_convenio = convenio.cd_convenio
    AND convenio.cd_convenio = '1'
    AND atendime.tp_atendimento = 'A'
    AND atendime.dt_atendimento BETWEEN ( '01/01/2023' ) AND ( '31/03/2023' )
GROUP BY 
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    SUBSTR(TO_CHAR(atendime.dt_atendimento, 'MONTH'),0,3),
    convenio.nm_convenio   
ORDER BY 
    Mes_Atend;
