select*
from doc_caixa
where cd_doc_caixa = 180 --NUMERO DO DOCUEMNTO QUE APARECE NA O_MOV_CAIXA NA ABA DOCUMENTO
/
select*
from mov_caixa
where cd_doc_caixa IN  (180,183,184) --NUMERO DO DOCUEMNTO QUE APARECE NA O_MOV_CAIXA NA ABA DOCUMENTO
/
SELECT*
FROM mov_caixa
WHERE cd_lote_caixa =354
AND tp_movimentacao = 'S'
ORDER BY 4
/
SELECT*
FROM mov_caixa
WHERE cd_lote_caixa = 710
ORDER BY dt_movimentacao desc

