
-----contrato

SELECT * FROM dbamv.contrato_adiantamento WHERE CD_CONTRATO_ADIANT  = 6

SELECT * FROM dbamv.con_rec WHERE CD_CONTRATO_ADIANT  = 6
 --cd_con_rec = 119703;

SELECT * FROM itcon_rec WHERE  cd_con_rec = 119703;

SELECT * FROM reccon_rec WHERE  CD_ITCON_REC = 119562

----contabiolização
SELECT * FROM lcto_contabil WHERE CD_LCTO_MOVIMENTO   =  16246856




SELECT * FROM lcto_contabil WHERE   CD_LCTO_MOVIMENTO IN( 16246856,16246823) 




---contas a receber do particular - faturamento
SELECT * FROM dbamv.con_rec WHERE CD_ATENDIMENTO  = 3825016         --- RECEBIMENTO PACIENTE MARIA DE FATIMA LIMA DO NASCI

SELECT * FROM itcon_rec WHERE CD_CON_REC =  120088

SELECT * FROM reccon_rec WHERE  CD_ITCON_REC = 119948


***contabilização recebimento DO contrato
SELECT * FROM lcto_contabil WHERE CD_LCTO_MOVIMENTO   = 16246823



                                                                                                                 B                                                                                              


                                                                            RECEBIMENTO DO ATENDIMENTO3821352
