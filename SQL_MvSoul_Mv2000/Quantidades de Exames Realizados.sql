-- Quantidade de Exames Laboratoriais(ou qualquer outro) - SUS - Ambulatório
select sum(qt_lancada) --count(cd_eventos) 
  from eve_siasus
 where dt_eve_siasus between ('01/01/2014') and ('31/12/2014')
   and cd_procedimento like '0302%'

-- Quantidade de Exames Laboratoriais - SUS - Internação
select sum(qt_lancamento)
  from itreg_fat
 where dt_lancamento between ('01/01/2014') and ('31/12/2014')
--   and nr_guia is not null
   and cd_procedimento like '0302%'
   order by cd_reg_fat

-- Quantidade de Exames Laboratoriais - SUS - Ambulatório(REFERENCIA DATA DO ATENDIMENTO)
select sum(e.qt_lancada) --count(cd_eventos) 
  from eve_siasus e, atendime a
 where e.cd_atendimento = a.cd_atendimento
   and a.dt_atendimento between ('01/01/2014') and ('31/12/2014')
   and e.cd_procedimento like '0202%'
   and

-- Quantidade de Exames Laboratoriais - SUS - Internação(REFERENCIA DATA DO ATENDIMENTO)
select sum(qt_lancamento)
  from itreg_fat i, reg_fat r, atendime a
 where i.cd_reg_fat = r.cd_reg_fat
   and r.cd_atendimento = a.cd_atendimento
   and a.dt_atendimento between ('01/01/2014') and ('31/12/2014')
   and r.nr_guia is not null
   and i.cd_procedimento like '0202%'
