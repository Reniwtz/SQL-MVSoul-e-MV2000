SELECT
    decode(cd_unid_int, '1', 'Central de Enfermagem', '2', 'Enfermaria Pediatrica',
           '3', 'Enfermaria Hematologia', '4', 'Apartamentos', '5',
           'Hematologia', '6', 'UTI Adulto', '7', 'Urgência',
           '10', 'UTi Pediatrica') AS leitos,
    decode(tp_ocupacao, 'V', 'VAZIO', 'O', 'OCUPADO',
           'R', 'RESERVADO') AS ocupação,
    COUNT(*) AS total_leitos
FROM
    leito
WHERE
      dt_desativacao IS NULL
    AND cd_unid_int <> '5'
    AND tp_ocupacao <> 'T'
GROUP BY
    decode(cd_unid_int, '1', 'Central de Enfermagem', '2', 'Enfermaria Pediatrica',
           '3', 'Enfermaria Hematologia', '4', 'Apartamentos', '5',
           'Hematologia', '6', 'UTI Adulto', '7', 'Urgência',
           '10', 'UTi Pediatrica'),
    decode(tp_ocupacao, 'V', 'VAZIO', 'O', 'OCUPADO',
           'R', 'RESERVADO')
ORDER BY
    leitos; 


-----------------------------------------------------------------------------------
SELECT
    leito.ds_leito,
    ds_resumo,
    CASE
        WHEN leito.tp_ocupacao IN ( 'O' ) THEN
            'OCUPADO'
        WHEN leito.tp_ocupacao IN ( 'V' ) THEN
            'VAZIO'
        WHEN leito.tp_ocupacao IN ( 'E' ) THEN
            'OCUPADO'
    END                  AS tp_ocupacao,
    atendime.cd_paciente AS cad,
    paciente.nm_paciente AS nome_do_paciente,
    unid_int.ds_unid_int AS unidade_de_internação
FROM
         leito leito
    INNER JOIN atendime ON atendime.cd_leito = leito.cd_leito
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
WHERE
    leito.tp_situacao LIKE 'A'
    AND leito.tp_ocupacao <> 'T'
    AND leito.cd_unid_int <> '5'
    AND atendime.hr_alta_medica IS NULL
    AND atendime.hr_alta IS NULL
    AND atendime.tp_atendimento = 'I'
    AND leito.cd_unid_int <> '2'
ORDER BY
    leito.ds_leito;
