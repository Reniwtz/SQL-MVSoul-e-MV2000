SELECT
    atendime.cd_atendimento AS Atendimento,
    paciente.nm_paciente AS Nome_do_Paciente,
    atendime.cd_paciente AS CAD_do_Paciente,
    paciente.nr_cpf AS CPF,
    ori_ate.ds_ori_ate AS Origem,
    atendime.dt_atendimento AS Data_do_Atendimento,
    convenio.nm_convenio AS Convênio,
    prestador.nm_prestador AS Prestador,
    atendime.cd_pro_int AS Procedimento,
    reg_fat.cd_remessa AS Remessa,
    reg_fat.vl_total_conta AS Valor_da_Conta,
    remessa_fatura.ds_lote_tiss AS Lote,
    tiss_mensagem.nr_protocolo_retorno AS Protocolo
FROM
         atendime atendime
    INNER JOIN paciente ON atendime.cd_paciente = paciente.cd_paciente
    INNER JOIN ori_ate ON atendime.cd_ori_ate = ori_ate.cd_ori_ate
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN reg_fat ON atendime.cd_atendimento = reg_fat.cd_atendimento
    INNER JOIN prestador ON atendime.cd_prestador = prestador.cd_prestador
    INNER JOIN remessa_fatura ON reg_fat.cd_remessa = remessa_fatura.cd_remessa
    INNER JOIN tiss_mensagem ON remessa_fatura.ds_lote_tiss = tiss_mensagem.nr_lote
WHERE
        atendime.dt_atendimento BETWEEN ( '01/04/2023' ) AND ( '30/04/2023')
     AND atendime.cd_convenio LIKE '3';
