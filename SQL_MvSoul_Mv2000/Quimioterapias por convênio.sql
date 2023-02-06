--Select * from itmvto_estoque
--select * from solsai_pro
-- select * from setor where cd_setor = 3

select *--distinct e.cd_atendimento,e.dt_mvto_estoque
  from mvto_estoque e, atendime a, produto p, itmvto_estoque i
 where e.cd_estoque = 8
   and e.tp_mvto_estoque = 'P'             -- Movimentação para Paciente
  and e.cd_atendimento is not null         -- Garantir que o codigo de atendimento esteja preenchido
  and e.dt_mvto_Estoque between '01/01/2015' and '31/12/2015' -- Período de Movimentação de Estoque
  and e.cd_atendimento = a.cd_atendimento
  and i.cd_mvto_Estoque = e.cd_mvto_estoque
  and i.cd_produto = p.cd_produto
  and a.cd_convenio not in (1,2,16)        -- Para retornar apenas atendimentos de Convênio (Internos e Ambulatório)
  and p.cd_classe = 2                      -- Agentes Antineoplásicos
  and p.cd_especie = 1                     -- Medicamentos
--  and cd_setor <> 3

--select * from itmvto_estoque where tp_mvto_Estoque = 'P'
