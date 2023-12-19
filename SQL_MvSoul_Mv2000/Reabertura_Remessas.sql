  UPDATE dbamv.remessa_bpa
     SET sn_fechada = 'N' , dt_fechamento = NULL 
   WHERE cd_remessa IN (1799,1800,1803,1804,1805,1806)
