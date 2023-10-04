DELETE FROM faturamento_convenio
WHERE ROWID IN (
  SELECT rid
  FROM (
    SELECT ROWID AS rid
    FROM faturamento_convenio
    WHERE ROWNUM <= 62
  )
  WHERE ROWNUM = 1
);
