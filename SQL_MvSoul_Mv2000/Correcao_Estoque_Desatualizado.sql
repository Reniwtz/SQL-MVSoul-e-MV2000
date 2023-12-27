
-- Correção de Saldos de Produtos Normais, Mestres e Consignados.

-- Esse script deve ser executado com o usuário DBAMV.
-- Deve ser verificado se todas as estapas foram concluídas com sucesso.
-- A previsão é em média 5 seg a 20 minutos a depender do legado.
-- Durante a execussão todo processo de Estoque devem ficar parados.
-- Caso o script pare antes do fim deve ser executada a parte final que reabilitas as triggers.
-- Ao termino do scpripte verificar se todas as etapas foram concluídas.


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE dbamv.script_saldo_produto';
EXCEPTION WHEN OTHERS THEN
    NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE
    'CREATE TABLE dbamv.script_saldo_produto(cd_multi_empresa NUMBER,
                                            cd_produto        NUMBER,
                                            cd_mestre         NUMBER,
                                            dh_inicio         DATE,
                                            dh_fim            DATE,
                                            ds_erro           VARCHAR2(4000),
                                            sn_mestre         VARCHAR2(1),
                                            sn_consignado     VARCHAR2(1),
                                            sn_corrige_itmvto VARCHAR2(1),
                                            sn_corrige_consig VARCHAR2(1),
                                            sn_corrige_mestre VARCHAR2(1),
                                            sn_corrige_lote   VARCHAR2(1),
                                            cd_estoque        NUMBER)';
EXCEPTION WHEN OTHERS THEN
    NULL;
END;

/
BEGIN
  EXECUTE IMMEDIATE ('CREATE OR REPLACE TRIGGER DBAMV.TRG_MGES_DESATIVA_DEV_FOR
											 BEFORE UPDATE OR INSERT OR DELETE
											 ON dbamv.dev_for
											 REFERENCING OLD AS OLD NEW AS NEW
											 FOR EACH ROW
											BEGIN
												If MGES_TEMP_LEGADO.vScript Then
										      Return;
										    End If;
											  Raise_Application_Error(-20000, ''Sistema parado para manutenção.'');
											END;');

  EXECUTE IMMEDIATE ('CREATE OR REPLACE TRIGGER DBAMV.TRG_MGES_DESATIVA_ENTRADA
											 BEFORE UPDATE OR INSERT OR DELETE
											 ON dbamv.ent_pro
											 REFERENCING OLD AS OLD NEW AS NEW
											 FOR EACH ROW
											BEGIN
												If MGES_TEMP_LEGADO.vScript Then
										      Return;
										    End If;
											  Raise_Application_Error(-20000, ''Sistema parado para manutenção.'');
											END;');

	EXECUTE IMMEDIATE ('CREATE OR REPLACE TRIGGER DBAMV.TRG_MGES_DESATIVA_CONCL
											 BEFORE UPDATE OR INSERT OR DELETE
											 ON dbamv.ent_pro_conclusao
											 REFERENCING OLD AS OLD NEW AS NEW
											 FOR EACH ROW
											BEGIN
											  Raise_Application_Error(-20000, ''Sistema parado para manutenção.'');
											END;');

	EXECUTE IMMEDIATE ('CREATE OR REPLACE TRIGGER DBAMV.TRG_MGES_DESATIVA_CONTAGEM
											 BEFORE UPDATE OR INSERT OR DELETE
											 ON dbamv.contagem
											 REFERENCING OLD AS OLD NEW AS NEW
											 FOR EACH ROW
											BEGIN
												If MGES_TEMP_LEGADO.vScript Then
										      Return;
										    End If;
											  Raise_Application_Error(-20000, ''Sistema parado para manutenção.'');
											END;');

	EXECUTE IMMEDIATE ('CREATE OR REPLACE TRIGGER DBAMV.TRG_MGES_DESATIVA_ITCONTAGEM
											 BEFORE UPDATE OR INSERT OR DELETE
											 ON dbamv.itcontagem
											 REFERENCING OLD AS OLD NEW AS NEW
											 FOR EACH ROW
											BEGIN
												If MGES_TEMP_LEGADO.vScript Then
										      Return;
										    End If;
											  Raise_Application_Error(-20000, ''Sistema parado para manutenção.'');
											END;');

	EXECUTE IMMEDIATE ('CREATE OR REPLACE TRIGGER DBAMV.TRG_MGES_DESATIVA_MOV
											 BEFORE UPDATE OR INSERT OR DELETE
											 ON dbamv.mvto_estoque
											 REFERENCING OLD AS OLD NEW AS NEW
											 FOR EACH ROW
											BEGIN
											  Raise_Application_Error(-20000, ''Sistema parado para manutenção.'');
											END;');

	EXECUTE IMMEDIATE ('CREATE OR REPLACE TRIGGER DBAMV.TRG_MGES_DESATIVA_ITMOV
											 BEFORE UPDATE OR INSERT OR DELETE
											 ON dbamv.itmvto_estoque
											 REFERENCING OLD AS OLD NEW AS NEW
											 FOR EACH ROW
											BEGIN
												If MGES_TEMP_LEGADO.vScript Then
										      Return;
										    End If;
											  Raise_Application_Error(-20000, ''Sistema parado para manutenção.'');
											END;');

	EXECUTE IMMEDIATE ('CREATE OR REPLACE TRIGGER DBAMV.TRG_MGES_DESATIVA_KIT
											 BEFORE UPDATE OR INSERT OR DELETE
											 ON dbamv.mvto_kit_produzido
											 REFERENCING OLD AS OLD NEW AS NEW
											 FOR EACH ROW
											BEGIN
											  Raise_Application_Error(-20000, ''Sistema parado para manutenção.'');
											END;');
END;
/
ALTER TRIGGER DBAMV.TRG_LOT_PRO DISABLE

/

DECLARE
  --                                          ***INFORMAR OS PARÂMETROS AQUI***
  -----------------------------------------------------------------------------------------------------------------------------------------
  vEmpresa    NUMBER         := '1' ; --< Informe o código da EMPRESA
  vEstoque    VARCHAR2(1000) := '40'; --< Informe o código dos ESTOQUES SEPARADOS POR VÍRGULA OU NULO PARA TODOS.
  vProduto    VARCHAR2(1000) := '19312,19410,19459'; -- Informe o código dos PRODUTOS  SEPARADOS POR VÍRGULA, NÃO PODE SER NULO, DADO OBRIGATÓRIO;
  -----------------------------------------------------------------------------------------------------------------------------------------
  --
  vDhExecucao DATE := SYSDATE;
  vComando    VARCHAR2(31000);
  vErro       VARCHAR2(4000);

BEGIN

  dbamv.pkg_mv2000.atribui_empresa(vEmpresa); -- Informe a EMPRESA

  vComando := 'INSERT INTO dbamv.script_saldo_produto
                                (SELECT dbamv.pkg_mv2000.le_empresa,
                                        p.cd_produto,
                                        p.cd_produto_tem,
                                        TO_DATE('''||To_Char(vDhExecucao, 'DD/MM/YYYY HH24:MI:SS')||''', ''DD/MM/YYYY hh24:mi:ss''),
                                        '''',
                                        '''',
                                        SN_MESTRE,
                                        SN_CONSIGNADO,
                                        ''N'',
                                        ''N'',
                                        ''N'',
                                        ''N'',';

    IF vEstoque IS NOT NULL THEN

      vComando := vComando||' e.cd_estoque
                          FROM dbamv.produto p,
                                dbamv.est_pro e
                          WHERE sn_consignado <> ''C''
                            AND p.cd_produto = e.cd_produto
                            AND e.cd_estoque in ('||vEstoque||')';
    ELSE

     vComando := vComando||' e.cd_estoque
                          FROM dbamv.produto p,
                                dbamv.est_pro e
                          WHERE sn_consignado <> ''C''
                            AND p.cd_produto = e.cd_produto ';

    END IF;

    IF vProduto IS NOT NULL THEN
      vComando := vComando||' AND P.cd_produto in ('||vProduto||')';
    END IF;
    vComando := vComando||' )';

    EXECUTE IMMEDIATE vComando;
    COMMIT;


    FOR rProdutos IN (SELECT cd_multi_empresa, cd_produto, sn_consignado
                        FROM dbamv.script_saldo_produto
                       WHERE  dh_inicio = vDhExecucao
                        GROUP BY cd_multi_empresa, cd_produto, sn_consignado) LOOP

      -- Corrige a tabela itmvto_estoque custo:
       DBAMV.PRC_MGES_ATU_ITMVTO_CUSTO(rProdutos.cd_produto);
       UPDATE dbamv.script_saldo_produto SET sn_corrige_itmvto = 'S'
        WHERE cd_produto = rProdutos.cd_produto;
       COMMIT;

       -- Corrige a tabela de saldo consignado est_consig_forn:
       IF rProdutos.sn_consignado = 'S' THEN
          DBAMV.PRC_MGES_CORRIGE_LEGADO_CONSIG(rProdutos.cd_multi_empresa, rProdutos.cd_produto);
          UPDATE dbamv.script_saldo_produto SET sn_corrige_consig = 'S'
          WHERE cd_produto = rProdutos.cd_produto;
          COMMIT;
       END IF;
    END LOOP;

    FOR rProdutos IN (SELECT * FROM dbamv.script_saldo_produto) LOOP
       -- Corrige a tabela lot_pro de acordo com as movimentações do lote e corrige a est_pro:
       IF rProdutos.sn_mestre = 'N' THEN
          DBAMV.PRC_MGES_CORRIGE_LEGADO_LOTE (rProdutos.cd_estoque, rProdutos.cd_produto, sysdate);
          UPDATE dbamv.script_saldo_produto SET sn_corrige_lote = 'S', dh_fim = SYSDATE
          WHERE Nvl(cd_estoque, 0) = Nvl(rProdutos.cd_estoque,0) AND cd_produto = rProdutos.cd_produto AND dh_inicio = vDhExecucao;
          COMMIT;
       END IF;

       IF rProdutos.cd_mestre > 0 OR rProdutos.sn_mestre = 'S' THEN
					dbamv.prc_mges_corrige_saldo_mestre(rProdutos.cd_estoque, Nvl(rProdutos.cd_mestre, rProdutos.cd_produto));
          UPDATE dbamv.script_saldo_produto SET sn_corrige_mestre = 'S', dh_fim = SYSDATE
          WHERE Nvl(cd_estoque, 0) = Nvl(rProdutos.cd_estoque,0) AND cd_produto = rProdutos.cd_produto AND dh_inicio = vDhExecucao;
          COMMIT;
			 END IF;
       --
    END LOOP;
    EXECUTE IMMEDIATE 'ALTER TRIGGER DBAMV.TRG_LOT_PRO ENABLE';

EXCEPTION WHEN OTHERS THEN
  vErro := SQLERRM;
  INSERT INTO dbamv.script_saldo_produto(cd_multi_empresa, dh_inicio, dh_fim, ds_erro) VALUES (vEmpresa, vDhExecucao, SYSDATE, vErro);
  EXECUTE IMMEDIATE 'ALTER TRIGGER DBAMV.TRG_LOT_PRO ENABLE';
  COMMIT;

END ;
/
BEGIN
 	      EXECUTE IMMEDIATE('DROP TRIGGER DBAMV.TRG_MGES_DESATIVA_ENTRADA');
		  	EXECUTE IMMEDIATE('DROP TRIGGER DBAMV.TRG_MGES_DESATIVA_DEV_FOR');
		  	EXECUTE IMMEDIATE('DROP TRIGGER DBAMV.TRG_MGES_DESATIVA_CONCL');
		  	EXECUTE IMMEDIATE('DROP TRIGGER DBAMV.TRG_MGES_DESATIVA_MOV');
		  	EXECUTE IMMEDIATE('DROP TRIGGER DBAMV.TRG_MGES_DESATIVA_ITMOV');
		  	EXECUTE IMMEDIATE('DROP TRIGGER DBAMV.TRG_MGES_DESATIVA_CONTAGEM');
		  	EXECUTE IMMEDIATE('DROP TRIGGER DBAMV.TRG_MGES_DESATIVA_ITCONTAGEM');
		  	EXECUTE IMMEDIATE('DROP TRIGGER DBAMV.TRG_MGES_DESATIVA_KIT');
END;
 /
SELECT * FROM  dbamv.script_saldo_produto










