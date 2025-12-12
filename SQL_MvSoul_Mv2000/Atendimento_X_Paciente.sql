SELECT
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
    atendime.cd_atendimento                       AS atendimento,
    unid_int.ds_unid_int                          AS unidade_de_internação,
    leito.ds_resumo                               AS leito,
    paciente.cd_paciente                          AS cadastro,
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
    cd_atendimento LIKE '485798'
GROUP BY
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
    atendime.cd_atendimento,
    unid_int.ds_unid_int,
    leito.ds_resumo,
    paciente.cd_paciente,
    paciente.nr_cns
