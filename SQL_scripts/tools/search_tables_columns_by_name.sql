-- This script lists all user tables in the database that start by name criteria.

use VJSPTEST;
DECLARE @searchtab NVARCHAR(50);
set @searchtab = 'STK%';

SELECT
    name,
    type
FROM sys.tables
WHERE
 name LIKE @searchtab ESCAPE '\' -- list all order related tables from DB
    and name not like '%_backup%'
    and [type] = 'U'
-- user tables only
ORDER BY name;



SELECT
    table_catalog,
    table_schema,
    table_name,
    column_name,
    data_type,
    ordinal_position,
    data_type,
    character_maximum_length
from
    INFORMATION_SCHEMA.COLUMNS
where
-- table_name like @searchtab ESCAPE '\'  -- list all order related tables from DB
     COLUMN_NAME like 'OH_BATCH_FLAG' ESCAPE '\'
order by table_name, ordinal_position
;

