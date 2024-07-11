--Nesse exemplo a orderm com erro de valor negativo é a 58373, nela possuia o produto 19214 que precisava de uma quantidade de compra de 4.
SELECT * FROM DBAMV.ITORD_PRO
WHERE cd_ord_com = 58373
ORDER BY 1 DESC

SELECT * FROM DBAMV.ORD_COM
WHERE CD_ORD_COM = 58373

SELECT * FROM DBAMV.EST_PRO
WHERE CD_PRODUTO = 19214
AND CD_ESTOQUE = 1

update dbamv.est_pro
set qt_ordem_de_compra = 4 
where cd_produto = 19214
and cd_estoque = 1

commit;
