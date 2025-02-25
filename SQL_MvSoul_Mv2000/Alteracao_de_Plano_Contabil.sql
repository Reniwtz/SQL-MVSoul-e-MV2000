SELECT * FROM plano_estr where cd_reduzido = 57
  
SELECT * FROM update dbamv.plano_estr set tp_conta = 'S' where cd_reduzido = 57
  
SELECT * FROM plano_contas where cd_contabil = '4.1.02.02'

  
SELECT Max(cd_reduzido)+1 FROM plano_contas


ALTER SEQUENCE seq_plano_contas  INCREMENT BY 28847;
SELECT seq_plano_contas.NEXTVAL FROM dual;
ALTER SEQUENCE seq_plano_contas INCREMENT BY 1;


SELECT * FROM plano_estr WHERE cd_reduzido = 29007

UPDATE plano_estr SET TP_CONTA  = 'S' WHERE cd_reduzido = 29007

  
update plano_contas
SET tp_natureza = 'D'
WHERE CD_REDUZIDO = 10181

