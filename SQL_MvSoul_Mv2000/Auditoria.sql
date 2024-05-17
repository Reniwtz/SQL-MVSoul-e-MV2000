SELECT
    audit_coluna.cd_audit_tabela,
    audit_coluna.cd_tabela,
    audit_coluna.coluna,
    audit_coluna.dado_anterior,
    audit_coluna.dado_atual,
    audit_coluna.chave_primaria,
    audit_tabela.tp_transacao,
    audit_tabela.dt_transacao,
    audit_tabela.usuario
FROM
         audit_coluna
    INNER JOIN audit_tabela ON audit_tabela.cd_audit_tabela = audit_coluna.cd_audit_tabela
WHERE
    audit_tabela.dt_transacao BETWEEN '12/03/22' AND '13/03/23'
    AND audit_tabela.tp_transacao LIKE 'U'
    AND audit_coluna.cd_tabela LIKE 'EVE_SIASUS'
ORDER BY
    audit_tabela.dt_transacao;

--------------------------------------------------------------------------------
SELECT
   -- TO_CHAR(audit_dt_registro, 'YYYY-MM-DD HH24:MI:SS'), atendime.*
   *
FROM
    audit_dbamv.atendime
WHERE
    --audit_dt_registro BETWEEN TO_DATE('29/07/2023', 'DD/MM/YYYY') AND TO_DATE('04/08/2023', 'DD/MM/YYYY')
    cd_atendimento LIKE '3884623'
ORDER BY
    audit_dt_registro DESC;
    
-------------------------------------------------------------------------------- 
SELECT
    *
FROM
    atendime
WHERE
    cd_atendimento LIKE '3884623';
    
-------------------------------------------------------------------------------- 
