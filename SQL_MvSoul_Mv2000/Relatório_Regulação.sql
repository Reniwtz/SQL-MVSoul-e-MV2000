-- Exames Patologicos 
SELECT
    decode(itped_rx.cd_exa_rx, '11', 'Citologia', '9', 'Citologia',
           '39', 'Citologia', '10', 'Citologia', '44',
           'Citologia', '2', 'Congelacao', '107', 'Biopsia',
           '3', 'Mielograma', '226', 'Imuno', '232',
           'Receptores', '236', 'Citologia', '220', 'Imuno',
           '218', 'Citologia', '244', 'Biopsia') ds_exa_rx,
    count(*) Total_de_Exames
FROM
    itped_rx itped_rx,
    ped_rx   ped_rx,
    exa_rx   exa_rx
WHERE
    itped_rx.dt_realizado BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/08/2023', 'DD/MM/YYYY')
    AND ped_rx.cd_set_exa = 13
    AND itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    AND itped_rx.cd_exa_rx = exa_rx.cd_exa_rx
    AND ( ped_rx.cd_convenio LIKE '1'
          OR ped_rx.cd_convenio LIKE '2' )
Group by
    itped_rx.cd_exa_rx
order by
    itped_rx.cd_exa_rx
  

-- Consultas Especializadas   
SELECT
    to_char(atendime.dt_atendimento, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(*) AS consultas_especializadas
FROM
    atendime
WHERE
    dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/08/2023', 'DD/MM/YYYY')
    AND cd_procedimento LIKE '0301010048'
  --AND cd_procedimento LIKE '0301010072'
    AND cd_convenio LIKE '2'
GROUP BY
    to_char(atendime.dt_atendimento, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    TO_DATE(mes_atend, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE');


