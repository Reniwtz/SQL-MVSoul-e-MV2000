        select t1.cd_procedimento Cod_Procedimento, t3.ds_procedimento Descricao, t2.qt_fisico Acordado, count(t1.cd_procedimento) Qt_Lancada
            from eve_siasus t1, teto_orcamentario_proced_sus t2, procedimento_sus t3
        where
            t1.cd_procedimento in (select cd_procedimento from procedimento_sus) and
            t1.cd_fat_sia in (select cd_fat_sia from fat_sia where to_char(dt_periodo_inicial, 'MM/YYYY') = '02/2023') and
            to_char(t1.dt_eve_siasus, 'mm/yyyy') = '02/2023' and
            t2.cd_fat_sia in (select cd_fat_sia from fat_sia where to_char(dt_periodo_inicial, 'mm/yyyy') = '02/2023') and
            t1.cd_procedimento = t2.cd_procedimento and
            t1.cd_procedimento = t3.cd_procedimento and
            t1.qt_lancada <> 0
        group by t1.cd_procedimento, t3.ds_procedimento, t2.qt_fisico
        order by t1.cd_procedimento
