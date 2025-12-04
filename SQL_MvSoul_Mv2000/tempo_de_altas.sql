
SELECT
    aux.cd_atendimento                                   AS atendimento,
    aux.cd_paciente                                      AS cadastro_paciente,
    aux.nm_paciente                                      AS nome_do_paciente,
    aux.ds_unid_int                                      AS unidade_de_internação,
    to_char(aux.alta_medica_dt, 'YYYY-MM-DD HH24:MI:SS') AS alta_medica,
    to_char(aux.alta_hosp_dt, 'YYYY-MM-DD HH24:MI:SS')   AS alta_hospitalar,
    CASE
        WHEN aux.alta_hosp_dt >= aux.alta_medica_dt THEN
            '+'
            || trunc(aux.alta_hosp_dt - aux.alta_medica_dt)
            || ' '
            || to_char(TO_DATE('00:00', 'HH24:MI') + mod(aux.alta_hosp_dt - aux.alta_medica_dt, 1), 'HH24:MI')
        ELSE
            '-'
            || trunc(aux.alta_medica_dt - aux.alta_hosp_dt)
            || ' '
            || to_char(TO_DATE('00:00', 'HH24:MI') + mod(aux.alta_medica_dt - aux.alta_hosp_dt, 1), 'HH24:MI')
    END                                                AS tempo_entre_altas
FROM
    (
        SELECT
            atendime.cd_atendimento,
            atendime.cd_paciente,
            paciente.nm_paciente,
            unid_int.ds_unid_int,
            atendime.hr_alta_medica                                           AS alta_medica_dt,
            atendime.dt_alta + ( atendime.hr_alta - trunc(atendime.hr_alta) ) AS alta_hosp_dt
        FROM
                 atendime atendime
            JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
            JOIN leito ON leito.cd_leito = atendime.cd_leito
            JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
        WHERE
            trunc(atendime.dt_atendimento) BETWEEN TO_DATE('01/10/2025', 'DD/MM/YYYY') AND TO_DATE('31/10/2025', 'DD/MM/YYYY')
            AND atendime.tp_atendimento = 'I'
            AND atendime.hr_alta_medica IS NOT NULL
            AND atendime.hr_alta IS NOT NULL
            AND leito.cd_unid_int IN ( '1', '2', '3', '4', '6',
                                       '7', '8', '9', '10' )
    ) aux
ORDER BY
    aux.cd_paciente;
