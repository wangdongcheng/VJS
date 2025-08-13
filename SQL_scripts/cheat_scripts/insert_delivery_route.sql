
use SVBeauty;

begin try
    begin tran;
    
    -- Insert all DELROUTE records
    insert into SYS_LOOKUP_TEXT (TXT_ORIGIN, TXT_USER_TEXT, TXT_SORT_ORDER, TXT_PRIMARY) 
    values 
        ('DELROUTE', 'Santa Lucija', 50, 737),
        ('DELROUTE', 'Zabbar', 51, 738),
        ('DELROUTE', 'Zebbug', 52, 739),
        ('DELROUTE', 'Bormla', 53, 740),
        ('DELROUTE', 'Fgura', 54, 741),
        ('DELROUTE', 'Munxar Gozo', 55, 742),
        ('DELROUTE', 'Luqa', 56, 743),
        ('DELROUTE', 'Mqabba', 57, 744),
        ('DELROUTE', 'Rabat, Malta', 58, 745),
        ('DELROUTE', 'Safi', 59, 746),
        ('DELROUTE', 'Xewkija Gozo', 60, 747),
        ('DELROUTE', 'Tarxien', 61, 748),
        ('DELROUTE', 'Zurrieq', 62, 749),
        ('DELROUTE', 'Swieqi', 63, 750);
    
    -- Display number of affected rows
    print 'Insert completed successfully, rows inserted: ' + cast(@@rowcount as varchar(10));
    
    commit tran;
    print 'Transaction committed successfully';
    
end try
begin catch
    -- If error occurs, rollback transaction
    if @@trancount > 0
        rollback tran;
    
    -- Display detailed error information
    print 'Error occurred, transaction rolled back';
    print 'Error number: ' + cast(error_number() as varchar(10));
    print 'Error message: ' + error_message();
    print 'Error line: ' + cast(error_line() as varchar(10));
    print 'Error severity: ' + cast(error_severity() as varchar(10));
    
    -- Check which records might already exist (for troubleshooting)
    print 'Checking existing records in range 737-750:';
    select TXT_PRIMARY, TXT_ORIGIN, TXT_USER_TEXT 
    from SYS_LOOKUP_TEXT 
    where TXT_PRIMARY between 737 and 750
    order by TXT_PRIMARY;
    
end catch;

-- Verify the insert results
select 
    TXT_PRIMARY,
    TXT_ORIGIN,
    TXT_USER_TEXT,
    TXT_SORT_ORDER
from SYS_LOOKUP_TEXT 
where TXT_PRIMARY between 737 and 750
order by TXT_PRIMARY;



-- update text to UPPER case
use SVBeauty;
begin try
    begin tran;
    
    -- Update all DELROUTE records to uppercase
    update SYS_LOOKUP_TEXT 
    set TXT_USER_TEXT = UPPER(TXT_USER_TEXT)
    where TXT_PRIMARY between 737 and 750
      and TXT_ORIGIN = 'DELROUTE';
    
    -- Display number of affected rows
    print 'Update completed successfully, rows updated: ' + cast(@@rowcount as varchar(10));
    
    commit tran;
    print 'Transaction committed successfully';
    
end try
begin catch
    -- If error occurs, rollback transaction
    if @@trancount > 0
        rollback tran;
    
    -- Display detailed error information
    print 'Error occurred, transaction rolled back';
    print 'Error number: ' + cast(error_number() as varchar(10));
    print 'Error message: ' + error_message();
    print 'Error line: ' + cast(error_line() as varchar(10));
    print 'Error severity: ' + cast(error_severity() as varchar(10));
    
end catch;

-- Verify the update results
print 'Updated records (now in uppercase):';
select 
    TXT_PRIMARY,
    TXT_ORIGIN,
    TXT_USER_TEXT,
    TXT_SORT_ORDER
from SYS_LOOKUP_TEXT 
where TXT_PRIMARY between 737 and 750
  and TXT_ORIGIN = 'DELROUTE'
order by TXT_PRIMARY;