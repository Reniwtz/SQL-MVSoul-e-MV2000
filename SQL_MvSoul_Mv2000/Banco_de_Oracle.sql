-- Usuários de Banco e seus acesso a tabela
SELECT
    username,
    created,
    last_login
FROM
    dba_users dba_users
    inner join dba_tab_privs on dba_tab_privs.grantee = dba_users.username
WHERE
    username LIKE '%HNLAPPS%';
