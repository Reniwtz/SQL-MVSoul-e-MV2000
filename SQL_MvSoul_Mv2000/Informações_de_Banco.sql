-- ALTER SYSTEM KILL SESSION  '997,49502'

/*Consukta Antiga
select    nvl(S.USERNAME,'Internal') username
   ,nvl(S.TERMINAL,'None') terminal
   ,S.OsUser
   ,L.SID||','||S.SERIAL# Kill
   ,U1.NAME||'.'||substr(T1.NAME,1,20) tab
   ,S.ACTION
   ,decode(L.LMODE,1,'No Lock',
       2,'Row Share',
       3,'Row Exclusive',
       4,'Share',
       5,'Share Row Exclusive',
       6,'Exclusive',null) lmode
   ,decode(L.REQUEST,1,'No Lock',
       2,'Row Share',
       3,'Row Exclusive',
       4,'Share',
       5,'Share Row Exclusive',
       6,'Exclusive',null) request
   ,To_Char( Trunc(Sysdate) + L.CTime*( 1/(24*60*60) ), 'hh24:mi:ss' ) Tempo
from    V$LOCK L,
   V$SESSION S,
   SYS.USER$ U1,
   SYS.OBJ$ T1
where    L.SID = S.SID
AND    L.LMODE = 3
and    T1.OBJ# = decode(L.ID2,0,L.ID1,L.ID2)
and    U1.USER# = T1.OWNER#
and    S.TYPE != 'BACKGROUND'
order by l.ctime desc,1,2,6*/

-----------------------------------------------------------------------------------------------
-- Consultar Sessão Presa
SELECT
    nvl(v_session.username, 'Internal')                 AS username,
    nvl(v_session.terminal, 'None')                     AS terminal,
    v_session.osuser                                    AS osuser,
    v_session.machine                                   AS maquina,
    v_session.program                                   AS programa,
    v_session.module                                    AS modulo,
    v_lock.sid || ',' || v_session.serial# AS kill,
    sys_user.name || '.' || SUBSTR(sys_obj.name, 1, 20) AS objeto,
    v_session.action                                    AS acao,
    v_session.client_info                               AS client_info,
    decode(v_lock.lmode, 1, 'No Lock', 2, 'Row Share',
           3, 'Row Exclusive', 4, 'Share', 5,
           'Share Row Exclusive', 6, 'Exclusive', NULL) AS lmode,
    decode(v_lock.request, 1, 'No Lock', 2, 'Row Share',
           3, 'Row Exclusive', 4, 'Share', 5,
           'Share Row Exclusive', 6, 'Exclusive', NULL) AS request,
    lpad(TRUNC(v_lock.ctime / 3600), 2, '0') || ':' ||
    lpad(TRUNC(MOD(v_lock.ctime, 3600) / 60), 2, '0') || ':' ||       
    lpad(mod(v_lock.ctime, 60), 2, '0')                 AS tempo_lock
FROM
         v$lock v_lock
    INNER JOIN v$session v_session ON v_lock.sid = v_session.sid
    INNER JOIN sys.obj$  sys_obj ON sys_obj.obj# = decode(v_lock.id2, 0, v_lock.id1, v_lock.id2)
    INNER JOIN sys.user$ sys_user ON sys_user.user# = sys_obj.owner#
WHERE
        v_lock.lmode = 3
    AND v_session.type <> 'BACKGROUND'
ORDER BY
    v_lock.ctime DESC,
    username,
    terminal,
    acao;
   

--------------------------------------------------------------------
-- Informações de Usuário de sistema
SELECT
    v$session.sid          AS sid,
    v$session.username     AS usuário,
    v$session.status       AS status,
    v$session.osuser       AS usuário_da_maquina,
    v$session.process      AS processo,
    v$session.machine      AS máquina_de_acesso,
    v$session.port         AS porta,
    v$session.program      AS programa,
    v$session.module       AS módulo,
    v$session.logon_time   AS tempo_de_login,
    v$session.service_name AS nome_do_serviço,
    v$lock.sid || ',' || v$session.serial# AS kill
FROM
    v$session v$session
    inner join v$lock on v$lock.sid = v$session.sid
WHERE
    v$session.username LIKE '%RENILTON%'


--------------------------------------------------------------------
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



/*Dados
Para usuários, permissões e segurança
dba_users
dba_roles
dba_sys_privs
dba_tab_privs
dba_role_privs

Essas ajudam a ver quem acessa o quê.

Para sessões, travas e atividade
v$session
Sessões conectadas.
v$process
Processo do sistema operacional ligado à sessão.
v$locked_object
Objetos bloqueados.
v$lock
Locks em nível mais técnico.
v$transaction
Transações ativas.
v$sql
SQLs executados / cursor cache.
v$session_longops
Operações demoradas.
Para performance
v$system_event
v$session_event
v$waitstat
v$parameter
v$sga
v$sgastat
v$pga_target_advice
v$datafile
v$tempfile
v$tablespace
Para auditoria e log
dba_audit_trail
dba_audit_session
dba_source
dba_errors
Para jobs, automações e rotinas
dba_scheduler_jobs
dba_scheduler_job_run_details
dba_jobs*/
