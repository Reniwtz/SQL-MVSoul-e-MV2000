SELECT
    username,
    sid,
    serial#,
    module,
    action,
    terminal,
    machine
FROM
    v$session
WHERE
    username = 'DBAMV';
