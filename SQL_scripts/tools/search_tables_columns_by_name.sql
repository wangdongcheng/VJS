-- This script lists all user tables in the database that start by name criteria.
USE SVBeauty;

DECLARE @searchtab NVARCHAR(50);

SET
    @searchtab = 'sys\_%';

SELECT
    name,
TYPE
FROM
    sys.tables
WHERE
    name LIKE @searchtab ESCAPE '\' -- list all order related tables from DB
    AND
    name NOT LIKE '%_backup%' AND
    [type] = 'U'
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
    where
    -- table_name like @searchtab ESCAPE '\'  -- list all order related tables from DB
     COLUMN_NAME like '%Organisation' ESCAPE '\'
    -- order by table_name, ordinal_position
;