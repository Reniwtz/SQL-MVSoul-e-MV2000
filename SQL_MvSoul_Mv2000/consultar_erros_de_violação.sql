SELECT
    owner,
    constraint_name,
    table_name,
    search_condition
FROM
    all_constraints
WHERE
        owner = 'DBAMV'
    AND constraint_name = 'AVCON_150153_SN_AC_000';
