SELECT
    prestador.nm_prestador,
    ori_ate.ds_ori_ate,
    COUNT(*)
FROM
    atendime atendime
    inner join paciente on paciente.cd_paciente = atendime.cd_paciente
    inner join ori_ate on ori_ate.cd_ori_ate = atendime.cd_ori_ate
    inner join prestador on prestador.cd_prestador = atendime.cd_prestador
WHERE
        atendime.cd_prestador LIKE '226'
    AND atendime.dt_atendimento BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/01/2024', 'DD/MM/YYYY')
    AND atendime.tp_atendimento like 'A'
    AND cd_procedimento like '0301010072'
group by 
    prestador.nm_prestador,
    ori_ate.ds_ori_ate;
