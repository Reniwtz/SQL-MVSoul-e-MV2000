SELECT
    atendime.cd_ori_ate AS Numero_Origem,
    ori_ate.ds_ori_ate AS Origem,
    atendime.cd_atendimento AS Atendimento,
    paciente.nm_paciente AS Paciente,
    atendime.cd_paciente AS CAD_do_Paciente,
    paciente.nr_cpf AS CPF,
    atendime.dt_atendimento AS Data_do_Atendimento,
    atendime.dt_alta AS Data_da_Alta,
    convenio.nm_convenio AS Convênio,
    prestador.nm_prestador AS Prestador,
    atendime.cd_pro_int AS Procedimento,
    (SELECT
        SUM(itreg_amb.vl_total_conta)
    FROM
            atendime atendime
        INNER JOIN itreg_amb ON atendime.cd_atendimento = itreg_amb.cd_atendimento
    WHERE
            atendime.dt_atendimento BETWEEN ( '01/01/2023' ) AND ( '31/01/2023')
        AND atendime.cd_convenio LIKE '3'
        AND atendime.CD_ATENDIMENTO LIKE '3581347'
        AND (cd_lancamento like '1' 
        OR cd_lancamento LIKE '2'
        OR cd_lancamento LIKE '3'
        OR cd_lancamento LIKE '4'
        OR cd_lancamento LIKE '5'
        OR cd_lancamento LIKE '6'
        OR cd_lancamento LIKE '7'
        OR cd_lancamento LIKE '8') ) AS VRL_HNL,
    (SELECT
        SUM(itreg_amb.vl_total_conta) AS Valor_da_Conta
    FROM
            atendime atendime
        INNER JOIN itreg_amb ON atendime.cd_atendimento = itreg_amb.cd_atendimento
    WHERE
            atendime.dt_atendimento BETWEEN ( '01/01/2023' ) AND ( '31/01/2023')
        AND atendime.cd_convenio LIKE '3'
        AND atendime.CD_ATENDIMENTO LIKE '3581347'
        AND cd_lancamento like '9') AS VLR_HO, 
    SUM(itreg_amb.vl_total_conta) AS Total,
    itreg_amb.cd_reg_amb Conta,
    reg_amb.cd_remessa Remessa
    --remessa_fatura.ds_lote_tiss AS Lote,
    --tiss_mensagem.nr_protocolo_retorno AS Protocolo,
    --to_char(fatura.dt_competencia, 'mm-yyyy') AS Competência
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN itreg_amb ON atendime.cd_atendimento = itreg_amb.cd_atendimento
    INNER JOIN reg_amb ON itreg_amb.cd_reg_amb = reg_amb.cd_reg_amb
    --INNER JOIN remessa ON reg_amb.cd_remessa = remessa_fatura.cd_remessa 
    --INNER JOIN remessa_fatura ON reg_amb.cd_remessa = remessa_fatura.cd_remessa
    --INNER JOIN remessa_fatura ON reg_fat.cd_remessa = remessa_fatura.cd_remessa
    --INNER JOIN tiss_mensagem ON remessa_fatura.ds_lote_tiss = tiss_mensagem.nr_lote
    --INNER JOIN fatura ON remessa_fatura.cd_fatura = fatura.cd_fatura
WHERE
        atendime.dt_atendimento BETWEEN ( '01/01/2023' ) AND ( '31/01/2023')
     AND atendime.cd_convenio LIKE '3'
     AND atendime.cd_atendimento LIKE '3581347'
GROUP BY
        atendime.cd_ori_ate,
    ori_ate.ds_ori_ate,
    atendime.cd_atendimento,
    paciente.nm_paciente,
    atendime.cd_paciente,
    paciente.nr_cpf,
    atendime.dt_atendimento,
    atendime.dt_alta,
    convenio.nm_convenio,
    prestador.nm_prestador,
    atendime.cd_pro_int,
    reg_amb.cd_remessa,
    itreg_amb.cd_reg_amb,
    reg_amb.cd_remessa;
