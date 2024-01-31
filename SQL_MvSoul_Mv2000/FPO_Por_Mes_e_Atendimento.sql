SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    COUNT(atendime.cd_procedimento)  AS quant_bpa
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND ( tp_atendimento LIKE 'A'
          OR tp_atendimento LIKE 'E' )
    AND atendime.sn_atendimento_apac LIKE 'N'
    AND sn_retorno LIKE 'N'
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento
ORDER BY
    atendime.cd_procedimento;

--------------------------------------------------------------------------------
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    COUNT(atendime.cd_procedimento)  AS quant_proc_cirurgicos
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND ( atendime.cd_procedimento LIKE '0401010015'
          OR atendime.cd_procedimento LIKE '0404010121'
          OR atendime.cd_procedimento LIKE '0407040196'
          OR atendime.cd_procedimento LIKE '0417010060' )
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento
ORDER BY
    atendime.cd_procedimento;

--------------------------------------------------------------------------------
SELECT
    atendime.cd_procedimento         AS procedimento,
    procedimento_sus.ds_procedimento AS descricao,
    COUNT(atendime.cd_procedimento)  AS quant_apac
FROM
         atendime
    INNER JOIN procedimento_sus ON atendime.cd_procedimento = procedimento_sus.cd_procedimento
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/04/2023', 'DD/MM/YYYY') AND TO_DATE('30/04/2023', 'DD/MM/YYYY')
    AND atendime.sn_atendimento_apac LIKE 'S'
GROUP BY
    atendime.cd_procedimento,
    procedimento_sus.ds_procedimento
ORDER BY
    atendime.cd_procedimento;




