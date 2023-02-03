-- FAZER TODOS OS CONVENIOS, MÊS A MÊS, EXPORTAR PRO EXCEL E FAZER 
SELECT decode(CD_CONVENIO, 1, 'SUS', 2, 'SUS', 16 , 'Particular', 'PSaude') NM_CONVENIO,
       DECODE(CD_EXA_RX, '11', 'Citologia', '9', 'Citologia', '39', 'Citologia', '10', 'Citologia',  '44','Citologia',
                          '2', 'Congelacao', '107', 'Biopsia', '3', 'Mielograma', '226', 'Imuno', '232', 'Receptores',
                          '236', 'Citologia', '220', 'Imuno', '218', 'Citologia', '244', 'Biopsia') DS_EXA_RX,
--       cd_exa_rx,
       sum(QTDE_REL_PERIODO) QTDE_REL_PERIODO--,
--       TO_CHAR(PED_RX . DT_PEDIDO, 'FMMONTH') MES
--       PED_RX . DT_PEDIDO, 'FMMONTH'
--       TRUNC(PED_RX . DT_PEDIDO)
  FROM (SELECT PED_RX . CD_CONVENIO,
--               PED_RX . DT_PEDIDO,
               CONVENIO . NM_CONVENIO,
               ITPED_RX . CD_EXA_RX,
               EXA_RX . DS_EXA_RX,
               ITPED_RX . SN_REALIZADO,
               0 QTDE_REALIZADO,
               0 QTDE_N_REALIZADO,
               NVL(COUNT(*), 0) QTDE_PED_PERIODO,
               0 QTDE_REL_PERIODO
          FROM DBAMV . ITPED_RX,
               DBAMV . EXA_RX,
               DBAMV . CONVENIO,
               DBAMV . PED_RX,
               DBAMV . EMPRESA_CONVENIO
         WHERE EMPRESA_CONVENIO . CD_CONVENIO = CONVENIO . CD_CONVENIO
           AND EMPRESA_CONVENIO . CD_MULTI_EMPRESA = 1
           AND EXA_RX . CD_EXA_RX = ITPED_RX . CD_EXA_RX
           AND ITPED_RX . CD_PED_RX = PED_RX . CD_PED_RX
           AND PED_RX . CD_CONVENIO = CONVENIO . CD_CONVENIO
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN '01/10/2022' AND '31/10/2022'
           AND PED_RX.CD_SET_EXA = 13
--           AND PED_RX.CD_CONVENIO in (1,2,16)
         GROUP BY PED_RX   . CD_CONVENIO,
                  CONVENIO . NM_CONVENIO,
                  ITPED_RX . CD_EXA_RX,
                  EXA_RX   . DS_EXA_RX,
                  ITPED_RX . SN_REALIZADO
        UNION ALL
        SELECT PED_RX . CD_CONVENIO,
--               PED_RX . DT_PEDIDO,
               CONVENIO . NM_CONVENIO,
               ITPED_RX . CD_EXA_RX,
               EXA_RX . DS_EXA_RX,
               ITPED_RX . SN_REALIZADO,
               0 QTDE_REALIZADO,
               NVL(COUNT(NVL(SN_REALIZADO, 'N')), 0) QTDE_N_REALIZADO,
               0 QTDE_PED_PERIODO,
               0 QTDE_REL_PERIODO
          FROM DBAMV . ITPED_RX,
               DBAMV . EXA_RX,
               DBAMV . CONVENIO,
               DBAMV . PED_RX,
               DBAMV . EMPRESA_CONVENIO
         WHERE EMPRESA_CONVENIO . CD_CONVENIO = CONVENIO . CD_CONVENIO
           AND EMPRESA_CONVENIO . CD_MULTI_EMPRESA = 1
           AND EXA_RX . CD_EXA_RX = ITPED_RX . CD_EXA_RX
           AND ITPED_RX . CD_PED_RX = PED_RX . CD_PED_RX
           AND PED_RX . CD_CONVENIO = CONVENIO . CD_CONVENIO
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN '01/10/2022' AND '31/10/2022'
           AND (NVL(ITPED_RX . SN_REALIZADO, 'N') = 'N' OR TRUNC(ITPED_RX . DT_REALIZADO) > '31/10/2022')
           AND PED_RX.CD_SET_EXA = 13
--           AND PED_RX.CD_CONVENIO in (1,2,16)
         GROUP BY PED_RX   . CD_CONVENIO,
                  CONVENIO . NM_CONVENIO,
                  ITPED_RX . CD_EXA_RX,
                  EXA_RX   . DS_EXA_RX,
                  ITPED_RX . SN_REALIZADO
                  
        UNION ALL
        SELECT PED_RX . CD_CONVENIO,
--               PED_RX . DT_PEDIDO,
               CONVENIO . NM_CONVENIO,
               ITPED_RX . CD_EXA_RX,
               EXA_RX . DS_EXA_RX,
               ITPED_RX . SN_REALIZADO,
               NVL(COUNT(*), 0) QTDE_REALIZADO,
               0 QTDE_N_REALIZADO,
               0 QTDE_PED_PERIODO,
               0 QTDE_REL_PERIODO
          FROM DBAMV . ITPED_RX,
               DBAMV . EXA_RX,
               DBAMV . CONVENIO,
               DBAMV . PED_RX,
               DBAMV . EMPRESA_CONVENIO
         WHERE EMPRESA_CONVENIO . CD_CONVENIO = CONVENIO . CD_CONVENIO
           AND EMPRESA_CONVENIO . CD_MULTI_EMPRESA = 1
           AND EXA_RX . CD_EXA_RX = ITPED_RX . CD_EXA_RX
           AND ITPED_RX . CD_PED_RX = PED_RX . CD_PED_RX
           AND PED_RX . CD_CONVENIO = CONVENIO . CD_CONVENIO
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN '01/10/2022' AND '31/10/2022'
           AND TRUNC(ITPED_RX . DT_REALIZADO) BETWEEN '01/10/2022' AND '31/10/2022'
           AND NVL(ITPED_RX . SN_REALIZADO, 'N') = 'S'
           AND PED_RX.CD_SET_EXA = 13
--           AND PED_RX.CD_CONVENIO in (1,2,16)
         GROUP BY PED_RX   . CD_CONVENIO,
                  CONVENIO . NM_CONVENIO,
                  ITPED_RX . CD_EXA_RX,
                  EXA_RX   . DS_EXA_RX,
                  ITPED_RX . SN_REALIZADO
        UNION ALL
        SELECT PED_RX . CD_CONVENIO,
--               PED_RX . DT_PEDIDO,
               CONVENIO . NM_CONVENIO,
               ITPED_RX . CD_EXA_RX,
               EXA_RX . DS_EXA_RX,
               ITPED_RX . SN_REALIZADO,
               0 QTDE_REALIZADO,
               0 QTDE_N_REALIZADO,
               0 QTDE_PED_PERIODO,
               NVL(COUNT(*), 0) QTDE_REL_PERIODO
          FROM DBAMV . ITPED_RX,
               DBAMV . EXA_RX,
               DBAMV . CONVENIO,
               DBAMV . PED_RX,
               DBAMV . EMPRESA_CONVENIO
         WHERE EMPRESA_CONVENIO . CD_CONVENIO = CONVENIO . CD_CONVENIO
           AND EMPRESA_CONVENIO . CD_MULTI_EMPRESA = 1
           AND EXA_RX . CD_EXA_RX = ITPED_RX . CD_EXA_RX
           AND ITPED_RX . CD_PED_RX = PED_RX . CD_PED_RX
           AND PED_RX . CD_CONVENIO = CONVENIO . CD_CONVENIO
           AND TRUNC(PED_RX . DT_PEDIDO) < '01/11/2022'
           AND TRUNC(ITPED_RX . DT_REALIZADO) BETWEEN '01/10/2022' AND '31/10/2022'
           AND PED_RX.CD_SET_EXA = 13
--           AND PED_RX.CD_CONVENIO in (1,2,16)
         GROUP BY PED_RX   . CD_CONVENIO,
                  PED_RX . DT_PEDIDO,
                  CONVENIO . NM_CONVENIO,
                  ITPED_RX . CD_EXA_RX,
                  EXA_RX   . DS_EXA_RX,
                  ITPED_RX . SN_REALIZADO)
 GROUP BY CD_CONVENIO, NM_CONVENIO, CD_EXA_RX, DS_EXA_RX
 ORDER BY 1 ASC, 2 ASC
