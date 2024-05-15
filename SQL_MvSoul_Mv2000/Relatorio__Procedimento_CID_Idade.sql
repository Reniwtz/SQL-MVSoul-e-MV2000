SELECT
    eve_siasus.cd_paciente,
    paciente.nm_paciente,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12) AS idade
FROM
         apac apac
    INNER JOIN fat_sia ON apac.cd_fat_sia = fat_sia.cd_fat_sia
    INNER JOIN eve_siasus ON eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
    INNER JOIN paciente ON paciente.cd_paciente = eve_siasus.cd_paciente
WHERE
    apac.cd_cid_principal IN ( 'C701', 'C709', 'C710', 'C711', 'C712',
                               'C713', 'C714', 'C715', 'C716', 'C717',
                               'C718', 'C719', 'C720', 'C721', 'C722',
                               'C723', 'C724', 'C725', 'C728', 'C729',
                               'C751', 'C752', 'C753', 'D320', 'D321',
                               'D329', 'D333', 'D352', 'D353', 'D354',
                               'D420', 'D421', 'D429', 'D430', 'D431',
                               'D432', 'D433', 'D434', 'D437', 'D439',
                               'D443', 'D444', 'D445' )
    AND fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
    AND cd_procedimento LIKE '0304010502'
GROUP BY
    eve_siasus.cd_paciente,
    paciente.nm_paciente,
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12)
ORDER BY
    trunc(months_between(sysdate, paciente.dt_nascimento) / 12)

