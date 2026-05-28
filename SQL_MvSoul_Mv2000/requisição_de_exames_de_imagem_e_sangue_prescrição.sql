-- Requisição de Exames de imagem na prescrição
SELECT
                atendime.cd_atendimento        AS atendimento,
                paciente.cd_paciente           AS cad,
                paciente.nm_paciente           AS nome_do_paciente,
                pre_med.hr_pre_med             AS hora_da_solicitação,
                prestador.nm_prestador         AS solicitante,
                tip_presc.ds_tip_presc         AS exame_solicitado,
                unid_int.ds_unid_int           AS unidade_de_internacao,
                ped_rx.cd_ped_rx               AS pedido,
                laudo_rx.hr_laudo              AS data_do_laudo
            FROM
                    pre_med pre_med
                INNER JOIN itpre_med ON itpre_med.cd_pre_med = pre_med.cd_pre_med
                INNER JOIN atendime ON atendime.cd_atendimento = pre_med.cd_atendimento
                INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
                INNER JOIN tip_presc ON tip_presc.cd_tip_presc = itpre_med.cd_tip_presc
                INNER JOIN unid_int ON unid_int.cd_unid_int = pre_med.cd_unid_int
                INNER JOIN ped_rx ON ped_rx.cd_pre_med = pre_med.cd_pre_med
                INNER JOIN itped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
                LEFT JOIN laudo_rx ON laudo_rx.cd_ped_rx = ped_rx.cd_ped_rx
                INNER JOIN prestador On prestador.cd_prestador = pre_med.cd_prestador
            WHERE
                pre_med.cd_objeto LIKE '84'
                AND pre_med.dt_pre_med BETWEEN TO_DATE(:data_inicial, 'DD/MM/YYYY') AND TO_DATE(:data_final, 'DD/MM/YYYY')
                AND itpre_med.cd_tip_esq LIKE 'EXD'
                AND ped_rx.cd_set_exa IN ( '2', '4', '5', '6', '3', '24', '27', '28', '29', '32', '31' , '33' )

            GROUP BY
                atendime.cd_atendimento,
                paciente.cd_paciente,
                paciente.nm_paciente,
                pre_med.hr_pre_med,
                prestador.nm_prestador,
                tip_presc.ds_tip_presc,
                unid_int.ds_unid_int,
                ped_rx.dt_pedido,
                ped_rx.cd_ped_rx,
                laudo_rx.hr_laudo


-- Requisição de Exames de sangue na prescrição
SELECT
                vw_res_exames_pssd.cd_atendimento AS atendimento,
                vw_res_exames_pssd.cd_paciente    AS cad,
                paciente.nm_paciente              AS nome_do_paciente,
                vw_res_exames_pssd.hr_ped_lab     AS hora_da_solicitação,
                prestador.nm_prestador            AS solicitante,
                vw_res_exames_pssd.nm_exa_lab     AS exame_solicitado,
                vw_res_exames_pssd.cd_ped_lab     AS pedido,
                unid_int.ds_unid_int              AS unidade_de_internacao,
                vw_res_exames_pssd.hr_laudo       AS hora_do_laudo
            FROM
                vw_res_exames_pssd vw_res_exames_pssd
                LEFT JOIN leito ON leito.cd_leito = vw_res_exames_pssd.cd_leito
                LEFT JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
                INNER JOIN ped_lab ON ped_lab.cd_ped_lab = vw_res_exames_pssd.cd_ped_lab
                INNER JOIN prestador ON ped_lab.cd_prestador = prestador.cd_prestador
                INNER JOIN paciente ON paciente.cd_paciente = vw_res_exames_pssd.cd_paciente
            WHERE
                vw_res_exames_pssd.hr_ped_lab BETWEEN TO_DATE(:data_inicial, 'DD/MM/YYYY') AND TO_DATE(:data_final, 'DD/MM/YYYY')
            ORDER BY
                vw_res_exames_pssd.cd_atendimento,
                vw_res_exames_pssd.cd_ped_lab
