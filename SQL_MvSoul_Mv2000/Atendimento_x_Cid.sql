SELECT
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid
FROM
         atendime atendime
    INNER JOIN cid ON cid.cd_cid = atendime.cd_cid
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/21', 'DD/MM/YY') AND TO_DATE('31/12/21', 'DD/MM/YY')
    AND ( atendime.cd_cid LIKE 'C01'
          OR atendime.cd_cid LIKE 'C021'
          OR atendime.cd_cid LIKE 'C022'
          OR atendime.cd_cid LIKE 'C023'
          OR atendime.cd_cid LIKE 'C024'
          OR atendime.cd_cid LIKE 'C028'
          OR atendime.cd_cid LIKE 'C029'
          OR atendime.cd_cid LIKE 'C030'
          OR atendime.cd_cid LIKE 'C031'
          OR atendime.cd_cid LIKE 'C039'
          OR atendime.cd_cid LIKE 'C040'
          OR atendime.cd_cid LIKE 'C041'
          OR atendime.cd_cid LIKE 'C048'
          OR atendime.cd_cid LIKE 'C049'
          OR atendime.cd_cid LIKE 'C050'
          OR atendime.cd_cid LIKE 'C051'
          OR atendime.cd_cid LIKE 'C052'
          OR atendime.cd_cid LIKE 'C058'
          OR atendime.cd_cid LIKE 'C059'
          OR atendime.cd_cid LIKE 'C060'
          OR atendime.cd_cid LIKE 'C061'
          OR atendime.cd_cid LIKE 'C062'
          OR atendime.cd_cid LIKE 'C068'
          OR atendime.cd_cid LIKE 'C090'
          OR atendime.cd_cid LIKE 'C091'
          OR atendime.cd_cid LIKE 'C098'
          OR atendime.cd_cid LIKE 'C099'
          OR atendime.cd_cid LIKE 'C100'
          OR atendime.cd_cid LIKE 'C101'
          OR atendime.cd_cid LIKE 'C102'
          OR atendime.cd_cid LIKE 'C103'
          OR atendime.cd_cid LIKE 'C104'
          OR atendime.cd_cid LIKE 'C108'
          OR atendime.cd_cid LIKE 'C109'
          OR atendime.cd_cid LIKE 'C12'
          OR atendime.cd_cid LIKE 'C130'
          OR atendime.cd_cid LIKE 'C131'
          OR atendime.cd_cid LIKE 'C132'
          OR atendime.cd_cid LIKE 'C138'
          OR atendime.cd_cid LIKE 'C139'
          OR atendime.cd_cid LIKE 'C140'
          OR atendime.cd_cid LIKE 'C148'
          OR atendime.cd_cid LIKE 'C320'
          OR atendime.cd_cid LIKE 'C321'
          OR atendime.cd_cid LIKE 'C322'
          OR atendime.cd_cid LIKE 'C323'
          OR atendime.cd_cid LIKE 'C328'
          OR atendime.cd_cid LIKE 'C329'
          OR atendime.cd_cid LIKE 'C760' )
GROUP BY
    atendime.cd_paciente,
    paciente.nm_paciente,
    atendime.cd_cid,
    cid.ds_cid
ORDER BY
    cid.ds_cid
