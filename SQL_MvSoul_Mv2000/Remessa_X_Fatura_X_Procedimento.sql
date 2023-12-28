SELECT
    eve_siasus.cd_paciente, eve_siasus.cd_atendimento
FROM
         fat_sia fat_sia
    INNER JOIN eve_siasus ON fat_sia.cd_fat_sia = eve_siasus.cd_fat_sia
    INNER JOIN atendime on eve_siasus.cd_atendimento = atendime.cd_atendimento
WHERE
    --fat_sia.dt_periodo_inicial BETWEEN TO_DATE('01/12/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    fat_sia.tipo_fatura LIKE 'BPA'
    AND fat_sia.cd_fat_sia LIKE '517'
    AND ( eve_siasus.cd_remessa LIKE '1819'
          OR eve_siasus.cd_remessa LIKE '1821'
          OR eve_siasus.cd_remessa LIKE '1823' )
    AND eve_siasus.cd_procedimento like '0301010072'
