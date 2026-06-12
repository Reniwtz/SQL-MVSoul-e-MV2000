SELECT
    cd_documento_clinico,
    TO_CHAR(dh_criacao, 'YYYY-MM-DD HH24:MI:SS') AS dh_criacao,
    TO_CHAR(dh_fechamento, 'YYYY-MM-DD HH24:MI:SS') AS dh_fechamento,

    CASE
        WHEN dh_fechamento IS NOT NULL THEN
            TRUNC(dh_fechamento - dh_criacao) || ' dia(s) ' ||
            LPAD(TRUNC(MOD((dh_fechamento - dh_criacao) * 24, 24)), 2, '0') || ':' ||
            LPAD(TRUNC(MOD((dh_fechamento - dh_criacao) * 24 * 60, 60)), 2, '0') || ':' ||
            LPAD(TRUNC(MOD((dh_fechamento - dh_criacao) * 24 * 60 * 60, 60)), 2, '0')
        ELSE
            'Documento sem fechamento'
    END AS tempo_criacao_fechamento

FROM
    pw_documento_clinico
WHERE
    cd_tipo_documento = '18'
    AND dh_criacao >= TO_DATE('01/01/2026', 'DD/MM/YYYY')
    AND dh_criacao < TO_DATE('12/06/2026', 'DD/MM/YYYY') + 1;
