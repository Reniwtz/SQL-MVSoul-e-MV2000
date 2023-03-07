SELECT
    t1.cd_procedimento                                     AS código,
    t3.ds_procedimento                                     AS descrição,
    t2.qt_fisico                                           AS orçado,
    COUNT(t1.cd_procedimento)                              AS lançada,
    ( t2.qt_fisico - COUNT(t1.cd_procedimento) )           AS resta,
    ( ( COUNT(t1.cd_procedimento) / t2.qt_fisico ) * 100)  AS porcentagem
FROM
    eve_siasus                   t1,
    teto_orcamentario_proced_sus t2,
    procedimento_sus             t3
WHERE
    t1.cd_procedimento IN (
        SELECT
            cd_procedimento
        FROM
            procedimento_sus
    )
    AND t1.cd_fat_sia IN (
        SELECT
            cd_fat_sia
        FROM
            fat_sia
        WHERE
            to_char(dt_periodo_inicial, 'MM/YYYY') = '03/2023'
    )
    AND to_char(t1.dt_eve_siasus, 'mm/yyyy') = '03/2023'
    AND t2.cd_fat_sia IN (
        SELECT
            cd_fat_sia
        FROM
            fat_sia
        WHERE
            to_char(dt_periodo_inicial, 'mm/yyyy') = '03/2023'
    )
    AND t1.cd_procedimento = t2.cd_procedimento
    AND t1.cd_procedimento = t3.cd_procedimento
    AND t1.qt_lancada <> 0
GROUP BY
    t1.cd_procedimento,
    t3.ds_procedimento,
    t2.qt_fisico
ORDER BY
    t1.cd_procedimento
