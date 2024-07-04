SELECT
    nr_apac               AS número_da_apac,
    dt_inicial            AS inicio_da_apac,
    paciente.cd_paciente  AS cadastro_do_paciente,
    paciente.nm_paciente  AS nome_do_paciente,
    cidade.nm_cidade      AS cidade,
    apac.cd_cid_principal AS cid_principal,
    dt_diagnostico        AS data_do_diagnostico,
    dt_inicio_tratamento  AS inicio_do_tratamento
FROM
         apac
    INNER JOIN paciente ON paciente.cd_paciente = apac.cd_paciente
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
WHERE
    dt_inicial BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('04/07/2024', 'DD/MM/YYYY')
GROUP BY
    nr_apac,
    dt_inicial,
    paciente.cd_paciente,
    paciente.nm_paciente,
    cidade.nm_cidade,
    apac.cd_cid_principal,
    dt_diagnostico,
    dt_inicio_tratamento
ORDER BY
    paciente.cd_paciente
