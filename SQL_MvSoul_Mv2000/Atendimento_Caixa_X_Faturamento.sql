SELECT
    c.cd_atendimento AS cd_atendimento_caucao,
    c.nm_proprietario,
    c.dt_caucao      AS dt_caucao,
    c.vl_caucao,
    i.cd_atendimento AS cd_atendimento_itreg_amb,
    i.hr_lancamento
FROM
    (
        SELECT
            cd_atendimento,
            nm_proprietario,
            dt_caucao,
            vl_caucao
        FROM
            caucao
        WHERE
                dt_caucao >= TO_DATE('01/12/2024', 'DD/MM/YYYY')
            AND dt_caucao < TO_DATE('31/01/2026', 'DD/MM/YYYY') + 1
    )        c
    FULL OUTER JOIN (
        SELECT DISTINCT
            cd_atendimento,
            hr_lancamento
        FROM
            itreg_amb
    )        i ON i.cd_atendimento = c.cd_atendimento
    INNER JOIN atendime a ON a.cd_atendimento = nvl(c.cd_atendimento, i.cd_atendimento)
WHERE
        a.cd_convenio = 16
    AND a.dt_atendimento >= TO_DATE('01/12/2024', 'DD/MM/YYYY')
    AND a.dt_atendimento < TO_DATE('31/01/2026', 'DD/MM/YYYY') + 1
ORDER BY
    c.dt_caucao,
    nvl(c.cd_atendimento, i.cd_atendimento);
