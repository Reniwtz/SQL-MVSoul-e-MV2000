SELECT
    atendime.cd_procedimento,
    count(atendime.cd_procedimento),
    procedimento_sus.ds_procedimento
FROM
         atendime atendime
    INNER JOIN paciente paciente ON atendime.cd_paciente = paciente.cd_paciente
    LEFT JOIN convenio convenio ON atendime.cd_convenio = convenio.cd_convenio
    LEFT JOIN cid cid ON atendime.cd_cid = cid.cd_cid
    LEFT JOIN same same ON same.cd_paciente = paciente.cd_paciente
    LEFT JOIN procedimento_sus procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/2022', 'DD/MM/YYYY') AND TO_DATE('31/12/2022', 'DD/MM/YYYY')
    AND ( cid.cd_cid LIKE 'C910'
          OR cid.cd_cid LIKE 'C920'
          OR cid.cd_cid LIKE 'C924'
          OR cid.cd_cid LIKE 'C925' )
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento
