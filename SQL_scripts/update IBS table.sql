-- import the given excel file into the IBS001 database as Sheet1 table
-- then update the Suppl table with the data from Sheet1

BEGIN TRAN
UPDATE sup
SET
    sup.SupName        = sheet.SupName,
    sup.SupAddr1       = ISNULL(sheet.SupAddr1, ''),
    sup.SupAddr2       = ISNULL(sheet.SupAddr2, ''),
    sup.SupAddrTown    = ISNULL(sheet.SupAddrTown, ''),
    sup.SupAddrProv    = ISNULL(sheet.SupAddrProv, ''),
    sup.SupAddrPC      = ISNULL(sheet.SupAddrPC, ''),
    sup.SupAddrCountry = ISNULL(sheet.SupAddrCountry, '')
FROM IBS001.dbo.Suppl AS sup
    INNER JOIN IBS001.dbo.Sheet1 AS sheet ON sup.SupCode = sheet.SupCode
WHERE sup.SupCode IN (
    SELECT SupCode
    FROM IBS001.dbo.Sheet1
)