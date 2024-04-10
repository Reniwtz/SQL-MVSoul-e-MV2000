SELECT
    *
FROM
    geracao_ciha
ORDER BY
    1 DESC;

---------------------------------------------------
    
SELECT
    *
FROM
    producao_convenio_ciha
WHERE
        cd_geracao = 2015
    AND cd_atendimento = 3835336;

-------------------------------------------------

SELECT
    nr_carteira
FROM
    dbamv.carteira
WHERE
        cd_paciente = 171403
    AND cd_convenio = 83
    AND cd_con_pla = 1
ORDER BY
    dt_validade DESC;
