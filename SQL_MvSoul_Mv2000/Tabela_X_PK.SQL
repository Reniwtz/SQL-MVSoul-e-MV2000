SELECT 
    a.constraint_name, 
    a.table_name, 
    b.column_name
FROM 
    all_constraints a
JOIN 
    all_cons_columns b
ON 
    a.constraint_name = b.constraint_name
WHERE 
    a.constraint_type = 'P' 
    AND a.constraint_name = 'LOG_EXCLAU_PK';
