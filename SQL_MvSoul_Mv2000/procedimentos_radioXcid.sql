SELECT
    eve_siasus.cd_procedimento,
    eve_siasus.qt_lancada,
    cd_cid_principal,
    cd_paciente
FROM
    eve_siasus eve_siasus
WHERE
    eve_siasus.dt_eve_siasus BETWEEN TO_DATE('01/07/2022', 'DD/MM/YYYY') AND TO_DATE('31/07/2023', 'DD/MM/YYYY')
    AND ( eve_siasus.cd_procedimento LIKE '0304010421'
          OR eve_siasus.cd_procedimento LIKE '0304010430'
          OR eve_siasus.cd_procedimento LIKE '0304010340'
          OR eve_siasus.cd_procedimento LIKE '0304010367'
          OR eve_siasus.cd_procedimento LIKE '0304010545'
          OR eve_siasus.cd_procedimento LIKE '0304010421'
          OR eve_siasus.cd_procedimento LIKE '0304010553'
          OR eve_siasus.cd_procedimento LIKE '0304010413'
          OR eve_siasus.cd_procedimento LIKE '0304010529'
          OR eve_siasus.cd_procedimento LIKE '0304010391'
          OR eve_siasus.cd_procedimento LIKE '0304010405'
          OR eve_siasus.cd_procedimento LIKE '0304010537'
          OR eve_siasus.cd_procedimento LIKE '0304010456'
          OR eve_siasus.cd_procedimento LIKE '0304010570'
          OR eve_siasus.cd_procedimento LIKE '0304010502'
          OR eve_siasus.cd_procedimento LIKE '0304010383'
          OR eve_siasus.cd_procedimento LIKE '0304010375'
          OR eve_siasus.cd_procedimento LIKE '0304010472' )
    AND cd_cid_principal LIKE '%C16%'
--GROUP BY
    --eve_siasus.cd_procedimento, eve_siasus.qt_lancada
ORDER BY
    cd_cid_principal

--------------------------------------------------------------------------------

SELECT
    eve_siasus.cd_procedimento,
    eve_siasus.qt_lancada,
    cd_cid_principal
FROM
    eve_siasus eve_siasus
WHERE
    eve_siasus.dt_eve_siasus BETWEEN TO_DATE('01/07/2022', 'DD/MM/YYYY') AND TO_DATE('31/07/2023', 'DD/MM/YYYY')
    AND ( eve_siasus.cd_procedimento LIKE '0304010421'
          OR eve_siasus.cd_procedimento LIKE '0304010430'
          OR eve_siasus.cd_procedimento LIKE '0304010340'
          OR eve_siasus.cd_procedimento LIKE '0304010367'
          OR eve_siasus.cd_procedimento LIKE '0304010545'
          OR eve_siasus.cd_procedimento LIKE '0304010421'
          OR eve_siasus.cd_procedimento LIKE '0304010553'
          OR eve_siasus.cd_procedimento LIKE '0304010413'
          OR eve_siasus.cd_procedimento LIKE '0304010529'
          OR eve_siasus.cd_procedimento LIKE '0304010391'
          OR eve_siasus.cd_procedimento LIKE '0304010405'
          OR eve_siasus.cd_procedimento LIKE '0304010537'
          OR eve_siasus.cd_procedimento LIKE '0304010456'
          OR eve_siasus.cd_procedimento LIKE '0304010570'
          OR eve_siasus.cd_procedimento LIKE '0304010502'
          OR eve_siasus.cd_procedimento LIKE '0304010383'
          OR eve_siasus.cd_procedimento LIKE '0304010375'
          OR eve_siasus.cd_procedimento LIKE '0304010472' )
    AND cd_cid_principal like '%C16%'
--GROUP BY
    --eve_siasus.cd_procedimento, eve_siasus.qt_lancada
ORDER BY
    CD_CID_PRINCIPAL
