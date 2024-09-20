--Atendimentos no Geral
SELECT
    paciente.cd_cidade,
    cid.ds_cid,
    atendime.cd_paciente,
    same.nr_matricula_same,
    paciente.nm_paciente,
    cidade.nm_cidade,
    cidade.cd_uf,
    atendime.cd_procedimento,
    paciente.nr_ddd_fone,
    paciente.nr_fone,
    paciente.nr_ddd_celular,
    paciente.nr_celular
FROM
         atendime atendime
    INNER JOIN cid ON cid.cd_cid = atendime.cd_cid
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    inner join same ON same.cd_paciente = paciente.cd_paciente
    inner join cidade on cidade.cd_cidade = paciente.cd_cidade
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/24', 'DD/MM/YY') AND TO_DATE('20/09/24', 'DD/MM/YY')
    AND ( atendime.cd_cid LIKE 'C54%'
          OR atendime.cd_cid LIKE 'C67%' )
GROUP BY
    paciente.cd_cidade,
    cid.ds_cid,
    atendime.cd_paciente,
    same.nr_matricula_same,
    paciente.nm_paciente,
    cidade.nm_cidade,
    cidade.cd_uf,
    atendime.cd_procedimento,
    paciente.nr_ddd_fone,
    paciente.nr_fone,
    paciente.nr_ddd_celular,
    paciente.nr_celular
ORDER BY
    cid.ds_cid;

--APAC 
SELECT
    paciente.cd_cidade,
    cid.ds_cid,
    paciente.cd_paciente,
    same.nr_matricula_same,
    paciente.nm_paciente,
    cidade.nm_cidade,
    cidade.cd_uf,
    atendime.cd_procedimento,
    paciente.nr_ddd_fone,
    paciente.nr_fone,
    paciente.nr_ddd_celular,
    paciente.nr_celular,
    ds_estadio
FROM
         apac
    INNER JOIN paciente ON paciente.cd_paciente = apac.cd_paciente
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
    INNER JOIN estadio ON estadio.cd_estadio = apac.cd_estadio
    INNER JOIN same ON same.cd_paciente = paciente.cd_paciente
    LEFT JOIN atendime ON atendime.cd_atendimento = apac.cd_atendimento
    LEFT JOIN cid ON cid.cd_cid = apac.cd_cid_principal
WHERE
    dt_inicial BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('04/07/2024', 'DD/MM/YYYY')
    AND ( apac.cd_cid_principal LIKE 'C54%'
          OR apac.cd_cid_principal LIKE 'C67%' )
GROUP BY
    paciente.cd_cidade,
    cid.ds_cid,
    paciente.cd_paciente,
    same.nr_matricula_same,
    paciente.nm_paciente,
    cidade.nm_cidade,
    cidade.cd_uf,
    atendime.cd_procedimento,
    paciente.nr_ddd_fone,
    paciente.nr_fone,
    paciente.nr_ddd_celular,
    paciente.nr_celular,
    ds_estadio
ORDER BY
    paciente.cd_paciente;


