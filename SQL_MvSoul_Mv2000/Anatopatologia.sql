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
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
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
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
           AND (NVL(ITPED_RX . SN_REALIZADO, 'N') = 'N' OR TRUNC(ITPED_RX . DT_REALIZADO) > TO_DATE('30/09/2023', 'DD/MM/YYYY'))
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
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
           AND TRUNC(ITPED_RX . DT_REALIZADO) BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
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
           AND TRUNC(PED_RX . DT_PEDIDO) < TO_DATE('01/10/2023', 'DD/MM/YYYY')
           AND TRUNC(ITPED_RX . DT_REALIZADO) BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND TO_DATE('30/09/2023', 'DD/MM/YYYY')
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


-- Adição de Exames
-- FAZER TODOS OS CONVENIOS, MÊS A MÊS, EXPORTAR PRO EXCEL E FAZER 
SELECT decode(CD_CONVENIO, 1, 'SUS', 2, 'SUS', 16 , 'Particular', 'PSaude') NM_CONVENIO,
       DECODE(CD_EXA_RX, '1', 'Biopsia', '2', 'Congelacao',
           '3', 'Mielograma', '9', 'Citologia', '10',
           'Citologia', '11', 'Citologia', '16', 'Biopsia',
           '39', 'Citologia', '44', 'Congelacao', '107',
           'Biopsia', '218', 'Citologia', '220', 'Imuno',  '226', 'Imuno',
           '232', 'Receptores', '236', 'Citologia', '244', 'Biopsia',
           '376', 'Histoquimico') DS_EXA_RX,
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
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/01/2024', 'DD/MM/YYYY')
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
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN TO_DATE('31/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/01/2024', 'DD/MM/YYYY')
           AND (NVL(ITPED_RX . SN_REALIZADO, 'N') = 'N' OR TRUNC(ITPED_RX . DT_REALIZADO) > TO_DATE('31/01/2024', 'DD/MM/YYYY'))
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
           AND TRUNC(PED_RX . DT_PEDIDO) BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/01/2024', 'DD/MM/YYYY')
           AND TRUNC(ITPED_RX . DT_REALIZADO) BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/01/2024', 'DD/MM/YYYY')
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
           AND TRUNC(PED_RX . DT_PEDIDO) < TO_DATE('01/02/2024', 'DD/MM/YYYY')
           AND TRUNC(ITPED_RX . DT_REALIZADO) BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/01/2024', 'DD/MM/YYYY')
           AND PED_RX.CD_SET_EXA = 13
--           AND PED_RX.CD_CONVENIO in (1,2,16)
         GROUP BY PED_RX   . CD_CONVENIO,
                  PED_RX . DT_PEDIDO,
                  CONVENIO . NM_CONVENIO,
                  ITPED_RX . CD_EXA_RX,
                  EXA_RX   . DS_EXA_RX,
                  ITPED_RX . SN_REALIZADO)
 GROUP BY CD_CONVENIO, NM_CONVENIO, CD_EXA_RX, DS_EXA_RX
 ORDER BY 1 ASC, 2 ASC;
  
