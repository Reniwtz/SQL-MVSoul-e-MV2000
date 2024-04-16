SELECT
    atendime.cd_paciente,
    paciente.nm_paciente,
    paciente.dt_nascimento
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN procedimento_sus ON procedimento_sus.cd_procedimento = atendime.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/22', 'DD/MM/YY') AND TO_DATE('31/12/22', 'DD/MM/YY')
    AND atendime.cd_procedimento LIKE '0304010413'
    AND EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM dt_nascimento) >= 80
GROUP BY
    atendime.cd_paciente,
    paciente.nm_paciente,
    paciente.dt_nascimento;


-----------------------------------------------------------------------------------------------------

SELECT
    atendime.cd_paciente,
    paciente.dt_nascimento,
    grau_ins.ds_grau_ins,
    paciente.ds_endereco,
    cidade.nm_cidade,
    paciente.tp_estado_civil,
    raca_cor.nm_raca_cor
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN procedimento_sus ON procedimento_sus.cd_procedimento = atendime.cd_procedimento
    INNER JOIN grau_ins ON grau_ins.cd_grau_ins = paciente.cd_grau_ins
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
    INNER JOIN raca_cor ON raca_cor.tp_cor = paciente.tp_cor
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/22', 'DD/MM/YY') AND TO_DATE('31/12/22', 'DD/MM/YY')
    AND atendime.cd_procedimento LIKE '0304010456'
    AND EXTRACT(YEAR FROM sysdate) - EXTRACT(YEAR FROM dt_nascimento) >= 60
GROUP BY
    atendime.cd_paciente,
    paciente.dt_nascimento,
    grau_ins.ds_grau_ins,
    paciente.ds_endereco,
    cidade.nm_cidade,
    paciente.tp_estado_civil,
    raca_cor.nm_raca_cor
