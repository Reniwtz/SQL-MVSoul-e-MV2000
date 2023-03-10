select count(b.cd_usuario)tot,
       b.cd_usuario ,
       case b.tp_mvto_estoque when 'S' then 'Saida-Setor'
                              when 'P' then 'Saida-Paciente'
                              when 'C' then 'Devol-Paciente'
                              when 'D' then 'Devol-Setor'
                              when 'T' then 'Transf-Estoque'
                              when 'X' then 'Baixa-Produto'
                              else b.tp_mvto_estoque
                                end as tp_mvto_estoque
from DBAMV.MVTO_ESTOQUE b
where trunc(b.dt_mvto_estoque) >= trunc(sysdate-2)
and b.tp_mvto_estoque not in('E','B')
and b.cd_estoque = 9
group by b.cd_usuario ,b.tp_mvto_estoque
