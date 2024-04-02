SELECT 
    paciente.nm_paciente, 
    convenio.nm_convenio, 
    paciente.tp_sexo, 
    paciente.dt_nascimento,
    TRUNC(MONTHS_BETWEEN(SYSDATE, paciente.dt_nascimento) / 12) AS idade
FROM 
    atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
WHERE 
    atendime.dt_alta BETWEEN TO_DATE('01/03/2024', 'DD/MM/YYYY') AND TO_DATE('31/03/2024', 'DD/MM/YYYY')
    AND atendime.sn_obito = 'S'
order by
    TRUNC(MONTHS_BETWEEN(SYSDATE, paciente.dt_nascimento) / 12);
