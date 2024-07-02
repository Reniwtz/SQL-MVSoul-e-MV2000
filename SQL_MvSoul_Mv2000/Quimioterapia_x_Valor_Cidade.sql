SELECT
    a.cd_atendimento,
    a.cd_ori_ate,
    p.cd_paciente,
    e.cd_procedimento,
    ps.ds_procedimento,
    psv.vl_total_ambulatorial--,a.sn_Atendimento_apac
FROM
    paciente               p,
    atendime               a,
    eve_siasus             e,
    procedimento_sus       ps,
    procedimento_sus_valor psv
WHERE
        p.cd_paciente = e.cd_paciente
    AND p.cd_paciente = a.cd_paciente
    AND e.cd_procedimento = ps.cd_procedimento
    AND ps.cd_procedimento = psv.cd_procedimento
    AND p.cd_cidade IN ( 2359, 2266, 2285, 2232, 2341, 2492, 2370, 2257, 2201 )
    AND a.cd_ori_ate IN ( 9, 12, 24, 17, 27, 28, 30, 26, 8 )
    AND e.dt_eve_siasus BETWEEN TO_DATE('31/05/2023', 'DD/MM/YYYY') AND TO_DATE('31/05/2024', 'DD/MM/YYYY')
    AND ps.ds_procedimento NOT LIKE '%RADIOTERAPIA%'
    AND ps.ds_procedimento NOT LIKE '%TOMOGRAFIA%'
    AND ps.ds_procedimento NOT LIKE '%RADIOGRAFIA%'
    AND PSV.DT_VIGENCIA LIKE TO_DATE('01/05/2024', 'DD/MM/YYYY')
    AND (  ps.ds_procedimento LIKE '%QUIMIO%'
          OR  ps.ds_procedimento LIKE '%HORMONIOTERAPIA%' 
          OR  ps.ds_procedimento LIKE '%INIBIDOR%' )
GROUP BY
    a.cd_atendimento,
    a.cd_ori_ate,
    p.cd_paciente,
    e.cd_procedimento,
    ps.ds_procedimento,
    psv.vl_total_ambulatorial;--,a.sn_Atendimento_apac;
