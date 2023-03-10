 SELECT produto.cd_produto
 , produto.ds_produto
 , est_pro.qt_estoque_minimo
 , est_pro.qt_estoque_maximo
 , est_pro.qt_ponto_de_pedido 
 , est_pro.qt_estoque_atual
 , Round(est_pro.qt_estoque_maximo - est_pro.qt_estoque_minimo) suges_compra
 , CASE 
 WHEN est_pro.qt_estoque_atual = 0 THEN '<img src="imagens/situacaoPreta.gif" >' 
 WHEN est_pro.qt_estoque_atual < est_pro.qt_estoque_minimo THEN '<img src="imagens/vermelho3.gif" >' 
 ELSE '<img src="imagens/situacaoAmarela.gif" >'
 END STATUS 
 
 FROM est_pro, produto 
 WHERE est_pro.qt_estoque_atual < est_pro.qt_ponto_de_pedido
 AND est_pro.cd_produto = produto.cd_produto
 AND est_pro.cd_estoque = '8'
order by est_pro.qt_estoque_atual asc 
