--Verificar eiste prescrição aberta pelo atendimento
select cd_pre_med, fl_impresso from pre_med where cd_atendimento = 3310580;
--Verificar eiste prescrição aberta pela prescrição
select cd_pre_med, fl_impresso from pre_med where cd_pre_med = 898453;

-- Atualiza a prescrição
update pre_med set fl_impresso = 'S' where cd_pre_med = 898453 ;
commit;

--Verificar Prestador que deixou prescrição aberta
select pm.cd_pre_med Prescricao, pa.nm_paciente Paciente, pr.nm_prestador Prestador
  from pre_med pm, prestador pr, paciente pa , atendime a
 where cd_pre_med = 610644 
   and pm.cd_atendimento = a.cd_atendimento
   and a.cd_paciente  = pa.cd_paciente
   and pm.cd_prestador = pr.cd_prestador
