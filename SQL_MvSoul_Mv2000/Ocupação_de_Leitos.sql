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
