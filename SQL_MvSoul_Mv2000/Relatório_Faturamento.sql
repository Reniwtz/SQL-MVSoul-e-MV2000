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
