SELECT a.nr_apac, a.cd_atendimento, a.cd_paciente, a.cd_fat_sia, a.tp_apac, a.cd_remessa, a.cd_ori_ate, e.qt_lancada
FROM dbamv.apac a , dbamv.eve_siasus e
WHERE e.cd_apac = a.cd_apac
AND e.sn_apac_principal = 'S'
AND e.qt_lancada = 0
AND a.cd_fat_sia =     ---informar codigo da fatura


SELECT
    e.cd_eventos,
    a.cd_apac,
    a.cd_fat_sia,
    a.tp_apac,
    e.qt_lancada
FROM
    apac       a,
    eve_siasus e
WHERE
        e.cd_apac = a.cd_apac
    AND a.nr_apac = '2525201066256'
ORDER BY
    1  



SELECT e.qt_lancada, e.* FROM audit_dbamv.eve_siasus  e WHERE cd_eventos = 5112440

   
SELECT e.qt_lancada, e.* FROM audit_dbamv.eve_siasus  e WHERE cd_eventos =   5086863

SELECT e.qt_lancada, e.* FROM audit_dbamv.eve_siasus  e WHERE cd_eventos = 5112441
