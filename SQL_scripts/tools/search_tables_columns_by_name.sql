DECLARE @searchtab NVARCHAR(50) = '#%';

SELECT
    name,
TYPE
FROM
    sys.tables
WHERE
    name LIKE @searchtab ESCAPE '\' -- list all order related tables from DB
    -- AND [type] = 'U'
    -- user tables only
ORDER BY
    name;

SELECT
    table_catalog,
    table_schema,
    table_name,
    column_name,
    data_type,
    ordinal_position,
    data_type,
    character_maximum_length
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    -- table_name like @searchtab ESCAPE '\'  -- list all order related tables from DB
    COLUMN_NAME LIKE '%Organisation' ESCAPE '\'
    -- order by table_name, ordinal_position
;


SELECT 
    name,
    create_date,
    modify_date
FROM tempdb.sys.tables
WHERE name LIKE '#%'
ORDER BY create_date DESC;