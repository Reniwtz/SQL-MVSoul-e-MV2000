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
WITH
-- 1) PRIMEIRA CONSULTA (SOLICITAÇÕES DOS EXAMES) + NUMERAÇÃO
solicitacoes AS (
    SELECT
        solicitacoes_inner.atendimento,
        solicitacoes_inner.cad,
        solicitacoes_inner.hora_da_solicitacao,
        solicitacoes_inner.solicitante,
        solicitacoes_inner.exame_solicitado,
        solicitacoes_inner.pedido,
        solicitacoes_inner.unidade_de_internacao,
        ROW_NUMBER() OVER (
            ORDER BY
                solicitacoes_inner.atendimento,
                solicitacoes_inner.pedido,
                solicitacoes_inner.exame_solicitado
        ) AS rownumber
    FROM (
        SELECT DISTINCT
            atendime.cd_atendimento        AS atendimento,
            paciente.cd_paciente           AS cad,
            pre_med.hr_pre_med             AS hora_da_solicitacao,
            pre_med.nm_usuario_autorizador AS solicitante,
            tip_presc.ds_tip_presc         AS exame_solicitado,
            vw_res_exames_pssd.cd_ped_lab  AS pedido,
            unid_int.ds_unid_int           AS unidade_de_internacao
        FROM
                 pre_med pre_med
            INNER JOIN itpre_med
                    ON itpre_med.cd_pre_med = pre_med.cd_pre_med
            INNER JOIN atendime
                    ON atendime.cd_atendimento = pre_med.cd_atendimento
            INNER JOIN paciente
                    ON paciente.cd_paciente = atendime.cd_paciente
            INNER JOIN tip_presc
                    ON tip_presc.cd_tip_presc = itpre_med.cd_tip_presc
            INNER JOIN vw_res_exames_pssd
                    ON vw_res_exames_pssd.cd_atendimento = atendime.cd_atendimento
                   AND vw_res_exames_pssd.hr_ped_lab    = pre_med.hr_pre_med
            INNER JOIN unid_int
                    ON unid_int.cd_unid_int = pre_med.cd_unid_int
        WHERE
            pre_med.cd_objeto = '84'
            AND atendime.cd_atendimento = '4288216'
            AND pre_med.dt_pre_med BETWEEN
                TO_DATE('01/10/2025', 'DD/MM/YYYY') AND TO_DATE('31/12/2025', 'DD/MM/YYYY')
            AND itpre_med.cd_tip_esq = 'EXL'
    ) solicitacoes_inner
),

-- 2) SEGUNDA CONSULTA (LAUDOS DOS EXAMES) + NUMERAÇÃO
laudos AS (
    SELECT
        vw_res_exames_pssd.cd_atendimento,
        vw_res_exames_pssd.cd_ped_lab,
        vw_res_exames_pssd.dt_laudo,
        vw_res_exames_pssd.nm_exa_lab,
        ROW_NUMBER() OVER (
            ORDER BY
                vw_res_exames_pssd.cd_atendimento,
                vw_res_exames_pssd.cd_ped_lab,
                vw_res_exames_pssd.nm_exa_lab
        ) AS rownumber
    FROM vw_res_exames_pssd vw_res_exames_pssd
    WHERE
        vw_res_exames_pssd.cd_atendimento = '4288216'
)

-- 3) JUNTANDO LINHA A LINHA
SELECT
    solicitacoes.atendimento,
    solicitacoes.cad,
    solicitacoes.hora_da_solicitacao,
    solicitacoes.solicitante,
    solicitacoes.exame_solicitado,
    solicitacoes.pedido,
    solicitacoes.unidade_de_internacao,
    laudos.dt_laudo,
    laudos.nm_exa_lab
FROM
    solicitacoes solicitacoes
    JOIN laudos laudos
        ON laudos.rownumber = solicitacoes.rownumber
ORDER BY
    solicitacoes.atendimento,
    solicitacoes.pedido,
    solicitacoes.exame_solicitado;



-----------------------------------------------------------------------------------------
--REQUISIÇÃO DE EXAME DE SANGUE NA PRESCRIÇÃO
SELECT
    atendime.cd_atendimento        AS atendimento,
    paciente.cd_paciente           AS cad,
    pre_med.hr_pre_med             AS hora_da_solicitação,
    pre_med.nm_usuario_autorizador AS solicitante,
    tip_presc.ds_tip_presc         AS exame_solicitado,
    vw_res_exames_pssd.cd_ped_lab  AS pedido
FROM
         pre_med pre_med
    INNER JOIN itpre_med ON itpre_med.cd_pre_med = pre_med.cd_pre_med
    INNER JOIN atendime ON atendime.cd_atendimento = pre_med.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN tip_presc ON tip_presc.cd_tip_presc = itpre_med.cd_tip_presc
    INNER JOIN vw_res_exames_pssd ON vw_res_exames_pssd.cd_atendimento = atendime.cd_atendimento
WHERE
    pre_med.cd_objeto LIKE '84'
    --AND paciente.cd_paciente LIKE '123616'
    and atendime.cd_atendimento like '4288216'
    AND pre_med.dt_pre_med BETWEEN TO_DATE('01/10/2025', 'DD/MM/YYYY') AND TO_DATE('31/12/2025', 'DD/MM/YYYY')
    AND itpre_med.cd_tip_esq LIKE 'EXL'
    AND vw_res_exames_pssd.hr_ped_lab = pre_med.hr_pre_med
GROUP BY
    atendime.cd_atendimento,
    paciente.cd_paciente,
    pre_med.hr_pre_med,
    pre_med.nm_usuario_autorizador,
    tip_presc.ds_tip_presc,
    vw_res_exames_pssd.cd_ped_lab
ORDER BY
    atendime.cd_atendimento,
    vw_res_exames_pssd.cd_ped_lab;



SELECT
    vw_res_exames_pssd.cd_ped_lab,
    vw_res_exames_pssd.dt_laudo,
    vw_res_exames_pssd.nm_exa_lab
FROM
    vw_res_exames_pssd
WHERE
    cd_atendimento LIKE '4288216'
ORDER BY
    vw_res_exames_pssd.cd_ped_lab,
    vw_res_exames_pssd.nm_exa_lab


--------------------------------------------------------------------------------    
--REQUISIÇÃO DE EXAME DE IMAGEM NA PRESCRIÇÃO
SELECT
    atendime.cd_atendimento        AS atendimento,
    paciente.cd_paciente           AS cad,
    pre_med.hr_pre_med             AS hora_da_solicitação,
    pre_med.nm_usuario_autorizador AS solicitante,
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
WHERE
    pre_med.cd_objeto LIKE '84'
    --AND atendime.cd_atendimento LIKE '4079334'
    AND pre_med.dt_pre_med BETWEEN TO_DATE('01/12/2025', 'DD/MM/YYYY') AND TO_DATE('31/12/2025', 'DD/MM/YYYY')
    AND itpre_med.cd_tip_esq LIKE 'EXD'
    AND ped_rx.cd_set_exa IN ( '2', '4', '5', '6', '3', '24', '27', '28', '29', '32', '31' , '33' )
    --AND ped_rx.cd_ped_rx LIKE '1052023'
GROUP BY
    atendime.cd_atendimento,
    paciente.cd_paciente,
    pre_med.hr_pre_med,
    pre_med.nm_usuario_autorizador,
    tip_presc.ds_tip_presc,
    unid_int.ds_unid_int,
    ped_rx.dt_pedido,
    ped_rx.cd_ped_rx,
    laudo_rx.hr_laudo;

