
Select Itcontagem . Cd_produto Cd_produto,
       Produto . Ds_produto Ds_produto,
       dbamv . verif_ds_unid_prod(ITCONTAGEM . CD_PRODUTO) Ds_unidade,
       Sum((Nvl(Itcontagem . Qt_estoque, 0) +
           Nvl(Itcontagem . Qt_estoque_doado, 0) +
           Nvl(Itcontagem . Qt_Kit, 0)) * UNI_PRO . VL_FATOR) / dbamv . verif_vl_fator_prod(ITCONTAGEM . CD_PRODUTO) Quantidade,
       Trunc(Contagem . Dt_geracao) Data,
       To_char(Contagem . Hr_geracao, 'Hh24:mi:ss') Hora,
       Contagem . Cd_contagem Documento,
       'Contagem - ' || Estoque . Ds_estoque Ds_destino,
       'Contagem' Operacao,
       0 Valor,
       Estoque . Cd_estoque Cd_estoque,
       Estoque . Ds_estoque Ds_estoque,
       dbamv . verif_vl_fator_prod(ITCONTAGEM . CD_PRODUTO) Vl_fator,
       '1' Tp_ordem,
       'N' Sn_consignado,
       Produto . Sn_Consignado Produto_Sn_Consig
  FROM Dbamv . Itcontagem Itcontagem,
       Dbamv . Contagem Contagem,
       Dbamv . Produto Produto,
       Dbamv . Uni_pro Uni_pro,
       Dbamv . Estoque Estoque
 WHERE trunc(contagem.dt_geracao) between sysdate-32 and sysdate
 AND ESTOQUE.CD_ESTOQUE = '9'

   And Itcontagem.Cd_produto = Produto.Cd_produto
   And Itcontagem.Cd_contagem = Contagem.Cd_contagem
   And Itcontagem.Cd_uni_pro = Uni_pro.Cd_uni_pro
   And Contagem.Cd_estoque = Estoque.Cd_estoque
   And Estoque.Cd_Multi_empresa = 1
   AND CONTAGEM.TP_CONTAGEM IN ('G', 'S')
 Group By Itcontagem.Cd_produto,
          Produto.Ds_produto,
          Produto.Vl_custo_medio,
          dbamv.verif_ds_unid_prod(ITCONTAGEM.CD_PRODUTO),
          Contagem.Dt_geracao,
          Contagem.Hr_geracao,
          Contagem.Cd_contagem,
          Estoque.Cd_estoque,
          Estoque.Ds_estoque,
          dbamv.verif_vl_fator_prod(ITCONTAGEM.CD_PRODUTO),
          Produto.Sn_Consignado
Union All
Select Itmvto_estoque . Cd_produto Cd_produto,
       Produto . Ds_produto Ds_produto,
       VERIF_DS_UNID_PROD(Itmvto_estoque . Cd_produto) Ds_Unidade,
       Sum(Decode(Mvto_estoque . Tp_mvto_estoque,
                  'D',
                  Itmvto_estoque . Qt_movimentacao,
                  'C',
                  Itmvto_estoque . Qt_movimentacao,
                  Itmvto_estoque . Qt_movimentacao * -1) * uni_pro .
           vl_fator / dbamv .
           VERIF_VL_FATOR_PROD(itmvto_estoque . cd_produto)) Quantidade,
       Trunc(Mvto_estoque . Dt_mvto_estoque) Data,
       To_char(Mvto_estoque . Hr_mvto_estoque, 'Hh24:mi:ss') Hora,
       Mvto_estoque . Cd_mvto_estoque Documento,
       Initcap(Nvl(Paciente . Nm_paciente,
                   Decode(Mvto_estoque . Tp_mvto_estoque,
                          'T',
                          Estoque_destino . Ds_estoque,
                          'B',
                          'Tombamento Patrimonio',
                          'E',
                          Fornecedor . Nm_fornecedor,
                          Setor . Nm_setor))) Ds_destino,
       Initcap(Decode(Mvto_estoque . Tp_mvto_estoque,
                      'X',
                      'Baixa De Produtos',
                      'S',
                      'Saída Setor',
                      'B',
                      'Tombamento',
                      'P',
                      'Saída Paciente',
                      'D',
                      'Devol. De Setor',
                      'C',
                      'Devol. De Paciente',
                      'T',
                      'Transf. De Estoque ',
                      'M',
                      'Manipul.  Produtos',
                      'O',
                      'Doação  Produtos',
                      'E',
                      'Saída De Empréstimo',
                      'R',
                      'Transf. Empresas',
                      'V',
                      'Venda De Produtos',
                      'N',
                      'Devolução De Vendas')) Operacao,
       0 Valor,
       Estoque . Cd_estoque Cd_estoque,
       Estoque . Ds_estoque Ds_estoque,
       dbamv . VERIF_VL_FATOR_PROD(itmvto_estoque . cd_produto) Vl_fator,
       '3' Tp_ordem,
       'N' Sn_consignado,
       Produto . Sn_Consignado Produto_Sn_Consig
  From Dbamv . Mvto_estoque Mvto_estoque,
       Dbamv . Itmvto_estoque Itmvto_estoque,
       Dbamv . Produto Produto,
       Dbamv . Uni_pro Uni_pro,
       Dbamv . Atendime Atendimento,
       Dbamv . Paciente Paciente,
       Dbamv . Setor Setor,
       Dbamv . Estoque Estoque,
       Dbamv . Estoque Estoque_destino,
       Dbamv . Fornecedor Fornecedor
 Where trunc(mvto_estoque.dt_mvto_estoque) between sysdate-32 and sysdate
   AND ESTOQUE.CD_ESTOQUE = '9'
 
   And Itmvto_estoque.Cd_produto = Produto.Cd_produto
   And Itmvto_estoque.Cd_mvto_estoque = Mvto_estoque.Cd_mvto_estoque
   And Itmvto_estoque.Cd_uni_pro = Uni_pro.Cd_uni_pro
   And Mvto_estoque.Cd_atendimento = Atendimento.Cd_atendimento(+)
   And Atendimento.Cd_paciente = Paciente.Cd_paciente(+)
   And Mvto_estoque.Cd_setor = Setor.Cd_setor(+)
   And Mvto_estoque.Cd_estoque_destino = Estoque_destino.Cd_estoque(+)
   And Itmvto_estoque.Cd_uni_pro = Uni_pro.Cd_uni_pro
   And Mvto_estoque.Cd_estoque = Estoque.Cd_estoque
   And Mvto_estoque.Cd_fornecedor = Fornecedor.Cd_fornecedor(+)
   And Estoque.Cd_Multi_empresa = 1
 Group By Itmvto_estoque.Cd_produto,
          Produto.Ds_produto,
          VERIF_DS_UNID_PROD(Itmvto_estoque.Cd_produto),
          Mvto_estoque.Dt_mvto_estoque,
          Mvto_estoque.Hr_mvto_estoque,
          Mvto_estoque.Cd_mvto_estoque,
          Initcap(Nvl(Paciente.Nm_paciente,
                      Decode(Mvto_estoque.Tp_mvto_estoque,
                             'T',
                             Estoque_destino.Ds_estoque,
                             'B',
                             'Tombamento Patrimonio',
                             'E',
                             Fornecedor.Nm_fornecedor,
                             Setor.Nm_setor))),
          Initcap(Decode(Mvto_estoque.Tp_mvto_estoque,
                         'X',
                         'Baixa De Produtos',
                         'S',
                         'Saída Setor',
                         'B',
                         'Tombamento',
                         'P',
                         'Saída Paciente',
                         'D',
                         'Devol. De Setor',
                         'C',
                         'Devol. De Paciente',
                         'T',
                         'Transf. De Estoque ',
                         'M',
                         'Manipul.  Produtos',
                         'O',
                         'Doação  Produtos',
                         'E',
                         'Saída De Empréstimo',
                         'R',
                         'Transf. Empresas',
                         'V',
                         'Venda De Produtos',
                         'N',
                         'Devolução De Vendas')),
          Estoque.Cd_estoque,
          Estoque.Ds_estoque,
          dbamv.VERIF_VL_FATOR_PROD(itmvto_estoque.cd_produto),
          Produto.Sn_Consignado
Union All
Select Itent_pro . Cd_produto Cd_produto,
       Produto . Ds_produto Ds_produto,
       dbamv . verif_ds_unid_prod(produto . cd_produto) Ds_unidade,
       Sum(Itent_pro . Qt_entrada * uni_pro . vl_fator / dbamv .
           verif_vl_fator_prod(produto . cd_produto)) Quantidade,
       Trunc(Ent_pro . Dt_entrada) Data,
       To_char(Ent_pro . Hr_entrada, 'Hh24:mi:ss') Hora,
       Ent_pro . Cd_ent_pro Documento,
       Initcap(Fornec . Nm_fornecedor) Ds_destino,
       Initcap(Tip_doc . Ds_tip_doc) Operacao,
       Itent_pro . Vl_custo_real / Uni_pro . Vl_fator Valor,
       Estoque . Cd_estoque Cd_estoque,
       Estoque . Ds_estoque Ds_estoque,
       verif_vl_fator_prod(produto . cd_produto) Vl_fator,
       '2' Tp_ordem,
       Ent_pro . Sn_consignado Sn_consignado,
       Produto . Sn_Consignado Produto_Sn_Consig
  From Dbamv . Itent_pro Itent_pro,
       Dbamv . Ent_pro Ent_pro,
       Dbamv . Produto Produto,
       Dbamv . Tip_doc Tip_doc,
       Dbamv . Uni_pro Uni_pro,
       Dbamv . Fornecedor Fornec,
       Dbamv . Estoque
 Where ent_pro.dt_entrada between sysdate-32 and sysdate
      
 AND ESTOQUE.CD_ESTOQUE = '9'

   And Itent_pro.Cd_produto = Produto.Cd_produto
   And Itent_pro.Cd_ent_pro = Ent_pro.Cd_ent_pro
   And Ent_pro.Cd_tip_doc = Tip_doc.Cd_tip_doc
   And Itent_pro.Cd_uni_pro = Uni_pro.Cd_uni_pro
   And Ent_pro.Cd_fornecedor = Fornec.Cd_fornecedor(+)
   And Itent_pro.Cd_uni_pro = Uni_pro.Cd_uni_pro
   And Ent_pro.Cd_estoque = Estoque.Cd_estoque
   And Estoque.Cd_Multi_empresa = 1
 GROUP BY Itent_pro.Cd_produto,
          Produto.Ds_produto,
          Ent_pro.Dt_entrada,
          Ent_pro.Hr_entrada,
          Ent_pro.Cd_ent_pro,
          Fornec.Nm_fornecedor,
          Tip_doc.Ds_tip_doc,
          Estoque.Cd_estoque,
          Estoque.Ds_estoque,
          verif_vl_fator_prod(produto.cd_produto),
          Ent_pro.Sn_consignado,
          Produto.Sn_Consignado,
          produto.cd_produto,
          Itent_pro.Vl_custo_real / Uni_pro.Vl_fator
Union All
Select Itmvto_estoque . Cd_produto Cd_produto,
       Produto . Ds_produto Ds_produto,
       VERIF_DS_UNID_PROD(Itmvto_estoque . Cd_produto) Ds_Unidade,
       Sum(Itmvto_estoque . Qt_movimentacao * uni_pro . vl_fator / dbamv .
           VERIF_VL_FATOR_PROD(itmvto_estoque . cd_produto)) Quantidade,
       Trunc(Mvto_estoque . Dt_mvto_estoque) Data,
       To_char(Mvto_estoque . Hr_mvto_estoque, 'Hh24:mi:ss') Hora,
       Mvto_estoque . Cd_mvto_estoque Documento,
       Initcap(Nvl(Paciente . Nm_paciente,
                   Decode(Mvto_estoque . Tp_mvto_estoque,
                          'T',
                          Estoque_destino . Ds_estoque,
                          Setor . Nm_setor))) Ds_destino,
       Initcap(Decode(Mvto_estoque . Tp_mvto_estoque,
                      'T',
                      'Cred. Transf. Est.')) Operacao,
       0 Valor,
       Estoque . Cd_estoque Cd_estoque,
       Estoque . Ds_estoque Ds_estoque,
       dbamv . VERIF_VL_FATOR_PROD(itmvto_estoque . cd_produto) Vl_fator,
       '3' Tp_ordem,
       'N' Sn_consignado,
       Produto . Sn_Consignado Produto_Sn_Consig
  From Dbamv . Mvto_estoque Mvto_estoque,
       Dbamv . Itmvto_estoque Itmvto_estoque,
       Dbamv . Produto Produto,
       Dbamv . Uni_pro Uni_pro,
       Dbamv . Atendime Atendimento,
       Dbamv . Paciente Paciente,
       Dbamv . Setor Setor,
       Dbamv . Estoque Estoque,
       Dbamv . Estoque Estoque_destino
 Where mvto_estoque.dt_mvto_estoque between sysdate-32 and sysdate
       
  AND ESTOQUE.CD_ESTOQUE = '9'
 
   And Mvto_estoque.Tp_mvto_estoque = 'T'
   And Itmvto_estoque.Cd_produto = Produto.Cd_produto
   And Itmvto_estoque.Cd_mvto_estoque = Mvto_estoque.Cd_mvto_estoque
   And Itmvto_estoque.Cd_uni_pro = Uni_pro.Cd_uni_pro
   And Mvto_estoque.Cd_atendimento = Atendimento.Cd_atendimento(+)
   And Atendimento.Cd_paciente = Paciente.Cd_paciente(+)
   And Mvto_estoque.Cd_setor = Setor.Cd_setor(+)
   And Mvto_estoque.Cd_estoque = Estoque_destino.Cd_estoque
   And Itmvto_estoque.Cd_uni_pro = Uni_pro.Cd_uni_pro
   And Estoque.Cd_estoque = Mvto_estoque.Cd_estoque_destino
   And Estoque.Cd_Multi_empresa = 1
 Group By Itmvto_estoque.Cd_produto,
          Produto.Ds_produto,
          VERIF_DS_UNID_PROD(Itmvto_estoque.Cd_produto),
          Mvto_estoque.Dt_mvto_estoque,
          Mvto_estoque.Hr_mvto_estoque,
          Mvto_estoque.Cd_mvto_estoque,
          Initcap(Nvl(Paciente.Nm_paciente,
                      Decode(Mvto_estoque.Tp_mvto_estoque,
                             'T',
                             Estoque_destino.Ds_estoque,
                             Setor.Nm_setor))),
          Initcap(Decode(Mvto_estoque.Tp_mvto_estoque,
                         'T',
                         'Cred. Transf. Est.')),
          Estoque.Cd_estoque,
          Estoque.Ds_estoque,
          dbamv.VERIF_VL_FATOR_PROD(itmvto_estoque.cd_produto),
          Produto.Sn_Consignado
Union All
Select Itdev_for . Cd_produto,
       Produto . Ds_produto,
       VERIF_DS_UNID_PROD(Itdev_for . Cd_produto) Ds_Unidade,
       Sum((Itdev_for . Qt_devolvida * -1) * uni_pro . vl_fator / dbamv .
           VERIF_VL_FATOR_PROD(itdev_for . cd_produto)) Quantidade,
       Trunc(Dev_for . Dt_devolucao) Data,
       To_char(Dev_for . Hr_devolucao, 'Hh24:mi:ss') Hora,
       Dev_for . Cd_devolucao Documento,
       Initcap(Fornecedor . Nm_fornecedor) Ds_destino,
       'Dev. P/  Fornecedor' Operacao,
       (Itent_pro . Vl_custo_real / uni_pro . vl_fator) Valor,
       Estoque . Cd_estoque Cd_estoque,
       Estoque . Ds_estoque Ds_estoque,
       dbamv . VERIF_VL_FATOR_PROD(Itdev_for . cd_produto) Vl_fator,
       '4' Tp_ordem,
       'N' Sn_consignado,
       Produto . Sn_Consignado Produto_Sn_Consig
  From Dbamv . Estoque,
       Dbamv . Dev_for,
       Dbamv . Itdev_for,
       Dbamv . Uni_pro,
       Dbamv . Fornecedor,
       Dbamv . Produto,
       Dbamv . Ent_pro,
       Dbamv . Itent_pro
 Where dev_for.dt_devolucao between sysdate-32 and sysdate
   AND ESTOQUE.CD_ESTOQUE = '9'

   And Itdev_for.Cd_devolucao = Dev_for.Cd_devolucao
   And Itdev_for.Cd_produto = Produto.Cd_produto
   And Itdev_for.Cd_uni_pro = Uni_pro.Cd_uni_pro
   And Dev_for.Cd_ent_pro = Ent_pro.Cd_ent_pro
   And Ent_pro.Cd_fornecedor = Fornecedor.Cd_fornecedor
   And Ent_pro.Cd_estoque = Estoque.Cd_estoque
   And Itdev_for.Cd_itent_pro = Itent_pro.Cd_itent_pro
   And Estoque.Cd_Multi_empresa = 1
 Group By Itdev_for.Cd_produto,
          Produto.Ds_produto,
          Dev_for.Dt_devolucao,
          Dev_for.Hr_devolucao,
          Dev_for.Cd_devolucao,
          Initcap(Fornecedor.Nm_fornecedor),
          (Itent_pro.Vl_custo_real / uni_pro.vl_fator),
          Estoque.Cd_estoque,
          Estoque.Ds_estoque,
          dbamv.VERIF_VL_FATOR_PROD(Itdev_for.cd_produto),
          Produto.Sn_Consignado
 ORDER BY 2          ASC,
          12         ASC,
          11         ASC,
          1          ASC,
          Ds_produto,
          5,
          6,
          Tp_ordem,
          Operacao
