-- Total de Atendimento no Ambulatório
SELECT
    --p.nm_paciente,
    --a.cd_paciente,
    --a.cd_atendimento,
    --a.dt_atendimento
    COUNT(*) AS total_de_atendimento
FROM
    atendime a
    --paciente p
WHERE
        --a.cd_paciente = p.cd_paciente
    a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND cd_loc_proced LIKE '3'
    AND tp_atendimento LIKE 'A'
    AND ( cd_ori_ate LIKE '12'
          OR cd_ori_ate LIKE '30' )
ORDER BY
    COUNT(*);




-- Total de Procedimentos na Pediatria
SELECT
    COUNT(*) AS total_de_atendimento
FROM
    atendime a
    --paciente p
WHERE
    a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND  cd_ori_ate LIKE '30'
    AND tp_atendimento like 'I'
ORDER BY
    COUNT(*);




-- Total de Atendimento no Ambulatório por Especialista 
SELECT
    --p.nm_paciente,
    --a.cd_paciente,
    --a.cd_atendimento,
    --a.dt_atendimento
    pr.nm_prestador,
    COUNT(*) AS total_de_atendimento
FROM
    atendime  a,
    prestador pr
    --paciente p
WHERE
        --a.cd_paciente = p.cd_paciente
        a.cd_prestador = pr.cd_prestador
    AND a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND cd_loc_proced LIKE '3'
    AND tp_atendimento LIKE 'A'
    AND ( cd_ori_ate LIKE '12'
          OR cd_ori_ate LIKE '30' )
GROUP BY
    nm_prestador
ORDER BY
    COUNT(*);




-- Total de Procedimentos na Pediatria por Especialista 
SELECT
    --p.nm_paciente,
    --a.cd_paciente,
    --a.cd_atendimento,
    --a.dt_atendimento
    pr.nm_prestador,
    COUNT(*) AS total_de_atendimento
FROM
    atendime  a,
    prestador pr
    --paciente p
WHERE
        --a.cd_paciente = p.cd_paciente
        a.cd_prestador = pr.cd_prestador
    AND a.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    AND  cd_ori_ate LIKE '30'
    AND tp_atendimento like 'I'
GROUP BY
    nm_prestador
ORDER BY
    COUNT(*);




--Atendimentos para o kanban da farmácia
SELECT
    atendime.cd_atendimento  AS codigo_do_atendimento,
    ori_ate.ds_ori_ate       AS origem_do_atendimento,
    atendime.cd_paciente     AS codigo_do_paciente,
    paciente.nm_paciente     AS nome_do_paceinte,
    prestador.nm_prestador   AS prestador,
    especialid.ds_especialid AS especialidade
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN esp_med ON atendime.cd_prestador = esp_med.cd_prestador
    INNER JOIN especialid ON esp_med.cd_especialid = especialid.cd_especialid
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
WHERE
    dt_atendimento BETWEEN TO_DATE('07/01/2025', 'DD/MM/YYYY') AND TO_DATE('07/01/2025', 'DD/MM/YYYY')
    AND ( atendime.cd_ser_dis LIKE '22'
          OR atendime.cd_ser_dis LIKE '25'
          OR atendime.cd_ser_dis LIKE '28'
          OR atendime.cd_ser_dis LIKE '40' )
    AND esp_med.sn_especial_principal LIKE 'S'
    AND atendime.tp_atendimento LIKE 'A'
    AND atendime.cd_ori_ate <> '12'
GROUP BY
    atendime.cd_atendimento,
    ori_ate.ds_ori_ate,
    atendime.cd_paciente,
    paciente.nm_paciente,
    prestador.nm_prestador,
    especialid.ds_especialid
ORDER BY
    ori_ate.ds_ori_ate,
    atendime.cd_atendimento;


