SELECT 
    CASE 
        WHEN cirurgia_aviso.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN cirurgia_aviso.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    SUBSTR(TO_CHAR(aviso_cirurgia.dt_realizacao, 'MONTH'),0,3) AS Mes_Atend,
    COUNT(cirurgia_aviso.cd_convenio) AS CONT_CONV
FROM 
    aviso_cirurgia aviso_cirurgia,
    cirurgia_aviso cirurgia_aviso,
    cirurgia cirurgia,
    convenio convenio,
    empresa_convenio
WHERE 
    empresa_convenio.cd_convenio = convenio.cd_convenio
    AND aviso_cirurgia.tp_situacao = 'R'
    AND aviso_cirurgia.cd_aviso_cirurgia = cirurgia_aviso.cd_aviso_cirurgia
    AND cirurgia_aviso.cd_cirurgia = cirurgia.cd_cirurgia
    AND convenio.cd_convenio = '1'
    AND aviso_cirurgia.cd_cen_cir = '1'
    AND aviso_cirurgia.dt_realizacao BETWEEN ('01/01/2023') AND ('31/03/2023')
GROUP BY 
    CASE 
        WHEN cirurgia_aviso.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN cirurgia_aviso.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    SUBSTR(TO_CHAR(aviso_cirurgia.dt_realizacao, 'MONTH'),0,3),
    convenio.nm_convenio   
ORDER BY 
    Mes_Atend;
