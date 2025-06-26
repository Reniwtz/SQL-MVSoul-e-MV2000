--Particular
SELECT
    caucao.tp_pagamento   AS tipo_de_recebimento,
    SUM(caucao.vl_caucao) AS valor
FROM
    caucao
WHERE
    caucao.dt_caucao BETWEEN TO_DATE('10/06/2025', 'DD/MM/YYYY') AND TO_DATE('10/06/2025', 'DD/MM/YYYY')
GROUP BY
    caucao.tp_pagamento
UNION ALL
SELECT
    'P'              AS tipo_de_recebimento,
    SUM(vl_previsto) AS valor
FROM
    con_rec
WHERE
    cd_reduzido LIKE '2915'
    AND dt_emissao BETWEEN TO_DATE('10/06/2025', 'DD/MM/YYYY') AND TO_DATE('10/06/2025', 'DD/MM/YYYY');
