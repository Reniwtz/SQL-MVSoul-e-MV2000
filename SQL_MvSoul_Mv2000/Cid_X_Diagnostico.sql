SELECT
    apac.cd_paciente,
    paciente.tp_sexo,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12) AS idade,
    paciente.nm_bairro,
    cidade.nm_cidade,
    cidade.cd_uf,
    apac.dt_inicial,
    apac.dt_diagnostico,
    apac.cd_cid_principal
FROM
         apac apac
    INNER JOIN paciente ON paciente.cd_paciente = apac.cd_paciente
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
WHERE
    apac.dt_inicial BETWEEN TO_DATE('01/01/14', 'DD/MM/YY') AND TO_DATE('01/10/24', 'DD/MM/YY')
GROUP BY
    apac.cd_paciente,
    paciente.tp_sexo,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12),
    paciente.nm_bairro,
    cidade.nm_cidade,
    cidade.cd_uf,
    dt_inicial,
    apac.dt_diagnostico,
    apac.cd_cid_principal
ORDER BY
    apac.dt_inicial;
