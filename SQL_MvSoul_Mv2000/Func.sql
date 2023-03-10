CREATE OR REPLACE Function hur3_fnc_painel_postos
  (P_Atendimento IN number,Tipo in Varchar2)

RETURN Char IS
Resposta Char(10);

cursor cResultadoExames is
---Resultados de Exames de Hoje---
select 1 ResultadoExame
  from Dbamv.Ped_Lab
     , Dbamv.ItPed_lab
     , Dbamv.Atendime
 where Ped_Lab.Cd_ped_Lab      = ItPed_lab.cd_ped_lab
   and Ped_Lab.cd_Atendimento  = Atendime.cd_atendimento
   and atendime.Cd_Atendimento = P_Atendimento
   and Ped_Lab.Cd_Atendimento  = P_Atendimento
   and ItPed_lab.Dt_Laudo between  Trunc(Sysdate) AND SYSDATE;

cursor cResultadoImagens is
---Resultados de Exames de Hoje---
select 1 ResultadoImagem
  from Dbamv.Ped_Rx
     , Dbamv.ItPed_Rx
     , Dbamv.Atendime
 where Ped_Rx.Cd_ped_Rx        = ItPed_Rx.cd_ped_Rx
   and Ped_Rx.cd_Atendimento   = Atendime.cd_atendimento
   AND atendime.Cd_Atendimento = P_Atendimento
   AND Ped_Rx.Cd_Atendimento   = P_Atendimento
   and ItPed_Rx.Dt_Realizado BETWEEN  Trunc(Sysdate) AND SYSDATE;

cursor cPrecaocaoAr is
---Precaucao de Ar---
SELECT 1 PrecauAr
  FROM Dbamv.Pendencia_Atendimento
     , Dbamv.Atendime
 WHERE Pendencia_Atendimento.cd_Atendimento = Atendime.cd_atendimento
   and atendime.cd_atendimento = P_Atendimento
   and Pendencia_Atendimento.cd_atendimento = P_Atendimento
   and Pendencia_Atendimento.Cd_Tipo_Pendencia = 35
   AND Pendencia_Atendimento.Dt_Baixa_Pendencia IS NULL;

cursor cPrecaucaoContato is
---Precaucao de Contato---
SELECT 1 PrecaucaoContato
  FROM Dbamv.Pendencia_Atendimento
     , Dbamv.Atendime
 WHERE Pendencia_Atendimento.cd_Atendimento = Atendime.cd_atendimento
   and atendime.cd_atendimento = P_Atendimento
   and Pendencia_Atendimento.cd_atendimento = P_Atendimento
   and Pendencia_Atendimento.Cd_Tipo_Pendencia = 36
   AND Pendencia_Atendimento.Dt_Baixa_Pendencia IS NULL;

cursor cPrecaucaoGoticula is
---Precaucao de Goticula---
SELECT 1 PrecaucaoGoticula
  FROM Dbamv.Pendencia_Atendimento
     , Dbamv.Atendime
 WHERE Pendencia_Atendimento.cd_Atendimento = Atendime.cd_atendimento
   AND atendime.cd_atendimento = P_Atendimento
   And Pendencia_Atendimento.Cd_Tipo_Pendencia = 37
   AND Pendencia_Atendimento.Dt_Baixa_Pendencia IS NULL
   And Pendencia_Atendimento.cd_atendimento = P_Atendimento;

cursor cAgendaEndoscopia is
-- Agenda de Endoscopia --
SELECT 1 Sn_Agenda_Bloco
   FROM Dbamv.Age_Cir
      , Dbamv.Aviso_Cirurgia
      , Dbamv.Atendime Atend
  WHERE Aviso_Cirurgia.Cd_Cen_Cir IN (0) --Endoscopia
    and Age_Cir.Cd_Aviso_Cirurgia     = Aviso_Cirurgia.Cd_Aviso_Cirurgia
    and Atend.Cd_Atendimento          = Aviso_Cirurgia.Cd_Atendimento
    AND Aviso_Cirurgia.Cd_Atendimento = P_Atendimento
    and atend.cd_atendimento          = P_Atendimento
    and Aviso_Cirurgia.Tp_Situacao    = 'G'
    and dt_inicio_age_cir BETWEEN Trunc(SYSDATE) AND SYSDATE;

cursor cAgendaHemodinamica is
-- Agenda de Hemodinamica --
SELECT 1 Sn_Agenda_Bloco
   FROM Dbamv.Age_Cir
      , Dbamv.Aviso_Cirurgia
      , Dbamv.Atendime Atend
  WHERE Aviso_Cirurgia.Cd_Cen_Cir IN (0) --Hemodinamica
    and Age_Cir.Cd_Aviso_Cirurgia     = Aviso_Cirurgia.Cd_Aviso_Cirurgia
    and Atend.Cd_Atendimento          = Aviso_Cirurgia.Cd_Atendimento
    AND Aviso_Cirurgia.Cd_Atendimento = P_Atendimento
    and atend.cd_atendimento          = P_Atendimento
    and Aviso_Cirurgia.Tp_Situacao    = 'G'
    and dt_inicio_age_cir BETWEEN  Trunc(SYSDATE) AND SYSDATE;

cursor cAgendaBlocoCirurgico is
-- Agenda Bloco Cirurgico--
SELECT 1 Sn_Agenda_Bloco
   FROM Dbamv.Age_Cir
      , Dbamv.Aviso_Cirurgia
      , Dbamv.Atendime Atend
  WHERE Aviso_Cirurgia.Cd_Cen_Cir IN (0) --Bloco Cirurgico
    and Age_Cir.Cd_Aviso_Cirurgia     = Aviso_Cirurgia.Cd_Aviso_Cirurgia
    and Atend.Cd_Atendimento          = Aviso_Cirurgia.Cd_Atendimento
    AND Aviso_Cirurgia.Cd_Atendimento = P_Atendimento
    and atend.cd_atendimento          = P_Atendimento
    and Aviso_Cirurgia.Tp_Situacao    = 'G'
    and dt_inicio_age_cir BETWEEN  Trunc(SYSDATE) AND SYSDATE;

---Protocolo Tev ---
cursor cProtocoloTev is
Select 1 Prot_Tev
 From Dbamv.Atendime
where atendime.cd_atendimento = P_Atendimento
  and exists (Select 'X'
                    From Dbamv.Registro_Documento
                       , Dbamv.Registro_Resposta
                       , Dbamv.Documento
                       , Dbamv.Atendime Atend
                   where Registro_Documento.Cd_Registro_Documento = Registro_Resposta.Cd_Registro_Documento
                     and Registro_Documento.Cd_Atendimento = Atendime.Cd_Atendimento
                     and Atend.Cd_Atendimento = Registro_Documento.Cd_Atendimento
                     AND Registro_Documento.Cd_Documento = Documento.Cd_Documento
                     and atend.cd_atendimento              = P_Atendimento
                     AND REGISTRO_DOCUMENTO.CD_ATENDIMENTO = P_ATENDIMENTO
                     AND Documento.TP_Documento = 'D'
                     AND Documento.Tp_Uso_Documento = 'M'
                     and Registro_Resposta.Cd_Pergunta_Doc in (0)--Pergunta do Documento de Protocolo
                     AND Registro_Resposta.DS_RESPOSTA IS NOT null
                     and Registro_Documento.sn_impresso <> 'C');

---Envolucao de Enfermagem---
cursor cEvolucaoEnfermagem is
Select 1 Evolucao_Enf
  From Dbamv.Atendime
 where atendime.cd_atendimento= P_Atendimento
  and not exists (select 'X'
                  from dbamv.pre_med p
                  where p.cd_atendimento = P_Atendimento
                    and trunc(p.dt_pre_med) = trunc(sysdate)
                    and p.ds_evolucao is not null
                    and p.cd_prestador in (select e.cd_prestador
                                             from dbamv.prestador e
                                            where e.cd_conselho = '2')); --Enfermeiro
/*cursor cEvolucaoEnfermagem is
Select 1 Evolucao_Enf
  From Dbamv.Atendime
 where atendime.cd_atendimento= P_Atendimento
   and not exists (Select 'X'
                     From Dbamv.Registro_Documento
                        , Dbamv.Documento
                        , Dbamv.Atendime Atend
                    where Registro_Documento.Cd_Documento   = Documento.Cd_Documento
                      and Registro_Documento.Cd_Atendimento = Atendime.Cd_Atendimento
                      and atend.cd_atendimento = P_Atendimento
                      and Atend.Cd_Atendimento = Registro_Documento.Cd_Atendimento
                      and Registro_documento.Dt_Registro BETWEEN  Trunc(sysdate)  AND SYSDATE -- Carlos andre -> Assim utiliza o indice
                      and Documento.Tp_Documento = 'E'
                      and Documento.Tp_Uso_Documento = 'E'
                      and Registro_Documento.sn_impresso = 'S');*/

---Evolucao Medica---
cursor cEvolucaoMedica is
Select 1 Evolucao_Med
  From Dbamv.Atendime
 where atendime.cd_atendimento = P_Atendimento
  and not exists (select 'X'
                  from dbamv.pre_med p
                  where p.cd_atendimento = P_Atendimento
                    and trunc(p.dt_pre_med) = trunc(sysdate)
                    and p.ds_evolucao is not null
                    and p.cd_prestador in (select e.cd_prestador
                                             from dbamv.prestador e
                                            where e.cd_conselho = '1')); --medico
-- alterado por Jobson Fagundes - dia 14/02/2013
/*cursor cEvolucaoMedica is
Select 1 Evolucao_Med
  From Dbamv.Atendime
 where atendime.cd_atendimento = P_Atendimento
   and not exists (Select 'X'
                     From Dbamv.Registro_Documento
                        , Dbamv.Documento
                        , Dbamv.Atendime Atend
                    where Registro_Documento.Cd_Documento = Documento.Cd_Documento
                      and Registro_Documento.Cd_Atendimento = Atendime.Cd_Atendimento
                      and Atend.Cd_Atendimento = Registro_Documento.Cd_Atendimento
                      and atend.cd_atendimento = P_Atendimento
                      and Registro_documento.Dt_Registro BETWEEN  Trunc(sysdate) AND sysdate
                      and Documento.Tp_Documento = 'E'
                      and Documento.Tp_Uso_Documento = 'M'
                      and Registro_Documento.sn_impresso = 'S');*/

---Prescricao M??dica---
cursor cPrescricaoMedica is
Select 1 Sn_Prescrito
  From Dbamv.Atendime
 where atendime.cd_atendimento= P_Atendimento
   and not exists (Select 'X'
                     From Dbamv.Pre_Med
                        , Dbamv.Atendime Atend
                    where Pre_Med.Dt_Pre_Med BETWEEN Trunc(SYSDATE) AND SYSDATE  --De hoje
                      and Pre_Med.Cd_Atendimento = Atendime.Cd_Atendimento
                      and atendime.cd_atendimento= P_Atendimento
                      and Pre_Med.Cd_Atendimento = Atend.Cd_Atendimento
                      and atend.dt_alta is null
                      and Atend.tp_atendimento = 'I'
                      and Pre_Med.Tp_Pre_Med = 'M'
                      and Pre_Med.Fl_Impresso = 'S');

--solicita????o pendente de pedidos de farmacia---
cursor cFarmaciaPedidos is
Select Distinct Case when (Round(((Sysdate-HrItP.Dh_Medicacao)*24)*60,0)+20) > 0 then 2 else 1 end Pedidos --(2 Medicacao com Atraso igual ou >20min, 1 Pedido na farmacia)
                 From Dbamv.Solsai_Pro   Solsa
                    , Dbamv.Atendime     Atend
                    , Dbamv.itsolsai_pro ItSol
                    , Dbamv.HrItPre_Med  HrItP
                where Atend.Cd_Atendimento = Solsa.Cd_Atendimento
                  and atend.cd_atendimento = P_Atendimento
                  AND Solsa.Cd_Atendimento = P_Atendimento
                  and Solsa.cd_solsai_Pro  = ItSol.Cd_Solsai_Pro(+)
                  and ItSol.cd_itpre_med   = HrItP.Cd_Itpre_Med (+)
                  and Solsa.Tp_Situacao = 'P'
                  and Solsa.tp_solsai_pro in ('P','S');

--solicita????o pendente de devolucoes de farmacia---
cursor cFarmaciaDevolucao is
Select 1 Devolucao
  From Dbamv.Atendime
 where atendime.cd_atendimento = P_Atendimento
   and exists (Select 'X'
                From Dbamv.Solsai_Pro Solsa
                   , Dbamv.Atendime   Atend
               where SolSa.Cd_Atendimento = Atendime.Cd_Atendimento
                 and atend.cd_atendimento = P_Atendimento
                 AND Solsa.Cd_Atendimento = P_Atendimento
                 and Atend.Cd_Atendimento = Solsa.Cd_Atendimento
                 and Solsa.Tp_Situacao = 'P'
                 and Solsa.tp_solsai_pro in ('D','C'));

 ---Checagens Pendentes---
cursor cChecagemMedicacao is
SELECT 1 Checagem
  FROM Dbamv.HrItPre_Med       HrItPre_Med
     , Dbamv.ItPre_Med         ItPre_Med
     , Dbamv.tip_esq           Tip_Esq
     , Dbamv.Pre_Med           Pre_Med
     , Dbamv.Atendime          Atendime
     , Dbamv.Config_Pagu_setor Conf_Set
 WHERE HrItPre_Med.Cd_ItPre_Med  = ItPre_Med.Cd_ItPre_Med
   AND Tip_Esq.Cd_Tip_Esq        = ItPre_Med.Cd_Tip_Esq
   AND Pre_Med.Cd_Pre_Med        = ItPre_Med.Cd_Pre_Med
   AND Pre_Med.Cd_Setor          = Conf_Set.Cd_Setor
   and Atendime.Cd_Atendimento   = Pre_Med.Cd_Atendimento
   and atendime.cd_atendimento   = P_Atendimento
   AND Pre_Med.Tp_Pre_Med IN ('M','E')
   AND Tip_Esq.Tp_Checagem             = 'CC'
   AND Nvl(ItPre_Med.Tp_Situacao,'N')  = 'N'
   AND Nvl(ItPre_Med.Sn_Cancelado,'N') = 'N'
   AND ((sysdate-HrItPre_Med.Dh_Medicacao)*24)*60 >  Conf_Set.Qt_Atraso_Checagem --Maior que o tempo informado na configuracao
   AND sysdate-HrItPre_Med.Dh_Medicacao < 5 --Menor que 5 Dias
   AND NOT exists (SELECT 'X'
                     FROM Dbamv.Hritpre_Cons HrCons
                        , Dbamv.ItPre_Med    ItPreM
                        , Dbamv.Tip_esq      TipEsq
                        , Dbamv.Pre_Med      PreMed
                        , Dbamv.Atendime     Atend
                        , Dbamv.Config_Pagu_setor Conf_Set
                    WHERE HrCons.Cd_ItPre_Med   = ItPreM.Cd_ItPre_Med
                      AND TipEsq.Cd_Tip_Esq     = ItPreM.Cd_Tip_Esq
                      AND PreMed.Cd_Pre_Med     = ItPreM.Cd_Pre_Med
                      and Atend.Cd_Atendimento  = PreMed.Cd_Atendimento
                      AND PreMed.Cd_Pre_Med     = Pre_Med.Cd_Pre_Med
                      AND ItPreM.Cd_ItPre_Med   = HrItPre_Med.Cd_ItPre_Med
                      AND HrCons.Dh_Medicacao   = HrItPre_Med.Dh_Medicacao
                      AND Pre_Med.Cd_Setor      = Conf_Set.Cd_Setor
                      AND Premed.Cd_Atendimento = P_Atendimento
                      AND PreMed.Tp_Pre_Med IN ('M','E')
                      AND TipEsq.Tp_Checagem           = 'CC'
                      AND Nvl(ItPreM.Tp_Situacao,'N')  = 'N'
                      AND Nvl(ItPreM.Sn_Cancelado,'N') = 'N'
                      AND ((sysdate-HrItPre_Med.Dh_Medicacao)*24)*60 >  Conf_Set.Qt_Atraso_Checagem --Maior que o tempo informado na configuracao
                      AND sysdate-HrCons.Dh_Medicacao < 5); --Menor que 5 Dias

cursor cBalancoHidrico is
---Balanco Hidrico---
Select 1 Balancohidrico
  From dbamv.Balanco_Hidrico
     , dbamv.Atendime
 Where balanco_hidrico.cd_atendimento = Atendime.cd_atendimento
   and balanco_hidrico.cd_atendimento = P_Atendimento
   AND Atendime.Cd_Atendimento        = P_Atendimento
   and (sysdate-balanco_hidrico.dt_referencia)*24 > 24 --Maior que 24 Horas
   and (balanco_hidrico.cd_atendimento,to_char(balanco_hidrico.dt_referencia,'dd/mm/yyyy'))
       not in (select Balanco_Hidrico_Fechamento.Cd_atendimento
                   , to_char(balanco_hidrico_fechamento.dt_referencia,'dd/mm/yyyy')
                from Dbamv.balanco_Hidrico_Fechamento
                   , Dbamv.Atendime
               where balanco_hidrico_fechamento.cd_atendimento = atendime.cd_atendimento
                 and balanco_hidrico_fechamento.cd_atendimento = P_Atendimento
                 and balanco_Hidrico_Fechamento.Tp_Fechamento = 'T');

cursor cAltaMedica is
---Alta Medica---
Select 1 AltaMedica
  From dbamv.Atendime
 where Atendime.Cd_Atendimento = P_Atendimento
   and Atendime.Dt_Alta_medica is not NULL;

cursor cAvisoAlergiaDoc is
---Alergia Informada em Documento---
Select 1 AvisoAlergiaDoc
 From Dbamv.Atendime
where Atendime.Cd_Atendimento = P_Atendimento
  and exists (SELECT 'X'
                FROM Dbamv.Pergunta_doc
                  , Dbamv.Registro_resposta
                  , Dbamv.Registro_documento
                  , Dbamv.Atendime Atendime_Doc
                  , Dbamv.Documento
              WHERE pergunta_doc.cd_pergunta_doc = registro_resposta.cd_pergunta_doc
                AND registro_resposta.cd_registro_documento = registro_documento.cd_registro_documento
                AND registro_documento.cd_atendimento = Atendime_Doc.cd_atendimento AND REGISTRO_DOCUMENTO.CD_ATENDIMENTO = P_ATENDIMENTO
                AND registro_documento.cd_documento   = Documento.cd_Documento
                AND Atendime_Doc.Cd_Atendimento       = Atendime.Cd_Atendimento
                AND Atendime_Doc.Cd_Atendimento       = P_Atendimento
                AND Registro_documento.Cd_Atendimento = P_Atendimento
                and Registro_documento.Dt_Registro BETWEEN  atendime_doc.dt_atendimento  AND SYSDATE
                AND Pergunta_Doc.CD_PERGUNTA_DOC IN (0) ---Perguntas dos documentos que se referenm a ALERGIAS
                AND Documento.Tp_Documento = 'E'
                AND Documento.Tp_Uso_Documento = 'E'
                and Registro_resposta.ds_resposta is not null
                and Registro_Documento.sn_impresso <> 'C'
                );

Cursor cAvisoAlergiaTela is
---Alergia Informada em Tela de Atendimento---
Select 1 AvisoAlergiaTela
 From Dbamv.Atendime
where Atendime.Cd_Atendimento = P_Atendimento
  and exists (Select Atend.Cd_Atendimento
                FROM Dbamv.Subs_Pac
                   , Dbamv.Atendime Atend
               WHERE Subs_Pac.Cd_Paciente    = Atend.Cd_Paciente
                 AND Atend.Cd_Paciente       = Atendime.cd_Paciente
                 AND Atendime.Cd_Atendimento = P_Atendimento);

---Monitoramento (Equipamento e Gases)---
Cursor cMonitoramento is
Select 1 Monitoramento
  From Dbamv.Mvto_Gases
     , Dbamv.Atendime Atend
 WHERE Mvto_Gases.Cd_Atendimento = Atend.Cd_Atendimento
   AND atend.cd_atendimento      = P_Atendimento
   AND Mvto_Gases.cd_atendimento = P_Atendimento
   AND Mvto_Gases.Hr_Desliga IS NULL;

---Proximo Horario da Medicazcao---
Cursor cProximohorario is
SELECT To_Char(HrItPre_Med.Dh_Medicacao,'hh24:mi') ProximoHorario
  FROM Dbamv.HrItPre_Med       HrItPre_Med
     , Dbamv.ItPre_Med         ItPre_Med
     , Dbamv.tip_esq           Tip_Esq
     , Dbamv.Pre_Med           Pre_Med
     , Dbamv.Atendime          Atendime
     , Dbamv.Config_Pagu_setor Conf_Set
 WHERE HrItPre_Med.Cd_ItPre_Med = ItPre_Med.Cd_ItPre_Med
   AND Tip_Esq.Cd_Tip_Esq       = ItPre_Med.Cd_Tip_Esq
   AND Pre_Med.Cd_Pre_Med       = ItPre_Med.Cd_Pre_Med
   AND Pre_Med.Cd_Setor         = Conf_Set.Cd_Setor
   and Atendime.Cd_Atendimento  = Pre_Med.Cd_Atendimento
   AND Pre_Med.Cd_Atendimento   = P_Atendimento
   AND Pre_Med.Tp_Pre_Med IN ('M','E')
   AND Tip_Esq.Tp_Checagem             = 'CC'
   AND Nvl(ItPre_Med.Tp_Situacao,'N')  = 'N'
   AND Nvl(ItPre_Med.Sn_Cancelado,'N') = 'N'
   AND Trunc(SYSDATE)=Trunc(HrItPre_Med.Dh_Medicacao) --medicacao de hoje
   AND HrItPre_Med.Dh_Medicacao >= SYSDATE --Veifica o proximo horario desconsiderando as checagem atrasadas
   AND NOT exists (SELECT 'X'
                     FROM Dbamv.Hritpre_Cons HrCons
                        , Dbamv.ItPre_Med    ItPreM
                        , Dbamv.Tip_esq      TipEsq
                        , Dbamv.Pre_Med      PreMed
                        , Dbamv.Atendime     Atend
                        , Dbamv.Config_Pagu_setor Conf_Set
                    WHERE HrCons.Cd_ItPre_Med   = ItPreM.Cd_ItPre_Med
                      AND TipEsq.Cd_Tip_Esq     = ItPreM.Cd_Tip_Esq
                      AND PreMed.Cd_Pre_Med     = ItPreM.Cd_Pre_Med
                      and Atend.Cd_Atendimento  = PreMed.Cd_Atendimento
                      AND PreMed.Cd_Pre_Med     = Pre_Med.Cd_Pre_Med
                      AND ItPreM.Cd_ItPre_Med   = HrItPre_Med.Cd_ItPre_Med
                      AND HrCons.Dh_Medicacao   = HrItPre_Med.Dh_Medicacao
                      AND Pre_Med.Cd_Setor      = Conf_Set.Cd_Setor
                      AND Premed.Cd_Atendimento = P_Atendimento
                      AND PreMed.Tp_Pre_Med IN ('M','E')
                      AND TipEsq.Tp_Checagem           = 'CC'
                      AND Nvl(ItPreM.Tp_Situacao,'N')  = 'N'
                      AND Nvl(ItPreM.Sn_Cancelado,'N') = 'N'
                      AND Trunc(SYSDATE)=Trunc(HrItPre_Med.Dh_Medicacao)) --Medicacao de hoje
                      AND HrItPre_Med.Dh_Medicacao >= SYSDATE --Veifica o proximo horario desconsiderando as checagem atrasadas
    ORDER BY 1;

---Aprazamento de Horario da Medicazcao---
Cursor cAprazamento is
SELECT 1 Aprazamento
  FROM Dbamv.HrItPre_Med       HrItPre_Med
     , Dbamv.ItPre_Med         ItPre_Med
     , Dbamv.tip_esq           Tip_Esq
     , Dbamv.Pre_Med           Pre_Med
     , Dbamv.Atendime          Atendime
     , Dbamv.Config_Pagu_setor Conf_Set
 WHERE HrItPre_Med.Cd_ItPre_Med(+) = ItPre_Med.Cd_ItPre_Med
   AND Tip_Esq.Cd_Tip_Esq          = ItPre_Med.Cd_Tip_Esq
   AND Pre_Med.Cd_Pre_Med          = ItPre_Med.Cd_Pre_Med
   AND Pre_Med.Cd_Setor            = Conf_Set.Cd_Setor
   and Atendime.Cd_Atendimento     = Pre_Med.Cd_Atendimento
   AND Pre_Med.Cd_Atendimento      = P_Atendimento
   AND Pre_Med.Tp_Pre_Med IN ('M','E')
   AND Tip_Esq.Tp_Checagem             = 'CC'
   AND Nvl(ItPre_Med.Tp_Situacao,'N')  = 'N'
   AND Nvl(ItPre_Med.Sn_Cancelado,'N') = 'N'
   AND HrItPre_Med.Cd_ItPre_Med Is NULL; -- Medicamentos N??o Aprazados

---Prescricao Aberta---
Cursor cPrescricaoaberta is
SELECT 1 PrescricaoAberta
  FROM Dbamv.Pre_Med           Pre_Med
     , Dbamv.Atendime          Atendime
 WHERE Atendime.Cd_Atendimento     = Pre_Med.Cd_Atendimento
   AND Pre_Med.Cd_Atendimento      = P_Atendimento
   AND Pre_Med.Tp_Pre_Med IN ('M','E')
   AND Nvl(Pre_Med.Sn_Fechado,'N') = 'N'; --Prescricao Aberta  select * from pre_med

BEGIN
if Tipo='CHECAGEMMEDICACAO' then
  open cChecagemMedicacao;
 fetch cChecagemMedicacao into Resposta;
 close cChecagemMedicacao;
end if;

if Tipo='FARMACIAPEDIDOS' then
  open cFarmaciaPedidos;
 fetch cFarmaciaPedidos into resposta;
 close cFarmaciaPedidos;
end if;

if Tipo='PRESCRICAOMEDICA' then
  open cPrescricaoMedica;
 fetch cPrescricaoMedica into Resposta;
 close cPrescricaoMedica;
end if;

if Tipo='EVOLUCAOMEDICA' then
  open cEvolucaoMedica;
 fetch cEvolucaoMedica into Resposta;
 close cEvolucaoMedica;
end if;

if Tipo='EVOLUCAOENFERMAGEM' then
  open cEvolucaoEnfermagem;
 fetch cEvolucaoEnfermagem into Resposta;
 close cEvolucaoEnfermagem;
end if;

if Tipo='PROTOCOLOTEV' then
  open cProtocoloTev;
 fetch cProtocoloTev into Resposta;
 close cProtocoloTev;
end if;

if Tipo='AGENDABLOCOCIRURGICO' then
  open cAgendaBlocoCirurgico;
 fetch cAgendaBlocoCirurgico into Resposta;
 close cAgendaBlocoCirurgico;
end if;

if Tipo='AGENDAHEMODINAMICA' then
  open cAgendaHemodinamica;
 fetch cAgendaHemodinamica into Resposta;
 close cAgendaHemodinamica;
end if;

if Tipo='AGENDAENDOSCOPIA' then
  open cAgendaEndoscopia;
 fetch cAgendaEndoscopia into Resposta;
 close cAgendaEndoscopia;
end if;

if Tipo='PRECAUCAOGOTICULA' then
  open cPrecaucaoGoticula;
 fetch cPrecaucaoGoticula into Resposta;
 close cPrecaucaoGoticula;
end if;

if Tipo='PRECAUCAOCONTATO' then
  open cPrecaucaoContato;
 fetch cPrecaucaoContato into Resposta;
 close cPrecaucaoContato;
end if;

if Tipo='PRECAUCAOAR' then
  open cPrecaocaoAr;
 fetch cPrecaocaoAr into Resposta;
 close cPrecaocaoAr;
end if;

if Tipo='AVISOALERGIADOC' then
  open cAvisoAlergiaDoc;
 fetch cAvisoAlergiaDoc into Resposta;
 close cAvisoAlergiaDoc;
end if;

if Tipo='RESULTADOEXAMES' then
  open cResultadoExames;
 fetch cResultadoExames into Resposta;
 close cResultadoExames;
end if;

if Tipo='FARMACIADEVOLUCAO' then
  open cFarmaciaDevolucao;
 fetch cFarmaciaDevolucao into Resposta;
 close cFarmaciaDevolucao;
end if;

if Tipo='BALANCOHIDRICO' then
  open cBalancoHidrico;
 fetch cBalancoHidrico into Resposta;
 close cBalancoHidrico;
end if;

if Tipo='ALTAMEDICA' then
  open cAltaMedica;
 fetch cAltaMedica into Resposta;
 close cAltaMedica;
end if;

if Tipo='AVISOALERGIATELA' then
  open cAvisoAlergiaTela;
 fetch cAvisoAlergiaTela into Resposta;
 close cAvisoAlergiaTela;
end if;

if Tipo='RESULTADOIMAGENS' then
  open cResultadoImagens;
 fetch cResultadoImagens into Resposta;
 close cResultadoImagens;
end if;

if Tipo='MONITORAMENTO' then
  open cMonitoramento;
 fetch cMonitoramento into Resposta;
 close cMonitoramento;
end if;

if Tipo='PROXIMOHORARIO' then
  open cProximohorario;
 fetch cProximohorario into Resposta;
 close cProximohorario;
end if;

if Tipo='APRAZAMENTO' then
  open cAprazamento;
 fetch cAprazamento into Resposta;
 close cAprazamento;
end if;

if Tipo='PRESCRICAOABERTA' then
  open cPrescricaoaberta;
 fetch cPrescricaoaberta into Resposta;
 close cPrescricaoaberta;
end if;

return Resposta;
END;
