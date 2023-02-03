-- Como verificar se tem lock preso

SELECT w.inst_id w_inst_id, w.sid w_sid,w.serial# w_serial#,w.username w_username ,w.osuser w_osuser, NVL(w.module,w.program)
       w_program, NVL(w.machine,w.terminal) w_machine,w.action w_action,w.sql_id w_sql_id, '####',
       b.inst_id b_inst_id, b.sid b_sid,b.serial# b_serial#,b.username b_username ,b.osuser b_osuser, NVL(b.module,b.program)
       b_program ,NVL(b.machine,b.terminal) b_machine,b.action b_action,b.status b_status,b.sql_id,
       to_char(trunc(b.last_call_et/86400),'009') || 'D' || to_char(trunc(mod(b.last_call_et,86400)/3600),'09') ||'h:' ||
to_char(trunc(mod(b.last_call_et,3600)/60),'09') ||'mi:' ||
to_char(mod(mod(b.last_call_et,3600),60),'09')|| 'ss' "TEMPO" ,
(SELECT owner||'.'||object_name
          FROM dba_objects o
         WHERE o.object_id = w.row_wait_obj#) object,b.event
FROM gv$session w,
     gv$session b
WHERE w.blocking_session  IS NOT NULL
  AND w.blocking_instance = b.inst_id
  AND w.blocking_session = b.sid;

-- comando para destravar (derrubar a sessão que está travando o processo)

alter system kill session '773,25863';
