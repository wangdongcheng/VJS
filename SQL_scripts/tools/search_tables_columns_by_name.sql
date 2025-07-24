-- This script lists all user tables in the database that start by name criteria.

use VJSCL;
DECLARE @searchtab NVARCHAR(50);
set @searchtab = 'STK_%';

if 1 != 1
begin

    PRINT 'This script is not intended to be run directly. Please use the appropriate tool or script to execute it.';
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
    return;
end



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
table_name like @searchtab ESCAPE '\' and -- list all order related tables from DB
    COLUMN_NAME like '%bin%' ESCAPE '\'
order by table_name, ordinal_position
;