select * from dbamv.ped_rx
where cd_atendimento ='3753737'



select * from dbamv.itped_rx
where cd_ped_rx in (918224,921750)


select cd_procedimento,cd_fat_sia, cd_remessa from dbamv.eve_siasus
where cd_itped_rx in (975436,971620)


select * from dbamv.procedimento_detalhe_vigencia
where cd_procedimento ='0203020030'
