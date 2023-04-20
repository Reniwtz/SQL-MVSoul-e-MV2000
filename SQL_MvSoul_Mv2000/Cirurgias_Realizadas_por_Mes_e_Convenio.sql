SELECT
    decode(cirurgia_aviso.cd_convenio , '1', 'SUS - INT', '2', 'SUS - AMB', '16', 'Particular', 'P.Saude') Convenio, substr(to_CHAR(aviso_cirurgia.dt_realizacao, 'MONTH'),0,3) Mes_Atend, COUNT ( cirurgia_aviso.cd_convenio ) CONT_CONV
FROM
    aviso_cirurgia aviso_cirurgia,
    cirurgia_aviso cirurgia_aviso,
    cirurgia       cirurgia,
    convenio       convenio,
    empresa_convenio
WHERE
        empresa_convenio.cd_convenio = convenio.cd_convenio
    AND aviso_cirurgia.tp_situacao = 'R'
    AND aviso_cirurgia.cd_aviso_cirurgia = cirurgia_aviso.cd_aviso_cirurgia
    AND cirurgia_aviso.cd_cirurgia = cirurgia.cd_cirurgia
    AND convenio.cd_convenio = '1'
    AND aviso_cirurgia.cd_cen_cir = '1'
    AND aviso_cirurgia.dt_realizacao BETWEEN ( '01/01/2023' ) AND ( '31/03/2023' )
GROUP BY 
    cirurgia_aviso.cd_convenio , substr(to_CHAR(aviso_cirurgia.dt_realizacao, 'MONTH'),0,3), convenio.nm_convenio
order by 
    mes_atend;

