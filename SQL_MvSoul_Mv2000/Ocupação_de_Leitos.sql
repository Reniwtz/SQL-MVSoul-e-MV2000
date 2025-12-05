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
    leito.ds_leito       AS leito,
    ds_resumo,
    CASE
        WHEN leito.tp_ocupacao IN ( 'O', 'E' ) THEN 'OCUPADO'
        WHEN leito.tp_ocupacao = 'V' THEN 'VAZIO'
    END AS tp_ocupacao,
    atendime.cd_paciente AS cad,
    paciente.nm_paciente AS nome_do_paciente,
    paciente.tp_sexo     AS sexo,
    unid_int.ds_unid_int AS unidade_de_internacao
FROM
    leito
    INNER JOIN atendime ON atendime.cd_leito = leito.cd_leito
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
WHERE
    leito.tp_situacao = 'A'
    AND leito.tp_ocupacao <> 'T'
    AND atendime.hr_alta_medica IS NULL
    AND atendime.hr_alta IS NULL
    AND atendime.tp_atendimento = 'I'
    AND leito.cd_unid_int IN ( '1', '2', '3', '4', '6', '7', '8', '9', '10' )
    AND leito.cd_leito <> '435'

UNION ALL

SELECT
    leito.ds_leito       AS leito,
    ds_resumo,
    CASE
        WHEN leito.tp_ocupacao IN ( 'O', 'E' ) THEN 'OCUPADO'
        WHEN leito.tp_ocupacao = 'V' THEN 'VAZIO'
    END AS tp_ocupacao,
    CAST(NULL AS NUMBER) AS cad,
    ''                   AS nome_do_paciente,
    ''                   AS sexo,
    unid_int.ds_unid_int AS unidade_de_internacao
FROM
    leito
    INNER JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
WHERE
    leito.tp_situacao = 'A'
    AND leito.tp_ocupacao <> 'T'
    AND leito.cd_unid_int IN ( '1', '2', '3', '4', '6', '7', '8', '9', '10' )
    AND leito.cd_leito <> '435'
    AND NOT EXISTS (
        SELECT 1
        FROM atendime a
        WHERE a.cd_leito = leito.cd_leito
          AND a.hr_alta_medica IS NULL
          AND a.hr_alta IS NULL
          AND a.tp_atendimento = 'I'
    )

ORDER BY
    leito;

----------------------------------------------------------------------------------
SELECT
    CASE
        WHEN unid_int.ds_unid_int IS NULL THEN 'Total'
        ELSE unid_int.ds_unid_int
    END AS localizacao,
    COUNT(*) AS total,
    SUM(CASE WHEN leito.tp_ocupacao = 'V' THEN 1 ELSE 0 END)        AS livre,
    SUM(CASE WHEN leito.tp_ocupacao IN ('O','E') THEN 1 ELSE 0 END) AS ocupado
FROM
    leito
    INNER JOIN unid_int ON unid_int.cd_unid_int = leito.cd_unid_int
WHERE
    leito.tp_situacao = 'A'
    AND leito.tp_ocupacao <> 'T'
    AND leito.cd_unid_int IN ('1','2','3','4','6','7','8','9','10')
    AND leito.cd_leito <> '435'
GROUP BY ROLLUP (unid_int.ds_unid_int)
ORDER BY
    CASE WHEN unid_int.ds_unid_int IS NULL THEN 1 ELSE 0 END,  -- deixa o Total por último
    unid_int.ds_unid_int;
