SELECT o.cd_ord_com,
       o.dt_ord_com,
       o.tp_ord_com tp_ord,
       o.tp_situacao sit_atual,
       dbamv.pkg_mgco_ordcom.Fn_Situacao(o.cd_ord_com) sito_calc,
      (SELECT SN_AUTORIZA_EM_SERIE
        FROM DBAMV.CONFIGEST C,
             DBAMV.ESTOQUE E
       WHERE C.CD_MULTI_EMPRESA = E.CD_MULTI_EMPRESA
         AND E.CD_ESTOQUE = O.CD_ESTOQUE) SN_AUTO_SERIE,
       e.cd_ent_pro,
       s.cd_ent_serv,
       o.vl_total vl_ordem,
       e.vl_total vl_entrada,
       s.vl_total vl_entrada_SERV,
       nvl(o.usuario_autorizador, o.cd_id_usuario_autorizou) usuario_autorizador,
       o.dt_autorizacao,
       o.dt_cancelamento,
       o.cd_mot_cancel,
       (Select Max(Nvl(Na.Vl_Limite_Autorizador, 0))
          From Dbamv.Nivel_Autorizador Na
         Where Na.Cd_Nivel_Autorizador in ( Select Aoc.Cd_Nivel_Autorizador
                                              From Dbamv.Autorizador_Ordem_Compra Aoc
                                             Where Aoc.Cd_Ord_com =  o.cd_ord_com)) nivel_auto
  FROM dbamv.ord_com o,
       dbamv.ent_pro e,
       dbamv.ent_serv s
 WHERE o.cd_ord_com = e.cd_ord_com (+)
 AND o.cd_ord_com = s.cd_ord_com (+)
 AND o.tp_situacao <> dbamv.pkg_mgco_ordcom.Fn_Situacao(o.cd_ord_com)
 AND NVL (tp_contrato, 'O') = 'O'
 AND o.cd_ord_com = 48902




 SELECT OC.CD_ORD_COM,
       ITO.CD_PRODUTO,
       ITO.QT_COMPRADA,
       ITO.QT_RECEBIDA,
       ITO.QT_CANCELADA,
       ITO.VL_UNITARIO
  FROM DBAMV.ORD_COM OC,
       DBAMV.ITORD_PRO ITO
 WHERE OC.CD_ORD_COM = ITO.CD_ORD_COM
   AND OC.TP_SITUACAO = 'O'
