--------------------------------------------------------------------------------
            -- Ambulatório - Dados Com o Valor ToTal -- 
--------------------------------------------------------------------------------
SELECT
    atendime.cd_ori_ate                       AS numero_origem,
    ori_ate.ds_ori_ate                        AS origem,
    itreg_amb_original.cd_atendimento         AS atendimento,
    paciente.nm_paciente                      AS paciente,
    atendime.cd_paciente                      AS cad_do_paciente,
    paciente.nr_cpf                           AS cpf,
    atendime.dt_atendimento                   AS data_do_atendimento,
    atendime.dt_alta                          AS data_da_alta,
    convenio.nm_convenio                      AS convênio,
    prestador.nm_prestador                    AS prestador,
    atendime.cd_pro_int                       AS procedimento,
    sum(itreg_amb_original.vl_total_conta)    AS valor_total,
    itreg_amb_original.cd_reg_amb             AS conta,
    reg_amb.cd_remessa                        AS remessa,
    to_char(fatura.dt_competencia, 'mm-yyyy') AS competência
FROM
         itreg_amb_original
    INNER JOIN atendime ON itreg_amb_original.cd_atendimento = atendime.cd_atendimento
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN reg_amb ON itreg_amb_original.cd_reg_amb = reg_amb.cd_reg_amb
    INNER JOIN remessa_fatura ON reg_amb.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
    itreg_amb_original.cd_atendimento LIKE '3581436'
GROUP BY
        atendime.cd_ori_ate,
    ori_ate.ds_ori_ate,
    itreg_amb_original.cd_atendimento,
    paciente.nm_paciente,
    atendime.cd_paciente,
    paciente.nr_cpf,
    atendime.dt_atendimento,
    atendime.dt_alta,
    convenio.nm_convenio,
    prestador.nm_prestador,
    atendime.cd_pro_int,
    reg_amb.cd_remessa,
    itreg_amb_original.cd_reg_amb,
    reg_amb.cd_remessa,
    fatura.dt_competencia;
    
--------------------------------------------------------------------------------    
                -- Ambulatório - Valor Honorário -- 
--------------------------------------------------------------------------------
SELECT
    itreg_amb_original.cd_atendimento           AS atendimento,
    SUM(itreg_amb_original.vl_total_conta)      AS valor_hono
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN itreg_amb_original ON atendime.cd_atendimento = itreg_amb_original.cd_atendimento
    INNER JOIN reg_amb ON itreg_amb_original.cd_reg_amb = reg_amb.cd_reg_amb
    INNER JOIN remessa_fatura ON reg_amb.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
        itreg_amb_original.cd_atendimento LIKE '3581436'
    AND itreg_amb_original.cd_prestador IS NOT NULL
    AND atendime.cd_convenio LIKE '3'
    --AND to_char(fatura.dt_competencia, 'mm/yyyy') = '04/2023'
GROUP BY
    itreg_amb_original.cd_atendimento;   

--------------------------------------------------------------------------------  
                      -- Ambulatório - Valor HNL --
--------------------------------------------------------------------------------
SELECT
    itreg_amb_original.cd_atendimento           AS atendimento,
    SUM(itreg_amb_original.vl_total_conta)      AS valor_hnl
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN itreg_amb_original ON atendime.cd_atendimento = itreg_amb_original.cd_atendimento
    INNER JOIN reg_amb ON itreg_amb_original.cd_reg_amb = reg_amb.cd_reg_amb
    INNER JOIN remessa_fatura ON reg_amb.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
        itreg_amb_original.cd_atendimento LIKE '3581436'
    AND itreg_amb_original.cd_prestador IS NULL
    AND atendime.cd_convenio LIKE '3'
GROUP BY
    itreg_amb_original.cd_atendimento;    
 
 

 
 
  
--------------------------------------------------------------------------------   
                --Internação - Dados Com o Valor ToTal-- 
--------------------------------------------------------------------------------            
SELECT
    atendime.cd_ori_ate                       AS numero_origem,
    ori_ate.ds_ori_ate                        AS origem,
    reg_fat.cd_atendimento                    AS atendimento,
    paciente.nm_paciente                      AS paciente,
    atendime.cd_paciente                      AS cad_do_paciente,
    paciente.nr_cpf                           AS cpf,
    atendime.dt_atendimento                   AS data_do_atendimento,
    atendime.dt_alta                          AS data_da_alta,
    convenio.nm_convenio                      AS convênio,
    prestador.nm_prestador                    AS prestador,
    atendime.cd_pro_int                       AS procedimento,
    SUM(itreg_fat_original.vl_total_conta)    AS valor_total,
    itreg_fat_original.cd_reg_fat             AS conta,
    reg_fat.cd_remessa                        AS remessa,
    to_char(fatura.dt_competencia, 'mm-yyyy') AS competência
FROM
         reg_fat reg_fat
    INNER JOIN atendime ON reg_fat.cd_atendimento = atendime.cd_atendimento
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN itreg_fat_original ON reg_fat.cd_reg_fat = itreg_fat_original.cd_reg_fat
    INNER JOIN remessa_fatura ON reg_fat.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
    reg_fat.cd_atendimento LIKE '3580006'
GROUP BY
    atendime.cd_ori_ate,
    ori_ate.ds_ori_ate,
    reg_fat.cd_atendimento,
    paciente.nm_paciente,
    atendime.cd_paciente,
    paciente.nr_cpf,
    atendime.dt_atendimento,
    atendime.dt_alta,
    convenio.nm_convenio,
    prestador.nm_prestador,
    atendime.cd_pro_int,
    reg_fat.cd_remessa,
    itreg_fat_original.cd_reg_fat,
    reg_fat.cd_remessa,
    fatura.dt_competencia;
     
--------------------------------------------------------------------------------    
                   -- Internação - Valor Honorário -- 
--------------------------------------------------------------------------------
SELECT
    reg_fat.cd_atendimento           AS atendimento,
    SUM(itreg_fat_original.vl_total_conta)      AS valor_hono
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN reg_fat ON atendime.cd_atendimento = reg_fat.cd_atendimento    
    INNER JOIN itreg_fat_original ON  itreg_fat_original.cd_reg_fat = reg_fat.cd_reg_fat
    INNER JOIN remessa_fatura ON reg_fat.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
        reg_fat.cd_atendimento LIKE '3579475'
    AND itreg_fat_original.cd_prestador IS NOT NULL
    AND atendime.cd_convenio LIKE '3'
    --AND to_char(fatura.dt_competencia, 'mm/yyyy') = '04/2023'
GROUP BY
    reg_fat.cd_atendimento;   

--------------------------------------------------------------------------------  
                    -- Internação - Valor HNL --
--------------------------------------------------------------------------------                    
SELECT
    reg_fat.cd_atendimento           AS atendimento,
    SUM(itreg_fat_original.vl_total_conta)      AS valor_hono
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN reg_fat ON atendime.cd_atendimento = reg_fat.cd_atendimento    
    INNER JOIN itreg_fat_original ON  itreg_fat_original.cd_reg_fat = reg_fat.cd_reg_fat
    INNER JOIN remessa_fatura ON reg_fat.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
        reg_fat.cd_atendimento LIKE '3580006'
    AND itreg_fat_original.cd_prestador IS NULL
    AND atendime.cd_convenio LIKE '3'
    --AND to_char(fatura.dt_competencia, 'mm/yyyy') = '04/2023'
GROUP BY
    reg_fat.cd_atendimento; 

---------------------------------------------------------------------------

SELECT 
    atendime.cd_ori_ate                       AS numero_origem,
    ori_ate.ds_ori_ate                        AS origem,
    itreg_amb_original.cd_atendimento         AS atendimento,
    paciente.nm_paciente                      AS paciente,
    atendime.cd_paciente                      AS cad_do_paciente,
    paciente.nr_cpf                           AS cpf,
    atendime.dt_atendimento                   AS data_do_atendimento,
    atendime.dt_alta                          AS data_da_alta,
    convenio.nm_convenio                      AS convênio,
    prestador.nm_prestador                    AS prestador,
    itreg_amb_original.cd_prestador           AS prestadorvalidar,
    atendime.cd_pro_int                       AS procedimento,
    itreg_amb_original.vl_total_conta         AS valor,
    itreg_amb_original.cd_reg_amb             AS conta,
    reg_amb.cd_remessa                        AS remessa,
    to_char(fatura.dt_competencia, 'mm-yyyy') AS competência
FROM
         itreg_amb_original
    INNER JOIN atendime ON itreg_amb_original.cd_atendimento = atendime.cd_atendimento
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN reg_amb ON itreg_amb_original.cd_reg_amb = reg_amb.cd_reg_amb
    INNER JOIN remessa_fatura ON reg_amb.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
    atendime.dt_atendimento BETWEEN '01/04/2023' AND '30/04/2023'
    --atendime.cd_atendimento like '3586246'
    AND atendime.cd_convenio LIKE '3'
ORDER BY
    itreg_amb_original.cd_atendimento;


--------------------------------------------------------------------------------------------

SELECT
    atendime.cd_ori_ate                       AS numero_origem,
    ori_ate.ds_ori_ate                        AS origem,
    reg_fat.cd_atendimento                    AS atendimento,
    paciente.nm_paciente                      AS paciente,
    atendime.cd_paciente                      AS cad_do_paciente,
    paciente.nr_cpf                           AS cpf,
    atendime.dt_atendimento                   AS data_do_atendimento,
    atendime.dt_alta                          AS data_da_alta,
    convenio.nm_convenio                      AS convênio,
    itreg_fat_original.cd_prestador           AS campo_de_validação,
    prestador.nm_prestador                    AS prestador,
    atendime.cd_pro_int                       AS procedimento,
    itreg_fat_original.vl_total_conta         AS valor_total,
    itreg_fat_original.cd_reg_fat             AS conta,
    reg_fat.cd_remessa                        AS remessa,
    to_char(fatura.dt_competencia, 'mm-yyyy') AS competência
FROM
         reg_fat reg_fat
    INNER JOIN atendime ON reg_fat.cd_atendimento = atendime.cd_atendimento
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN itreg_fat_original ON reg_fat.cd_reg_fat = itreg_fat_original.cd_reg_fat
    INNER JOIN remessa_fatura ON reg_fat.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
        fatura.dt_competencia BETWEEN '01/04/2023' AND '30/04/2023'
        --atendime.dt_atendimento BETWEEN '01/04/2023' AND '30/04/2023'
    AND atendime.cd_convenio LIKE '3'
ORDER BY
    reg_fat.cd_atendimento;

----------------------------------------------------------------------------
-- Rela Rafaela
SELECT
    eve_siasus.cd_atendimento                      AS atendimento,
    eve_siasus.cd_paciente                         AS código_do_paciente,
    paciente.nm_paciente                           AS nome_do_paciente,
    floor((EXTRACT(YEAR FROM atendime.dt_atendimento) - EXTRACT(YEAR FROM paciente.dt_nascimento)) -
          CASE
              WHEN EXTRACT(MONTH FROM atendime.dt_atendimento) < EXTRACT(MONTH FROM paciente.dt_nascimento)
                   OR(EXTRACT(MONTH FROM atendime.dt_atendimento) = EXTRACT(MONTH FROM paciente.dt_nascimento)
                      AND EXTRACT(DAY FROM atendime.dt_atendimento) < EXTRACT(DAY FROM paciente.dt_nascimento)) THEN
                  1
              ELSE
                  0
          END
    )                                              AS idade,
    paciente.nr_cns                                AS cartão_sus,
    same.nr_matricula_same                         AS prontuário,
    eve_siasus.cd_procedimento                     AS procedimento,
    eve_siasus.cd_cbo_prestador                    AS cbo,
    prestador.nm_prestador                         AS prestador,
    eve_siasus.vl_servico_ambulatorial             AS valor,
    to_char(atendime.dt_atendimento, 'yyyy/mm/dd') AS data_do_atendimento
FROM
         eve_siasus eve_siasus
    INNER JOIN paciente ON eve_siasus.cd_paciente = paciente.cd_paciente
    INNER JOIN same ON same.cd_paciente = paciente.cd_paciente
    INNER JOIN atendime ON atendime.cd_atendimento = eve_siasus.cd_atendimento
    INNER JOIN prestador ON prestador.cd_prestador = eve_siasus.cd_prestador
WHERE
    eve_siasus.cd_fat_sia LIKE '521'
    AND eve_siasus.cd_remessa IN ( '1863', '1864', '1865' )
GROUP BY
    eve_siasus.cd_atendimento,
    eve_siasus.cd_paciente,
    paciente.nm_paciente,
    floor((EXTRACT(YEAR FROM atendime.dt_atendimento) - EXTRACT(YEAR FROM paciente.dt_nascimento)) -
          CASE
              WHEN EXTRACT(MONTH FROM atendime.dt_atendimento) < EXTRACT(MONTH FROM paciente.dt_nascimento)
                   OR(EXTRACT(MONTH FROM atendime.dt_atendimento) = EXTRACT(MONTH FROM paciente.dt_nascimento)
                      AND EXTRACT(DAY FROM atendime.dt_atendimento) < EXTRACT(DAY FROM paciente.dt_nascimento)) THEN
                  1
              ELSE
                  0
          END
    ),
    paciente.nr_cns,
    same.nr_matricula_same,
    eve_siasus.cd_procedimento,
    atendime.dt_atendimento,
    eve_siasus.cd_cbo_prestador,
    prestador.nm_prestador,
    eve_siasus.vl_servico_ambulatorial,
    to_char(atendime.dt_atendimento, 'yyyy/mm/dd');
--------------------------------------------------------------------------------    
FATURA SIA/SUS 02/2024 - REMESSA 1863, 1864, 1865
FATURA SIA/SUS 01/2024 - REMESSA 1846, 1847, 1848
FATURA SIA/SUS 12/2023 - REMESSA 1827, 1828, 1829
FATURA SIA/SUS 11/2023 - REMESSA 1809, 1807, 1808
FATURA SIA/SUS 10/2023 - REMESSA 1796, 1797, 1798          
--------------------------------------------------------------------------------    
SELECT
    cd_remessa
FROM
    eve_siasus eve_siasus 
WHERE
     eve_siasus.cd_fat_sia LIKE '521'
group by
    cd_remessa;
   
--------------------------------------------------------------------------------
SELECT
    cd_fat_sia,
    ds_fat_sia,
    cd_remessa
FROM
    fat_sia
WHERE
    ds_fat_sia LIKE '%FATURA SIA/SUS 02/2024%'
    OR ds_fat_sia LIKE '%FATURA SIA/SUS 01/2024%'
    OR ds_fat_sia LIKE '%FATURA SIA/SUS 12/2023%'
    OR ds_fat_sia LIKE '%FATURA SIA/SUS 11/2023%'
    OR ds_fat_sia LIKE '%FATURA SIA/SUS 10/2023%'
ORDER BY
    cd_fat_sia;
