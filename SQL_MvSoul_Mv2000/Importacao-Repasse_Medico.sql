SELECT
    *
FROM
    desenv.src_ambsus a
WHERE
    a.comp = '06/2022';

UPDATE desenv.src_ambsus a
SET
    a.pagto = 'S'
WHERE
        a.comp = 'informar competencia, por exemplo (06/2022)'
    AND a.pagto IS NULL;
