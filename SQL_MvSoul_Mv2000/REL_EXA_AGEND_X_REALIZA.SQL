SELECT
    CASE
        WHEN ped_rx.cd_set_exa IN ( '1' ) THEN 'RAIO-X'
        WHEN ped_rx.cd_set_exa IN ( '2' ) THEN 'MAMOGRAFIA'
        WHEN ped_rx.cd_set_exa IN ( '3' ) THEN 'TOMOGRAFIA'
        WHEN ped_rx.cd_set_exa IN ( '4' ) THEN 'ULTRASONOGRAFIA'
        WHEN ped_rx.cd_set_exa IN ( '6' ) THEN 'ENDOSCOPIA'
        WHEN ped_rx.cd_set_exa IN ( '31' ) THEN 'RESSONANCIA'
        WHEN ped_rx.cd_set_exa IN ( '32' ) THEN 'PET'
        WHEN ped_rx.cd_set_exa IN ( '33' ) THEN 'GAMA'
    END AS EXAMES,
    TO_CHAR(itped_rx.dt_realizado, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(ped_rx.cd_convenio) AS Diagnóstico_por_Imagem
FROM
    itped_rx
    INNER JOIN exa_rx ON itped_rx.cd_exa_rx = exa_rx.cd_exa_rx
    INNER JOIN ped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    INNER JOIN convenio ON ped_rx.cd_convenio = convenio.cd_convenio
WHERE
        itped_rx.dt_realizado BETWEEN TO_DATE('01/11/2023', 'DD/MM/YYYY') AND TO_DATE('30/11/2023', 'DD/MM/YYYY')
    AND (ped_rx.cd_set_exa = 1
         OR ped_rx.cd_set_exa = 2
         OR ped_rx.cd_set_exa = 3
         OR ped_rx.cd_set_exa = 4
         OR ped_rx.cd_set_exa = 6
         OR ped_rx.cd_set_exa = 31
         OR ped_rx.cd_set_exa = 32
         OR ped_rx.cd_set_exa = 33)
GROUP BY
        CASE
            WHEN ped_rx.cd_set_exa IN ( '1' ) THEN 'RAIO-X'
            WHEN ped_rx.cd_set_exa IN ( '2' ) THEN 'MAMOGRAFIA'
            WHEN ped_rx.cd_set_exa IN ( '3' ) THEN 'TOMOGRAFIA'
            WHEN ped_rx.cd_set_exa IN ( '4' ) THEN 'ULTRASONOGRAFIA'
            WHEN ped_rx.cd_set_exa IN ( '6' ) THEN 'ENDOSCOPIA'
            WHEN ped_rx.cd_set_exa IN ( '31' ) THEN 'RESSONANCIA'
            WHEN ped_rx.cd_set_exa IN ( '32' ) THEN 'PET'
            WHEN ped_rx.cd_set_exa IN ( '33' ) THEN 'GAMA'
        END,
        TO_CHAR(itped_rx.dt_realizado, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');  


-------------------------------------------------------------------------------------------------

SELECT
    COUNT(nm_paciente)
FROM
         it_agenda_central it_agenda_central
    INNER JOIN agenda_central ON agenda_central.cd_agenda_central = it_agenda_central.cd_agenda_central
WHERE
    it_agenda_central.cd_item_agendamento LIKE '2'
    AND dt_agenda BETWEEN TO_DATE('11/12/2023', 'DD/MM/YYYY') AND TO_DATE('11/12/2023', 'DD/MM/YYYY')
GROUP BY
    nm_paciente
