SELECT distinct     --|| '' || 
    'P' || '' ||  lpad(s.nr_matricula_same,10)  || '' || rpad(p.nm_paciente,70)  || '' ||  rpad(p.nm_mae,70) || '' || rpad(CASE
        WHEN p.tp_sexo = 'M' THEN '1'
        WHEN p.tp_sexo = 'F' THEN '2'
    END,1) || '' || lpad(fn_idade(dbamv.p.dt_nascimento),3,'0') 
    || '' || rpad(to_char(p.dt_nascimento,'dd/mm/yyyy'),10) || '  ' || COALESCE(rpad(SUBSTR(rc.cd_raca_cns,2,1),1), ' ') || ' ' ||  COALESCE(rpad(po.cd_profissao,10), '          ') || '' || rpad(ci.cd_ibge,6) || '' || ci.nr_digito_ibge || '' || '2' || '' || COALESCE(rpad(p.nr_cpf,19), '                   ') 
    || '' || COALESCE(rpad(CASE
        WHEN p.tp_estado_civil = 'S' THEN '1'
        WHEN p.tp_estado_civil = 'C' THEN '2'
        WHEN p.tp_estado_civil = 'V' THEN '3'
        WHEN p.tp_estado_civil = 'D' THEN '4'
        WHEN p.tp_estado_civil = 'I' THEN '5'
        WHEN p.tp_estado_civil = 'U' THEN '6'
    END,1), ' ') || '' || rpad(p.ds_endereco,80) || '' || rpad(p.nr_endereco,20) || '' || COALESCE(rpad(p.ds_complemento,60), '                                                            ')|| '' || rpad(p.nm_bairro,40,' ') || '' || rpad(ci.nm_cidade,60,' ') || '' || 
    rpad(ci.cd_uf,2) || '' || COALESCE(rpad(p.nr_fone,20), '          VAZIO     ') || '' || COALESCE(rpad(p.nr_cep,9), '         ') || '' || COALESCE(rpad(p.email,28),'                            '),
    p.nr_cns,
    P.dt_nascimento,
    p.nr_identidade,
    p.ds_om_identidade,
    p.ds_trabalho,
    p.ds_endereco,
    p.nm_bairro,
    ci.nm_cidade,
    ci.cd_uf,
    ci.cd_ibge,
    p.nr_cep,
    p.cd_uf_emissao_identidade,
    
    min(a.cd_cid),
    po.cd_profissao,
    p.nr_fone,
    s.dt_cadastro
FROM
    dbamv.paciente  p,
    dbamv.same      s,
    dbamv.atendime  a,
    dbamv.prestador pr,
    dbamv.cidade    ci,
    dbamv.profissao po,
    dbamv.raca_cor  rc
WHERE
        s.cd_paciente         = p.cd_paciente
    AND a.cd_paciente         = p.cd_paciente
    AND p.cd_cidade(+)        = ci.cd_cidade
    AND p.dt_cadastro BETWEEN ('15/09/2023') AND ('20/09/2023')
    AND po.cd_profissao(+)    = p.cd_profissao
    AND p.tp_cor              = rc.tp_cor
group by     
    p.cd_paciente, 
    p.nm_paciente,
    p.cd_uf_emissao_identidade,
    p.nm_mae,
    p.nr_cpf,
    p.nr_cns,
    p.tp_sexo,
    P.dt_nascimento,
    rc.cd_raca_cns,
    p.tp_estado_civil,
    p.nr_identidade,
    p.ds_om_identidade,
    p.ds_trabalho,
    p.ds_endereco,
    p.nr_endereco,
    p.nm_bairro,
    ci.nm_cidade,
    ci.cd_uf,
    ci.cd_ibge,
    ci.nr_digito_ibge,
    p.nr_cep,
    s.nr_matricula_same,
    fn_idade(dbamv.p.dt_nascimento),
    po.cd_profissao,
    p.nr_fone,
    s.dt_cadastro,
    p.ds_complemento,
    p.email
