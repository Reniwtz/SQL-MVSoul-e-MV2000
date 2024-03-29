SELECT ALL
    p.cd_paciente,
    p.nm_paciente,
    p.nm_mae,
    p.nr_cpf,
    p.nr_cns,
    p.tp_sexo,
    p.nr_identidade,
    p.ds_om_identidade,
    p.ds_trabalho,
    p.ds_endereco,
    p.nr_endereco,
    p.nm_bairro,
    ci.nm_cidade,
    ci.cd_uf,
    ci.nr_cep_final,
    s.nr_matricula_same,
    a.cd_atendimento,
    a.cd_procedimento,
    fn_idade(dbamv.p.dt_nascimento),
    a.dt_atendimento,
    a.hr_atendimento,
    a.cd_convenio,
    c.nm_convenio,
    pr.nm_prestador,
    a.cd_cid,
    pr.ds_codigo_conselho,
    a.cd_ori_ate,
    o.ds_ori_ate,
    pr.ds_cargo,
    e.cd_especialid,
    e.ds_especialid,
    a.cd_especialid,
    t.ds_tip_mar,
    po.nm_profissao
FROM
    dbamv.paciente  p,
    dbamv.same      s,
    dbamv.atendime  a,
    convenio        c,
    dbamv.prestador pr,
    dbamv.cidade    ci,
    ori_ate         o,
    especialid      e,
    tip_mar         t,
    dbamv.profissao po
WHERE
        s.cd_paciente (+) = p.cd_paciente
    AND a.cd_paciente = p.cd_paciente
    AND p.cd_cidade = ci.cd_cidade
    AND a.cd_convenio = c.cd_convenio
    AND a.cd_atendimento LIKE '3235643'
    AND a.cd_ori_ate = o.cd_ori_ate
    AND a.cd_especialid = e.cd_especialid
    AND a.cd_prestador = pr.cd_prestador
    AND t.cd_tip_mar = a.cd_tip_mar
    AND po.cd_profissao = p.cd_profissao
