SELECT
    'P'
    || '' || lpad(same.nr_matricula_same, 10)
    || '' || rpad(paciente.nm_paciente, 70)
    || '' || rpad(paciente.nm_mae, 70)
    || '' || rpad(
        CASE
            WHEN paciente.tp_sexo = 'M' THEN
                '1'
            WHEN paciente.tp_sexo = 'F' THEN
                '2'
        END, 1)
    || '' || lpad(fn_idade(paciente.dt_nascimento), 3, '0')
    || '' || rpad(to_char(paciente.dt_nascimento, 'dd/mm/yyyy'), 10)
    || '  '|| coalesce(rpad(substr(raca_cor.cd_raca_cns, 2, 1), 1), ' ')
    || ' '|| coalesce(rpad(profissao.cd_profissao, 10), '          ')
    || '' || rpad(cidade.cd_ibge, 6)
    || '' || cidade.nr_digito_ibge
    || '' || '2'
    || '' || coalesce(rpad(paciente.nr_cpf, 19), '                   ')
    || '' || coalesce(rpad(
        CASE
            WHEN paciente.tp_estado_civil = 'S' THEN
                '1'
            WHEN paciente.tp_estado_civil = 'C' THEN
                '2'
            WHEN paciente.tp_estado_civil = 'V' THEN
                '3'
            WHEN paciente.tp_estado_civil = 'D' THEN
                '4'
            WHEN paciente.tp_estado_civil = 'I' THEN
                '5'
            WHEN paciente.tp_estado_civil = 'U' THEN
                '6'
        END, 1), ' ')
    || '' || rpad(paciente.ds_endereco, 80)
    || '' || rpad(paciente.nr_endereco, 20)
    || '' || coalesce(rpad(paciente.ds_complemento, 60), '                                                            ')
    || '' || rpad(paciente.nm_bairro, 40, ' ')
    || '' || rpad(cidade.nm_cidade, 60, ' ')
    || '' || rpad(cidade.cd_uf, 2)
    || '' || coalesce(rpad(paciente.nr_fone, 20), '          VAZIO     ')
    || '' || coalesce(rpad(paciente.nr_cep, 9), '         ')
    || '' || coalesce(rpad(paciente.email, 28), '                            '),
    paciente.nr_cns,
    paciente.dt_nascimento,
    paciente.nr_identidade,
    paciente.ds_om_identidade,
    paciente.ds_trabalho,
    paciente.ds_endereco,
    paciente.nm_bairro,
    cidade.nm_cidade,
    cidade.cd_uf,
    cidade.cd_ibge,
    paciente.nr_cep,
    paciente.cd_uf_emissao_identidade,
    MIN(atendime.cd_cid),
    profissao.cd_profissao,
    paciente.nr_fone,
    same.dt_cadastro
FROM
         paciente
    INNER JOIN same ON same.cd_paciente = paciente.cd_paciente
    INNER JOIN atendime ON atendime.cd_paciente = paciente.cd_paciente
    LEFT JOIN cidade ON paciente.cd_cidade = cidade.cd_cidade
    LEFT JOIN profissao ON profissao.cd_profissao = paciente.cd_profissao
    LEFT JOIN raca_cor ON paciente.tp_cor = raca_cor.tp_cor
WHERE
    paciente.dt_cadastro BETWEEN TO_DATE('01/09/2024', 'DD/MM/YYYY') AND TO_DATE('30/09/2024', 'DD/MM/YYYY')
GROUP BY
    paciente.cd_paciente,
    paciente.nm_paciente,
    paciente.cd_uf_emissao_identidade,
    paciente.nm_mae,
    paciente.nr_cpf,
    paciente.nr_cns,
    paciente.tp_sexo,
    paciente.dt_nascimento,
    raca_cor.cd_raca_cns,
    paciente.tp_estado_civil,
    paciente.nr_identidade,
    paciente.ds_om_identidade,
    paciente.ds_trabalho,
    paciente.ds_endereco,
    paciente.nr_endereco,
    paciente.nm_bairro,
    cidade.nm_cidade,
    cidade.cd_uf,
    cidade.cd_ibge,
    cidade.nr_digito_ibge,
    paciente.nr_cep,
    same.nr_matricula_same,
    fn_idade(paciente.dt_nascimento),
    profissao.cd_profissao,
    paciente.nr_fone,
    same.dt_cadastro,
    paciente.ds_complemento,
    paciente.email
