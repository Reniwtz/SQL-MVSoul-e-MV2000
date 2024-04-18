select * from reinf_trans_retorno
where cd_reinf_eventos in (
select cd_reinf_eventos 
FROM reinf_eventos 
where To_Char(dt_competencia, 'mm/yyyy')  = '01/2024' 
and cd_evento = 'R-4020'
)



UPDATE dbamv.reinf_trans_retorno
SET tp_status = 'P'
WHERE cd_reinf_eventos = 160

