SELECT AGENDA_CENTRAL.CD_AGENDA_CENTRAL,
       AGENDA_CENTRAL.TP_AGENDA,
       AGENDA_CENTRAL.DT_AGENDA,
       AGENDA_CENTRAL.CD_MULTI_EMPRESA,
       AGENDA_CENTRAL.CD_UNIDADE_ATENDIMENTO,
       UNIDADE_ATENDIMENTO.DS_UNIDADE_ATENDIMENTO,
       AGENDA_CENTRAL.CD_RECURSO_CENTRAL,
       RECURSO_CENTRAL.DS_RECURSO_CENTRAL,
       AGENDA_CENTRAL.CD_PRESTADOR,
       PRESTADOR.NM_PRESTADOR,
       AGENDA_CENTRAL.CD_SETOR,
       SETOR.NM_SETOR,
       IT_AGENDA_CENTRAL.HR_AGENDA,
       IT_AGENDA_CENTRAL.CD_PACIENTE,
       NVL(IT_AGENDA_CENTRAL.NM_PACIENTE, PACIENTE.NM_PACIENTE) NM_PACIENTE,
       NVL(IT_AGENDA_CENTRAL.NR_FONE, PACIENTE.NR_FONE) NR_FONE,
       NVL(IT_AGENDA_CENTRAL.DT_NASCIMENTO, PACIENTE.DT_NASCIMENTO) DT_NASCIMENTO,
       NVL(PACIENTE.EMAIL, IT_AGENDA_CENTRAL.DS_EMAIL) DS_EMAIL,
       NVL(IT_AGENDA_CENTRAL.TP_SEXO, PACIENTE.TP_SEXO)TP_SEXO,
       IT_AGENDA_CENTRAL.VL_ALTURA,
       IT_AGENDA_CENTRAL.QT_PESO,
       IT_AGENDA_CENTRAL.CD_IT_AGENDA_CENTRAL,
       CONVENIO.CD_CONVENIO,
       CONVENIO.NM_CONVENIO,
       CON_PLA.CD_CON_PLA,
       CON_PLA.DS_CON_PLA,
       nvl(IT_AGENDA_CENTRAL.CD_ITEM_AGENDAMENTO,item_agendmto_item_agen_ctral.cd_item_agendamento) cd_item_agendamento,
       Nvl( ITEM_AGENDAMENTO.DS_ITEM_AGENDAMENTO, PKG_CENTRAL_MARCACOES.FNC_DESC_ITEM_AGEN_CTRAL(IT_AGENDA_CENTRAL.CD_IT_AGENDA_CENTRAL) ),
       IT_AGENDA_CENTRAL.CD_SER_DIS,
       SER_DIS.DS_SER_DIS,
       IT_AGENDA_CENTRAL.CD_TIP_MAR,
       TIP_MAR.DS_TIP_MAR,
       IT_AGENDA_CENTRAL.DT_GRAVACAO,
       TO_NUMBER(Null)CD_GRUPO_AGENDA,
       '' DS_GRUPO_AGENDA,
       IT_AGENDA_CENTRAL.VL_PERC_DESCONTO,
       IT_AGENDA_CENTRAL.VL_NEGOCIADO,
       DECODE(IT_AGENDA_CENTRAL.SN_ANESTESISTA,
              'S', pkg_rmi_traducao.extrair_pkg_msg('MSG_1', 'VDIC_HORARIOS_AGENDA_SCMA', 'Sim'),
              'N', pkg_rmi_traducao.extrair_pkg_msg('MSG_2', 'VDIC_HORARIOS_AGENDA_SCMA', 'Não'),
              IT_AGENDA_CENTRAL.SN_ANESTESISTA),
       IT_AGENDA_CENTRAL.CD_ANESTESISTA,
       ANESTESISTA.NM_PRESTADOR,
       IT_AGENDA_CENTRAL.DS_OBSERVACAO,
       IT_AGENDA_CENTRAL.CD_SOLIC_AGENDAMENTO,
       IT_AGENDA_CENTRAL.DS_SENHA_PAINEL,
       DECODE(IT_AGENDA_CENTRAL.SN_DISPENSA_EQUIPAMENTOS,
              'S', pkg_rmi_traducao.extrair_pkg_msg('MSG_1', 'VDIC_HORARIOS_AGENDA_SCMA', 'Sim'),
              'N', pkg_rmi_traducao.extrair_pkg_msg('MSG_2', 'VDIC_HORARIOS_AGENDA_SCMA', 'Não'),
              IT_AGENDA_CENTRAL.SN_DISPENSA_EQUIPAMENTOS),
       IT_AGENDA_CENTRAL.CD_AGENDA_FILA_ESPERA,
       IT_AGENDA_CENTRAL.CD_USUARIO,
       USUARIOS.NM_USUARIO,
       IT_AGENDA_CENTRAL.TP_SITUACAO,
       IT_AGENDA_CENTRAL.CD_ATENDIMENTO cod_atendimento,
       AGENDA_CENTRAL.SN_ATIVO,
       IT_AGENDA_CENTRAL.DS_OBSERVACAO_GERAL,
       it_agenda_central.nr_ddi_celular,
       it_agenda_central.nr_ddd_celular,
       it_agenda_central.nr_celular,
       it_agenda_central.nr_ddd_fone,
       it_agenda_central.nr_ddi_telefone,
     it_agenda_central.cd_it_agenda_central,
     DECODE(agenda_central.sn_falta,
              'S',
              'S',
              agenda_central.sn_falta) sn_falta,
          DECODE(it_agenda_central.sn_encaixe,
              'S', pkg_rmi_traducao.extrair_pkg_msg('MSG_1', 'VDIC_HORARIOS_AGENDA_SCMA', 'Sim'),
              'N', pkg_rmi_traducao.extrair_pkg_msg('MSG_2', 'VDIC_HORARIOS_AGENDA_SCMA', 'Não'),
              it_agenda_central.sn_encaixe)
  FROM DBAMV.IT_AGENDA_CENTRAL,
       DBAMV.PACIENTE,
       DBAMV.SER_DIS,
       DBAMV.TIP_MAR,
       DBAMV.CONVENIO,
       DBAMV.CON_PLA,
       DBASGU.USUARIOS,
       DBAMV.AGENDA_CENTRAL,
       DBAMV.PRESTADOR,
       DBAMV.RECURSO_CENTRAL,
       DBAMV.UNIDADE_ATENDIMENTO,
       DBAMV.SETOR,
       DBAMV.ITEM_AGENDAMENTO,
       DBAMV.PRESTADOR ANESTESISTA,
     dbamv.item_agendmto_item_agen_ctral
 WHERE AGENDA_CENTRAL.CD_PRESTADOR              = PRESTADOR.CD_PRESTADOR (+)
   AND AGENDA_CENTRAL.CD_RECURSO_CENTRAL        = RECURSO_CENTRAL.CD_RECURSO_CENTRAL (+)
   AND AGENDA_CENTRAL.CD_UNIDADE_ATENDIMENTO    = UNIDADE_ATENDIMENTO.CD_UNIDADE_ATENDIMENTO (+)
   AND AGENDA_CENTRAL.CD_AGENDA_CENTRAL         = IT_AGENDA_CENTRAL.CD_AGENDA_CENTRAL
   AND ITEM_AGENDAMENTO.CD_ITEM_AGENDAMENTO(+)  = IT_AGENDA_CENTRAL.CD_ITEM_AGENDAMENTO
   AND it_agenda_central.cd_it_agenda_central  = item_agendmto_item_agen_ctral.cd_it_agenda_central(+) -- OP 47580
   AND AGENDA_CENTRAL.CD_SETOR                  = SETOR.CD_SETOR
   AND IT_AGENDA_CENTRAL.CD_PACIENTE            = PACIENTE.CD_PACIENTE (+)
   AND IT_AGENDA_CENTRAL.CD_SER_DIS             = SER_DIS.CD_SER_DIS (+)
   AND IT_AGENDA_CENTRAL.CD_TIP_MAR             = TIP_MAR.CD_TIP_MAR (+)
   AND IT_AGENDA_CENTRAL.CD_ANESTESISTA         = ANESTESISTA.CD_PRESTADOR(+)
   AND IT_AGENDA_CENTRAL.CD_CONVENIO            = CONVENIO.CD_CONVENIO
   AND IT_AGENDA_CENTRAL.CD_CONVENIO            = CON_PLA.CD_CONVENIO (+)
   AND IT_AGENDA_CENTRAL.CD_CON_PLA             = CON_PLA.CD_CON_PLA (+)
   AND IT_AGENDA_CENTRAL.CD_USUARIO             = USUARIOS.CD_USUARIO (+)
   AND IT_AGENDA_CENTRAL.CD_PACIENTE || IT_AGENDA_CENTRAL.NM_PACIENTE IS NOT NULL
   AND IT_AGENDA_CENTRAL.CD_IT_AGENDA_PAI IS NULL
   AND AGENDA_CENTRAL.CD_MULTI_EMPRESA = 1
   --and AGENDA_CENTRAL.dt_agenda between To_Date('15/04/2015 00:00', 'dd/mm/yyyy hh24:mi') and To_Date('15/04/2015 23:59', 'dd/mm/yyyy hh24:mi')
UNION ALL
SELECT AGENDA_CENTRAL.CD_AGENDA_CENTRAL,
       AGENDA_CENTRAL.TP_AGENDA,
       AGENDA_CENTRAL.DT_AGENDA,
       AGENDA_CENTRAL.CD_MULTI_EMPRESA,
       AGENDA_CENTRAL.CD_UNIDADE_ATENDIMENTO,
       UNIDADE_ATENDIMENTO.DS_UNIDADE_ATENDIMENTO,
       AGENDA_CENTRAL.CD_RECURSO_CENTRAL,
       RECURSO_CENTRAL.DS_RECURSO_CENTRAL,
       AGENDA_CENTRAL.CD_PRESTADOR,
       PRESTADOR.NM_PRESTADOR,
       AGENDA_CENTRAL.CD_SETOR,
       SETOR.NM_SETOR,
       IT_AGENDA_CENTRAL.HR_AGENDA,
       V_AGENDA_CENTRAL_GUPO_PAC.CD_PACIENTE,
       V_AGENDA_CENTRAL_GUPO_PAC.NM_PACIENTE,
       V_AGENDA_CENTRAL_GUPO_PAC.NR_FONE,
       V_AGENDA_CENTRAL_GUPO_PAC.DT_NASCIMENTO,
       V_AGENDA_CENTRAL_GUPO_PAC.DS_EMAIL,
       V_AGENDA_CENTRAL_GUPO_PAC.TP_SEXO,
       V_AGENDA_CENTRAL_GUPO_PAC.VL_ALTURA,
       V_AGENDA_CENTRAL_GUPO_PAC.QT_PESO,
       V_AGENDA_CENTRAL_GUPO_PAC.CD_IT_AGENDA_CENTRAL,
       V_AGENDA_CENTRAL_GUPO_PAC.CD_CONVENIO,
       V_AGENDA_CENTRAL_GUPO_PAC.NM_CONVENIO,
       V_AGENDA_CENTRAL_GUPO_PAC.CD_CON_PLA,
       V_AGENDA_CENTRAL_GUPO_PAC.DS_CON_PLA,
       nvl(IT_AGENDA_CENTRAL.CD_ITEM_AGENDAMENTO,item_agendmto_item_agen_ctral.cd_item_agendamento) cd_item_agendamento,
       ITEM_AGENDAMENTO.DS_ITEM_AGENDAMENTO,
       IT_AGENDA_CENTRAL.CD_SER_DIS,
       SER_DIS.DS_SER_DIS,
       IT_AGENDA_CENTRAL.CD_TIP_MAR,
       TIP_MAR.DS_TIP_MAR,
       IT_AGENDA_CENTRAL.DT_GRAVACAO,
       IT_AGENDA_CENTRAL.CD_GRUPO_AGENDA,
       GRUPO_AGENDA.DS_GRUPO_AGENDA,
       IT_AGENDA_CENTRAL.VL_PERC_DESCONTO,
       IT_AGENDA_CENTRAL.VL_NEGOCIADO,
       DECODE(IT_AGENDA_CENTRAL.SN_ANESTESISTA,
              'S', pkg_rmi_traducao.extrair_pkg_msg('MSG_1', 'VDIC_HORARIOS_AGENDA_SCMA', 'Sim'),
              'N', pkg_rmi_traducao.extrair_pkg_msg('MSG_2', 'VDIC_HORARIOS_AGENDA_SCMA', 'Não'),
              IT_AGENDA_CENTRAL.SN_ANESTESISTA),
       IT_AGENDA_CENTRAL.CD_ANESTESISTA,
       ANESTESISTA.NM_PRESTADOR,
       IT_AGENDA_CENTRAL.DS_OBSERVACAO,
       IT_AGENDA_CENTRAL.CD_SOLIC_AGENDAMENTO,
       IT_AGENDA_CENTRAL.DS_SENHA_PAINEL,
       DECODE(IT_AGENDA_CENTRAL.SN_DISPENSA_EQUIPAMENTOS,
              'S', pkg_rmi_traducao.extrair_pkg_msg('MSG_1', 'VDIC_HORARIOS_AGENDA_SCMA', 'Sim'),
              'N', pkg_rmi_traducao.extrair_pkg_msg('MSG_2', 'VDIC_HORARIOS_AGENDA_SCMA', 'Não'),
              IT_AGENDA_CENTRAL.SN_DISPENSA_EQUIPAMENTOS),
       IT_AGENDA_CENTRAL.CD_AGENDA_FILA_ESPERA,
       IT_AGENDA_CENTRAL.CD_USUARIO,
       USUARIOS.NM_USUARIO,
       IT_AGENDA_CENTRAL.TP_SITUACAO,
       IT_AGENDA_CENTRAL.CD_ATENDIMENTO,
       AGENDA_CENTRAL.SN_ATIVO,
       IT_AGENDA_CENTRAL.DS_OBSERVACAO_GERAL,
       it_agenda_central.nr_ddi_celular,
       it_agenda_central.nr_ddd_celular,
       it_agenda_central.nr_celular,
       it_agenda_central.nr_ddd_fone,
       it_agenda_central.nr_ddi_telefone,
       it_agenda_central.cd_it_agenda_central,
       DECODE(agenda_central.sn_falta,
              'S',
              'S',
              agenda_central.sn_falta) sn_falta,
       DECODE(it_agenda_central.sn_encaixe,
              'S', pkg_rmi_traducao.extrair_pkg_msg('MSG_1', 'VDIC_HORARIOS_AGENDA_SCMA', 'Sim'),
              'N', pkg_rmi_traducao.extrair_pkg_msg('MSG_2', 'VDIC_HORARIOS_AGENDA_SCMA', 'Não'),
              it_agenda_central.sn_encaixe)
  FROM DBAMV.V_AGENDA_CENTRAL_GUPO_PAC,
       DBAMV.IT_AGENDA_CENTRAL,
       DBAMV.GRUPO_AGENDA,
       DBAMV.SER_DIS,
       DBAMV.TIP_MAR,
       DBASGU.USUARIOS,
       DBAMV.AGENDA_CENTRAL,
       DBAMV.PRESTADOR,
       DBAMV.RECURSO_CENTRAL,
       DBAMV.UNIDADE_ATENDIMENTO,
       DBAMV.SETOR,
       DBAMV.ITEM_AGENDAMENTO,
       DBAMV.PRESTADOR ANESTESISTA,
     dbamv.item_agendmto_item_agen_ctral
 WHERE AGENDA_CENTRAL.CD_PRESTADOR              = PRESTADOR.CD_PRESTADOR (+)
   AND AGENDA_CENTRAL.CD_RECURSO_CENTRAL        = RECURSO_CENTRAL.CD_RECURSO_CENTRAL (+)
   AND AGENDA_CENTRAL.CD_UNIDADE_ATENDIMENTO    = UNIDADE_ATENDIMENTO.CD_UNIDADE_ATENDIMENTO (+)
   AND AGENDA_CENTRAL.CD_AGENDA_CENTRAL         = IT_AGENDA_CENTRAL.CD_AGENDA_CENTRAL
   AND ITEM_AGENDAMENTO.CD_ITEM_AGENDAMENTO(+)  = IT_AGENDA_CENTRAL.CD_ITEM_AGENDAMENTO
   AND it_agenda_central.cd_it_agenda_central  = item_agendmto_item_agen_ctral.cd_it_agenda_central(+) -- OP 47580
   AND AGENDA_CENTRAL.CD_SETOR                  = SETOR.CD_SETOR
   AND IT_AGENDA_CENTRAL.CD_GRUPO_AGENDA        = GRUPO_AGENDA.CD_GRUPO_AGENDA
   AND IT_AGENDA_CENTRAL.CD_SER_DIS             = SER_DIS.CD_SER_DIS (+)
   AND IT_AGENDA_CENTRAL.CD_TIP_MAR             = TIP_MAR.CD_TIP_MAR (+)
   AND IT_AGENDA_CENTRAL.CD_USUARIO             = USUARIOS.CD_USUARIO (+)
   AND V_AGENDA_CENTRAL_GUPO_PAC.CD_IT_AGENDA_CENTRAL = IT_AGENDA_CENTRAL.CD_IT_AGENDA_CENTRAL
   AND IT_AGENDA_CENTRAL.CD_ANESTESISTA      = ANESTESISTA.CD_PRESTADOR
   AND IT_AGENDA_CENTRAL.CD_GRUPO_AGENDA IS NOT NULL
   AND IT_AGENDA_CENTRAL.CD_IT_AGENDA_PAI IS NULL
   AND AGENDA_CENTRAL.CD_MULTI_EMPRESA = 1

