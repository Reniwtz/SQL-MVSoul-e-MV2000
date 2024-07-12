SELECT
    laudo_sia_apac.cd_paciente                                  AS cad,
    paciente.nm_paciente                                        AS nome,
    laudo_sia_apac.dt_competencia                               AS data,
    cd_cid_topografia                                           AS cid,
    floor(months_between(sysdate, paciente.dt_nascimento) / 12) AS idade,
    raca_cor.nm_raca_cor                                        AS cor,
    esquema.cd_esquema                                          AS esquema,
    esquema.ds_esquema                                          AS Descrição
    --laudo_apac_quimio_medicamentos.cd_medicamento               AS medicamentos
FROM
         laudo_sia_apac laudo_sia_apac
    INNER JOIN paciente ON paciente.cd_paciente = laudo_sia_apac.cd_paciente
    INNER JOIN raca_cor ON raca_cor.tp_cor = paciente.tp_cor
    INNER JOIN laudo_apac_quimio_medicamentos ON laudo_apac_quimio_medicamentos.cd_laudo = laudo_sia_apac.cd_laudo
    INNER JOIN laudo_sia_apac_esquema ON laudo_sia_apac_esquema.cd_laudo = laudo_apac_quimio_medicamentos.cd_laudo
    INNER JOIN esquema ON esquema.cd_esquema = laudo_sia_apac_esquema.cd_esquema
WHERE
    laudo_sia_apac.dt_competencia BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/03/2024', 'DD/MM/YYYY')
    AND cd_cid_topografia LIKE 'C61'
GROUP BY
    laudo_sia_apac.cd_paciente,
    paciente.nm_paciente,
    laudo_sia_apac.dt_competencia,
    cd_cid_topografia,
    floor(months_between(sysdate, paciente.dt_nascimento) / 12),
    raca_cor.nm_raca_cor,
    esquema.cd_esquema,
    esquema.ds_esquema                                         
    --laudo_apac_quimio_medicamentos.cd_medicamento
ORDER BY
    laudo_sia_apac.dt_competencia;

-----------------------------------------------------------------------------------------------
SELECT
    laudo_sia_apac.cd_paciente                                  AS cad,
    paciente.nm_paciente                                        AS nome,
    laudo_sia_apac.dt_competencia                               AS data,
    cd_cid_topografia                                           AS cid,
    floor(months_between(sysdate, paciente.dt_nascimento) / 12) AS idade,
    raca_cor.nm_raca_cor                                        AS cor,
    laudo_sia_apac.cd_procedimento                              AS procedimento,
    procedimento_sus.ds_procedimento                            AS descrição,
    esquema.cd_esquema                                          AS esquema,
    esquema.ds_esquema                                          AS descrição
FROM
         laudo_sia_apac laudo_sia_apac
    INNER JOIN paciente ON paciente.cd_paciente = laudo_sia_apac.cd_paciente
    INNER JOIN raca_cor ON raca_cor.tp_cor = paciente.tp_cor
    INNER JOIN laudo_apac_quimio_medicamentos ON laudo_apac_quimio_medicamentos.cd_laudo = laudo_sia_apac.cd_laudo
    INNER JOIN laudo_sia_apac_esquema ON laudo_sia_apac_esquema.cd_laudo = laudo_apac_quimio_medicamentos.cd_laudo
    INNER JOIN esquema ON esquema.cd_esquema = laudo_sia_apac_esquema.cd_esquema
    INNER JOIN procedimento_sus ON procedimento_sus.cd_procedimento = laudo_sia_apac.cd_procedimento
WHERE
    laudo_sia_apac.dt_competencia BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('11/07/2024', 'DD/MM/YYYY')
    AND ( esquema.ds_esquema LIKE '%PERJETA (PERTUZUMABE%' OR esquema.ds_esquema LIKE '%TRASTUZUMABE - HERCEPTIN%' )
GROUP BY
    laudo_sia_apac.cd_paciente,
    paciente.nm_paciente,
    laudo_sia_apac.dt_competencia,
    cd_cid_topografia,
    floor(months_between(sysdate, paciente.dt_nascimento) / 12),
    raca_cor.nm_raca_cor,
    laudo_sia_apac.cd_procedimento,
    procedimento_sus.ds_procedimento,
    esquema.cd_esquema,
    esquema.ds_esquema
ORDER BY
    paciente.nm_paciente,
    laudo_sia_apac.dt_competencia;
