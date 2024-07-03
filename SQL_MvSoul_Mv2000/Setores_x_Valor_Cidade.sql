--Clínico
SELECT
    atendime.cd_atendimento,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus_valor.vl_total_internacao
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN procedimento_sus_valor ON procedimento_sus_valor.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.tp_atendimento LIKE 'I'
    AND ( paciente.cd_cidade LIKE '2359'
          OR paciente.cd_cidade LIKE '2266'
          OR paciente.cd_cidade LIKE '2285'
          OR paciente.cd_cidade LIKE '2232'
          OR paciente.cd_cidade LIKE '2341'
          OR paciente.cd_cidade LIKE '2492'
          OR paciente.cd_cidade LIKE '2370'
          OR paciente.cd_cidade LIKE '2257'
          OR paciente.cd_cidade LIKE '2201' )
    AND atendime.cd_procedimento LIKE ( '04%' )
    AND atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND procedimento_sus_valor.dt_vigencia BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
GROUP BY
    atendime.cd_atendimento,
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus_valor.vl_total_internacao
ORDER BY
    procedimento_sus.ds_procedimento;


-------------------------------------------------------------------------------------------------------------
--Radioterapia
SELECT
    cd_atendimento,
    eve_siasus.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus_valor.vl_total_ambulatorial
FROM
    eve_siasus eve_siasus
    INNER JOIN paciente ON paciente.cd_paciente = eve_siasus.cd_paciente
    INNER JOIN procedimento_sus ON eve_siasus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN procedimento_sus_valor ON procedimento_sus_valor.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
         eve_siasus.dt_eve_siasus BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND eve_siasus.cd_apac IS NOT NULL
    AND eve_siasus.cd_procedimento LIKE ( '0304%' )
    AND eve_siasus.qt_lancada >= 1
    AND eve_siasus.cd_tip_ate = 28
    AND ( paciente.cd_cidade LIKE '2359'
          OR paciente.cd_cidade LIKE '2266'
          OR paciente.cd_cidade LIKE '2285'
          OR paciente.cd_cidade LIKE '2232'
          OR paciente.cd_cidade LIKE '2341'
          OR paciente.cd_cidade LIKE '2492'
          OR paciente.cd_cidade LIKE '2370'
          OR paciente.cd_cidade LIKE '2257'
          OR paciente.cd_cidade LIKE '2201' )
    AND procedimento_sus_valor.dt_vigencia BETWEEN TO_DATE('01/05/2024', 'DD/MM/YYYY') AND TO_DATE('01/05/2024', 'DD/MM/YYYY')
ORDER BY
     procedimento_sus.ds_procedimento


-------------------------------------------------------------------------------------------------------------
--Quimioterapia
SELECT
    cd_atendimento,
    eve_siasus.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus_valor.vl_total_ambulatorial
FROM
         eve_siasus eve_siasus
    INNER JOIN procedimento_sus ON eve_siasus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN paciente ON paciente.cd_paciente = eve_siasus.cd_paciente
    INNER JOIN procedimento_sus_valor ON procedimento_sus_valor.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    eve_siasus.dt_eve_siasus BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND eve_siasus.cd_apac IS NOT NULL
    AND eve_siasus.qt_lancada >= 1
    AND eve_siasus.sn_apac_principal = 'S'
    AND eve_siasus.cd_tip_ate = 29
    AND NOT ( eve_siasus.cd_procedimento LIKE '0304070017%'
              OR eve_siasus.cd_procedimento LIKE '0304070025%'
              OR eve_siasus.cd_procedimento LIKE '0304070041%'
              OR eve_siasus.cd_procedimento LIKE '0304070050%'
              OR eve_siasus.cd_procedimento LIKE '0304070068%'
              OR eve_siasus.cd_procedimento LIKE '0304070076%'
              OR eve_siasus.cd_procedimento LIKE '0304080012%' )
   AND ( paciente.cd_cidade LIKE '2359'
          OR paciente.cd_cidade LIKE '2266'
          OR paciente.cd_cidade LIKE '2285'
          OR paciente.cd_cidade LIKE '2232'
          OR paciente.cd_cidade LIKE '2341'
          OR paciente.cd_cidade LIKE '2492'
          OR paciente.cd_cidade LIKE '2370'
          OR paciente.cd_cidade LIKE '2257'
          OR paciente.cd_cidade LIKE '2201' )
    AND procedimento_sus_valor.dt_vigencia BETWEEN TO_DATE('01/05/2024', 'DD/MM/YYYY') AND TO_DATE('01/05/2024', 'DD/MM/YYYY')


-------------------------------------------------------------------------------------------------------------
--Exames
SELECT
    atendime.cd_atendimento,
    eve_siasus.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus_valor.vl_total_ambulatorial
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN eve_siasus ON eve_siasus.cd_atendimento = atendime.cd_atendimento
    INNER JOIN procedimento_sus ON eve_siasus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN procedimento_sus_valor ON procedimento_sus_valor.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.tp_atendimento LIKE 'E'
    AND ( paciente.cd_cidade LIKE '2359'
          OR paciente.cd_cidade LIKE '2266'
          OR paciente.cd_cidade LIKE '2285'
          OR paciente.cd_cidade LIKE '2232'
          OR paciente.cd_cidade LIKE '2341'
          OR paciente.cd_cidade LIKE '2492'
          OR paciente.cd_cidade LIKE '2370'
          OR paciente.cd_cidade LIKE '2257'
          OR paciente.cd_cidade LIKE '2201' )
    AND atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND procedimento_sus_valor.dt_vigencia BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY');


-------------------------------------------------------------------------------------------------------------
--Consultas
SELECT
    COUNT(atendime.cd_atendimento)
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
WHERE
    atendime.tp_atendimento LIKE 'A'
    AND ( paciente.cd_cidade LIKE '2359'
          OR paciente.cd_cidade LIKE '2266'
          OR paciente.cd_cidade LIKE '2285'
          OR paciente.cd_cidade LIKE '2232'
          OR paciente.cd_cidade LIKE '2341'
          OR paciente.cd_cidade LIKE '2492'
          OR paciente.cd_cidade LIKE '2370'
          OR paciente.cd_cidade LIKE '2257'
          OR paciente.cd_cidade LIKE '2201' )
    AND atendime.dt_atendimento  BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')


-------------------------------------------------------------------------------------------------------------
--Cirurgias Ambulatoriais
SELECT
    cd_atendimento,
    eve_siasus.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus_valor.vl_total_ambulatorial
FROM
         eve_siasus eve_siasus
    INNER JOIN paciente ON paciente.cd_paciente = eve_siasus.cd_paciente
    INNER JOIN procedimento_sus ON eve_siasus.cd_procedimento = procedimento_sus.cd_procedimento
    INNER JOIN procedimento_sus_valor ON procedimento_sus_valor.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    eve_siasus.dt_eve_siasus BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND eve_siasus.cd_procedimento LIKE ( '04%' )
    AND eve_siasus.qt_lancada >= 1
    AND ( paciente.cd_cidade LIKE '2359'
          OR paciente.cd_cidade LIKE '2266'
          OR paciente.cd_cidade LIKE '2285'
          OR paciente.cd_cidade LIKE '2232'
          OR paciente.cd_cidade LIKE '2341'
          OR paciente.cd_cidade LIKE '2492'
          OR paciente.cd_cidade LIKE '2370'
          OR paciente.cd_cidade LIKE '2257'
          OR paciente.cd_cidade LIKE '2201' )
    AND procedimento_sus_valor.dt_vigencia BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
GROUP BY
    cd_atendimento,
    eve_siasus.cd_procedimento,
    procedimento_sus.ds_procedimento,
    procedimento_sus_valor.vl_total_ambulatorial
ORDER BY
    procedimento_sus.ds_procedimento;
