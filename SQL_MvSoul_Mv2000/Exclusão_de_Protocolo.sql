update dbamv.laudo_rx
SET cd_ent_psdi = '',
sn_entregue = 'N'
where cd_laudo = 819936;


update itped_rx
SET dt_entrega = '',
cd_ent_psdi = ''
where cd_laudo = 819936;



DELETE itent_psdi
where cd_laudo = 819936;