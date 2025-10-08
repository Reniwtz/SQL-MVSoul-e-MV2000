SELECT
    apac.nr_apac                         AS código_apac,
    to_char(apac.dt_inicial, 'dd/mm/yy') AS data_incial_apac,
    to_char(apac.dt_final, 'dd/mm/yy')   AS data_final_apac,
    paciente.nr_cpf                      AS cpf_do_paciente,
    paciente.nm_paciente                 AS nome_do_paciente,
    paciente.cd_paciente                 AS código_do_paciente,
    eve_siasus.cd_procedimento           AS procedimento,
    apac.tp_apac                         AS tp,
    eve_siasus.qt_lancada                AS qt,
    eve_siasus.sn_apac_principal         AS sn
FROM
    apac apac
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = apac.cd_fat_sia
    INNER JOIN paciente ON apac.cd_paciente = paciente.cd_paciente
    INNER JOIN eve_siasus ON apac.cd_apac = eve_siasus.cd_apac
WHERE
    apac.cd_remessa IN ( '1157', '1158', '1159' )
    AND apac.cd_fat_sia = '559'
    AND fat_sia.tipo_fatura = 'APAC'
    AND apac.cd_tip_ate = '29'
    AND apac.dt_final > TO_DATE('30/09/2025', 'DD/MM/YYYY')
    AND APAC.cd_tip_ate = '29'
    AND apac.cd_motivo_cobranca_p321 = '21'
    AND paciente.cd_paciente NOT IN (
        SELECT
            atendime.cd_paciente  --- este select verifica os pacientes que vieram para ser atendido.
        FROM
            atendime atendime
        WHERE
                atendime.cd_ori_ate = '17'
            AND atendime.cd_convenio = '2'
            AND atendime.dt_atendimento BETWEEN TO_DATE('01/09/2025', 'DD/MM/YYYY') AND TO_DATE('30/09/2025', 'DD/MM/YYYY')
    )
GROUP BY
    apac.nr_apac,
    to_char(apac.dt_inicial, 'dd/mm/yy'),
    to_char(apac.dt_final, 'dd/mm/yy'),
    paciente.nr_cpf,
    paciente.nm_paciente,
    paciente.cd_paciente,
    eve_siasus.cd_procedimento,
    apac.tp_apac,
    eve_siasus.qt_lancada,
    eve_siasus.sn_apac_principal
ORDER BY
    paciente.nm_paciente,
    apac.tp_apac;
