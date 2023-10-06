select cd_atendimento from eve_siasus
where cd_fat_sia = '487'
and cd_remessa = 1645
and cd_atendimento in (3464319  ,


**** Alterar ****
update eve_siasus set cd_fat_sia = 489 , cd_remessa = 1653
where cd_fat_sia = '487'
and cd_remessa = 1645
and cd_atendimento in (3464319  ,
