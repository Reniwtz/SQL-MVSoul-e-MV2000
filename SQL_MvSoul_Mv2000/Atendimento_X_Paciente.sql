SELECT
    atendime.cd_atendimento                       AS atendimento,
    atendime.dt_atendimento                       AS data_do_atendimento,
    paciente.cd_paciente                          AS código_do_paciente,
    paciente.nm_paciente                          AS nome,
    to_char(paciente.dt_nascimento, 'dd/mm/yyyy') AS data_de_nascimento,
    tipo_sexo.nm_sexo                             AS sexo,
    paciente.ds_endereco
    || ' - '
    || paciente.nr_endereco
    || ' - '
    || paciente.nm_bairro
    || ' - '
    || cidade.nm_cidade
    || ' - '
    || cidade.cd_uf
    || ' - '
    || cidade.nr_cep_final                        AS endereço,
    fn_idade(paciente.dt_nascimento)              AS idade,
    paciente.nm_mae                               AS nome_da_mae,
    same.nr_matricula_same                        AS prontuário,
    unid_int.ds_unid_int                          AS unidade_de_internação,
    leito.ds_resumo                               AS leito,
    paciente.nr_cns                               AS cartão_do_sus
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    LEFT JOIN same ON same.cd_paciente = paciente.cd_paciente
    INNER JOIN cidade ON paciente.cd_cidade = cidade.cd_cidade
    INNER JOIN same ON same.cd_paciente = paciente.cd_paciente
    INNER JOIN tipo_sexo ON tipo_sexo.tp_sexo = paciente.tp_sexo
    LEFT JOIN leito ON leito.cd_leito = atendime.cd_leito
    LEFT JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
WHERE
    atendime.cd_convenio NOT IN ( '1', '2', '16' )
    AND atendime.dt_atendimento >= TO_DATE('01/01/2026', 'DD/MM/YYYY')
    AND atendime.dt_atendimento < TO_DATE('31/01/2026', 'DD/MM/YYYY')+1
GROUP BY
    atendime.cd_atendimento,
    atendime.dt_atendimento,
    paciente.cd_paciente,
    paciente.nm_paciente,
    to_char(paciente.dt_nascimento, 'dd/mm/yyyy'),
    tipo_sexo.nm_sexo,
    paciente.ds_endereco
    || ' - '
    || paciente.nr_endereco
    || ' - '
    || paciente.nm_bairro
    || ' - '
    || cidade.nm_cidade
    || ' - '
    || cidade.cd_uf
    || ' - '
    || cidade.nr_cep_final,
    fn_idade(paciente.dt_nascimento),
    paciente.nm_mae,
    same.nr_matricula_same,
    unid_int.ds_unid_int,
    leito.ds_resumo,
    paciente.nr_cns
ORDER BY
    atendime.cd_convenio,
    paciente.cd_paciente
