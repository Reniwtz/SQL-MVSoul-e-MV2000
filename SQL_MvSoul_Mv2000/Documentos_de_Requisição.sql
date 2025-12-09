--REQUISIÇÃO DE EXAME DE SANGUE
SELECT
    pw_documento_clinico.cd_atendimento AS atendimento,
    pw_documento_clinico.cd_paciente    AS cad,
    pw_documento_clinico.dh_fechamento  hora_da_solicitação,
    pw_documento_clinico.cd_usuario     AS solicitante,
    pw_documento_clinico.nm_documento
FROM
         pw_documento_clinico pw_documento_clinico
    INNER JOIN pw_editor_clinico ON pw_editor_clinico.cd_documento_clinico = pw_documento_clinico.cd_documento_clinico
    INNER JOIN atendime ON atendime.cd_atendimento = pw_documento_clinico.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
WHERE
    pw_documento_clinico.dh_referencia BETWEEN TO_DATE('17/11/2025', 'DD/MM/YYYY') AND TO_DATE('17/11/2025', 'DD/MM/YYYY')
    AND pw_editor_clinico.cd_documento LIKE '233'
    AND pw_documento_clinico.cd_documento_cancelado IS NULL
    AND paciente.cd_paciente LIKE '436593'
    AND pw_documento_clinico.cd_objeto LIKE '105'
    AND pw_documento_clinico.tp_status LIKE '%FECHADO%'
GROUP BY
    pw_documento_clinico.cd_atendimento,
    pw_documento_clinico.cd_paciente,
    pw_documento_clinico.dh_fechamento,
    pw_documento_clinico.cd_usuario,
    pw_documento_clinico.nm_documento;

--------------------------------------------------------------------------------
--REQUISIÇÃO DE EXAME DE SANGUE NA PRESCRIÇÃO
--REQUISIÇÃO DE EXAME DE SANGUE NA PRESCRIÇÃO
SELECT
    atendime.cd_atendimento        AS atendimento,
    paciente.cd_paciente           AS cad,
    pre_med.hr_pre_med             AS hora_da_solicitação,
    pre_med.nm_usuario_autorizador AS solicitante,
    tip_presc.ds_tip_presc         AS exame_solicitado,
    vw_res_exames_pssd.cd_ped_lab  AS pedido,
    CASE
        WHEN vw_res_exames_pssd.dt_laudo IS NULL THEN
            'SEM LAUDO'
        ELSE
            to_char(vw_res_exames_pssd.dt_laudo, 'DD/MM/YYYY HH24:MI:SS')
    END                            AS data_do_laudo
FROM
         pre_med pre_med
    INNER JOIN itpre_med ON itpre_med.cd_pre_med = pre_med.cd_pre_med
    INNER JOIN atendime ON atendime.cd_atendimento = pre_med.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN tip_presc ON tip_presc.cd_tip_presc = itpre_med.cd_tip_presc
    INNER JOIN vw_res_exames_pssd ON vw_res_exames_pssd.cd_atendimento = atendime.cd_atendimento
WHERE
    pre_med.cd_objeto LIKE '84'
    AND paciente.cd_paciente LIKE '123616'
    AND pre_med.dt_pre_med BETWEEN TO_DATE('01/10/2025', 'DD/MM/YYYY') AND TO_DATE('07/12/2025', 'DD/MM/YYYY')
    AND itpre_med.cd_tip_esq LIKE 'EXL'
    AND vw_res_exames_pssd.hr_ped_lab = pre_med.hr_pre_med
GROUP BY
    atendime.cd_atendimento,
    paciente.cd_paciente,
    pre_med.hr_pre_med,
    pre_med.nm_usuario_autorizador,
    tip_presc.ds_tip_presc,
    vw_res_exames_pssd.cd_ped_lab,
    CASE
        WHEN vw_res_exames_pssd.dt_laudo IS NULL THEN
                'SEM LAUDO'
        ELSE
            to_char(vw_res_exames_pssd.dt_laudo, 'DD/MM/YYYY HH24:MI:SS')
    END
ORDER BY
    atendime.cd_atendimento,
    vw_res_exames_pssd.cd_ped_lab;

--------------------------------------------------------------------------------    
--REQUISIÇÃO DE EXAME DE IMAGEM NA PRESCRIÇÃO
SELECT
    atendime.cd_atendimento        AS atendimento,
    paciente.cd_paciente           AS cad,
    pre_med.hr_pre_med             AS hora_da_solicitação,
    pre_med.nm_usuario_autorizador AS solicitante,
    tip_presc.ds_tip_presc         AS exame_solicitado
FROM
         pre_med pre_med
    INNER JOIN itpre_med ON itpre_med.cd_pre_med = pre_med.cd_pre_med
    INNER JOIN atendime ON atendime.cd_atendimento = pre_med.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN tip_presc ON tip_presc.cd_tip_presc = itpre_med.cd_tip_presc
WHERE
    pre_med.cd_objeto LIKE '84'
    --AND paciente.cd_paciente LIKE '436593'
    AND pre_med.dt_pre_med BETWEEN TO_DATE('01/02/2025', 'DD/MM/YYYY') AND TO_DATE('25/03/2025', 'DD/MM/YYYY')
    AND itpre_med.cd_tip_esq LIKE 'EXD'
GROUP BY
    atendime.cd_atendimento,
    paciente.cd_paciente,
    pre_med.hr_pre_med,
    pre_med.nm_usuario_autorizador,
    tip_presc.ds_tip_presc;
