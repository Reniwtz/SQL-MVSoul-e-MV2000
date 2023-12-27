-- Fisioterapias
select count(a.cd_atendimento)
  from atendime a 
 where dt_atendimento between '01/01/2015' and '31/12/2015'
   and cd_prestador in (458,417,1261,1408,1724,1859,2430,2551,123,104,312,354,361,389)

select sum(qt_lancada) 
  from eve_siasus 
 where cd_prestador in (458,417,1261,1408,1724,1859,2430,2551,123,104,312,354,361,389)
   and dt_eve_siasus between '01/01/2015' and '31/12/2015'
   and cd_convenio NOT in(1,2,16)
   
-- Fisioterapia: Convênios Ambulatório   
select SUM(I.QT_LANCAMENTO) 
  from itreg_amb i, atendime a
 where i.cd_atendimento = a.cd_atendimento
   and a.cd_prestador in (458,417,1261,1408,1724,1859,2430,2551,123,104,312,354,361,389)--,242
   and a.dt_atendimento between '01/01/2015' and '31/12/2015'
   AND 
   -- SELECT * FROM ITREG_AMB
-- Fisioterapia: Convênios Internação
select * --from itreg_fat where dt_lancamento between '01/01/2014' and '31/12/2014' and cd_gru_fat = 6
  from itreg_fat i, atendime a
 where i.cd_atendimento = a.cd_atendimento
   and a.cd_prestador in (458,417,1261,1408,1724,1859,2430,2551,123,104,312,354,361,389)
   and a.dt_atendimento between '01/01/2014' and '31/12/2014'
--select * from gru_fat where cd

-- Fonoaudiologia
select count(a.cd_atendimento)
  from atendime a 
 where dt_atendimento between '01/01/2014' and '31/12/2014'
   and cd_prestador in (416,537,2215)
   
-- Nutricao - Por atendimento
select count(a.cd_atendimento)
  from atendime a 
 where dt_atendimento between '01/01/2015' and '31/12/2015'
   and cd_prestador in (87,138,141,2744,2745)
--
