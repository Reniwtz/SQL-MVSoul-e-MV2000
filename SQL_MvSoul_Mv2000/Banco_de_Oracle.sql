-- Usuários de Banco e seus acesso a tabela
SELECT
    dba_users.username,
    dba_users.created,
    dba_users.last_login,
    dba_tab_privs.table_name,
    dba_tab_privs.privilege
FROM
    dba_users dba_users
    inner join dba_tab_privs on dba_tab_privs.grantee = dba_users.username
WHERE
    username LIKE '%HNLAPPS%';
