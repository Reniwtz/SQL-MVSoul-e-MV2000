SELECT
    apac.cd_paciente,
    paciente.nm_paciente,
    apac.nr_apac,
    apac.cd_fat_sia,
    fat_sia.ds_fat_sia,
    apac.cd_remessa,
    remessa_apac.ds_remessa,
    remessa_apac.dt_competencia_apresentacao
FROM
         apac apac
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = apac.cd_fat_sia
    INNER JOIN remessa_apac ON remessa_apac.cd_remessa = apac.cd_remessa
    INNER JOIN paciente ON paciente.cd_paciente = apac.cd_paciente
WHERE
    apac.cd_paciente IN ( '383499', '381845', '364853', '371916', '299329',
                          '385445', '377129', '382653', '171693', '357490',
                          '154138', '338751', '387829', '379361', '390036',
                          '183853', '373012', '182800' )
    AND fat_sia.cd_fat_sia IN ( '486', '487', '492', '490', '489',
                                '493', '488', '491' )
ORDER BY
    apac.cd_fat_sia


----------------------------------------------------------------------------
SELECT
    apac.nr_apac,
    apac.cd_atendimento,
    apac.cd_paciente,
    apac.cd_fat_sia,
    apac.tp_apac,
    apac.cd_remessa,
    apac.cd_ori_ate,
    eve_siasus.qt_lancada,
    remessa_apac.ds_remessa
FROM
         dbamv.apac apac
    INNER JOIN eve_siasus ON eve_siasus.cd_apac = apac.cd_apac
    INNER JOIN remessa_apac ON remessa_apac.cd_remessa = apac.cd_remessa
WHERE
        eve_siasus.sn_apac_principal = 'S'
    AND eve_siasus.qt_lancada = 1
    AND dt_eve_siasus BETWEEN TO_DATE('01/01/2026', 'DD/MM/YYYY') AND TO_DATE('31/12/2026', 'DD/MM/YYYY')
      --remessa_bpa.ds_remessa LIKE '%FATURADO%'
ORDER BY
    cd_fat_sia DESC
