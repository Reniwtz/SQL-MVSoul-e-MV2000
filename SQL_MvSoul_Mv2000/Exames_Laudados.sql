SELECT    
    COUNT(DISTINCT atendime.cd_atendimento) AS Exames
FROM 
    atendime atendime
    INNER JOIN ped_rx ON atendime.cd_atendimento = ped_rx.cd_atendimento
    INNER JOIN laudo_rx ON ped_rx.cd_ped_rx = laudo_rx.cd_ped_rx
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN itped_rx ON ped_rx.cd_ped_rx = itped_rx.cd_ped_rx
WHERE
        atendime.dt_atendimento BETWEEN ( '01/01/2023' ) AND ( '08/05/2023' )
    AND ped_rx.cd_ped_rx IS NOT NULL
    AND laudo_rx.cd_laudo IS NOT NULL   
GROUP BY 
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio, 
    atendime.cd_procedimento,
    itped_rx.ds_regiao
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
