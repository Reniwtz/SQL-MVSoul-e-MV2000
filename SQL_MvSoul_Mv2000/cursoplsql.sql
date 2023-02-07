set serveroutput on;

DECLARE
    v_id NUMBER(5) := 1;
BEGIN
    dbms_output.put_line(v_id);
    v_id := 2;
    dbms_output.put_line(v_id);
END;