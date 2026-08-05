CASE 
    WHEN InvcDtl.PartNum = 'ARI80835626' THEN (Qty * 0.71)
    WHEN InvcDtl.PartNum = 'ARI80796162' THEN (Qty * 0.71)
    WHEN InvcDtl.PartNum = 'ARI80720692' THEN (Qty * 0.69)
    WHEN InvcDtl.PartNum = 'ARI80808934' THEN (Qty * 0.69)
    WHEN InvcDtl.PartNum = 'ARI80835552' THEN (Qty * 0.73)
    WHEN InvcDtl.PartNum = 'ARI80805766' THEN (Qty * 0.73)
    WHEN InvcDtl.PartNum = 'ALW80761835' THEN (Qty * 0.25)
    WHEN InvcDtl.PartNum = 'ALW80761832A' THEN (Qty * 0.23)
    WHEN InvcDtl.PartNum = 'ALW80761829A' THEN (Qty * 0.23)
    WHEN InvcDtl.PartNum = 'TAM83746874' THEN (Qty * 0.15)
    WHEN InvcDtl.PartNum = 'HEA80798825' THEN (24 * Qty * 0.58)
    WHEN InvcDtl.PartNum = 'PAN80834480' THEN (12 * Qty * 0.29)
    WHEN InvcDtl.PartNum = 'PAN80834479' THEN (24 * Qty * 0.18)
    WHEN InvcDtl.PartNum = 'LEN80830170' THEN (Qty * 0.25)
    WHEN InvcDtl.PartNum = 'LEN80830169' THEN (Qty * 0.25)
    WHEN InvcDtl.PartNum = 'WEL99350124231L' THEN (30 * Qty * 0.21)
    WHEN InvcDtl.PartNum = 'LEN80776940' THEN (Qty * 0.27)
    WHEN InvcDtl.PartNum = 'LEN80776953' THEN (Qty * 0.27)
    WHEN InvcDtl.PartNum = 'WEL81383890L' THEN (23 * Qty * 0.32)
    WHEN InvcDtl.PartNum = 'WEL99350175001L' THEN (264 * Qty * 0.229) 
    WHEN InvcDtl.PartNum = 'ARI80831705' THEN (Qty * 0.79)
    WHEN InvcDtl.PartNum = 'ARI80831787' THEN (Qty * 0.79)
    WHEN InvcDtl.PartNum = 'ARI80830193' THEN (Qty * 0.78)
    WHEN InvcDtl.PartNum = 'ARI80830192' THEN (Qty * 0.78)
    WHEN InvcDtl.PartNum = 'ARI80834339' THEN (Qty * 0.76)
    WHEN InvcDtl.PartNum = 'ARI80834349' THEN (Qty * 0.76)
    WHEN InvcDtl.PartNum = 'LEN80830168' THEN (Qty * 0.25)
    WHEN InvcDtl.PartNum = 'LEN80830167' THEN (Qty * 0.25)
    WHEN InvcDtl.PartNum = 'FAI80824233' THEN (Qty * 0.15)
    WHEN InvcDtl.PartNum = 'FAI80769133' THEN (Qty * 0.19)
    WHEN InvcDtl.PartNum = 'ALW80840367' THEN (Qty * 0.23)
-- added by Paul on 2nd Sept 2025
    WHEN InvcDtl.PartNum = 'ARI80799236' THEN (Qty * 1.33)
    WHEN InvcDtl.PartNum = 'ARI80834347' THEN (Qty * 1.29)
    WHEN InvcDtl.PartNum = 'ARI80830190' THEN (Qty * 1.17)
    WHEN InvcDtl.PartNum = 'ARI80830195' THEN (Qty * 1.17)
    WHEN InvcDtl.PartNum = 'FAI80852233' THEN (Qty * 0.38)
    WHEN InvcDtl.PartNum = 'FAI80852214' THEN (Qty * 0.22)
    WHEN InvcDtl.PartNum = 'OLD80768422' THEN (Qty * 0.40)
    WHEN InvcDtl.PartNum = 'OLD80824328' THEN (20 * Qty * 0.15)  -- 20-pack
    WHEN InvcDtl.PartNum = 'OLD80824327' THEN (20 * Qty * 0.14)  -- 20-pack
    WHEN InvcDtl.PartNum = 'OLD80824326' THEN (20 * Qty * 0.19)  -- 20-pack
    WHEN InvcDtl.PartNum = 'OLD80768423L' THEN (100 * Qty * 0.40) -- 100-pack
    WHEN InvcDtl.PartNum = 'WEL81463015L' THEN (10 * Qty * 0.49)  -- 10-pack
    WHEN InvcDtl.PartNum = 'HEA80833764' THEN (12 * Qty * 0.31)  -- 12-pack
    WHEN InvcDtl.PartNum = 'HEA80790927' THEN (12 * Qty * 0.31)  -- 12-pack
-- added by Paul on 22nd Oct 2025  
    WHEN InvcDtl.PartNum = 'FAI80864331' THEN (Qty * 0.22)
-- added by Paul on 7th Jan 2026, according to Nicole Spiteri
    WHEN InvcDtl.PartNum = 'ARI80831700' THEN (Qty * 1.18)
-- added by Paul on 17th Jun 2026, according to Nicole Spiteri
    WHEN InvcDtl.PartNum = 'HEA83905344' THEN (24 * Qty * 0.58)
    WHEN InvcDtl.PartNum = 'PAN83909740' THEN (24 * Qty * 0.16)
-- added by Paul on 27 Jul 2026, according to Nicole ticket No.3116554099    
    WHEN InvcDtl.PartNum = 'FAI80824232' THEN (Qty * 0.15)
    WHEN InvcDtl.PartNum = 'OLD80867125' THEN (20 * Qty * 0.14)
    WHEN InvcDtl.PartNum = 'OLD80876100L' THEN (28 * Qty * 0.16)
    WHEN InvcDtl.PartNum = 'ALW80741224A' THEN (Qty * 0.23)
    WHEN InvcDtl.PartNum = 'ALW80774212' THEN (Qty * 0.16)
    WHEN InvcDtl.PartNum = 'ALW83748274' THEN (Qty * 0.31)
    WHEN InvcDtl.PartNum = 'ALW83748275' THEN (Qty * 0.31)
    WHEN InvcDtl.PartNum = 'GIL80762201L' THEN (24 * Qty * 0.09)
    WHEN InvcDtl.PartNum = 'LEN80880000' THEN (Qty * 0.25)
    WHEN InvcDtl.PartNum = 'LEN80879996' THEN (Qty * 0.25)
    WHEN InvcDtl.PartNum = 'LEN80879990' THEN (Qty * 0.26)
    WHEN InvcDtl.PartNum = 'LEN80879999' THEN (Qty * 0.26)
    WHEN InvcDtl.PartNum = 'ARI80879651' THEN (Qty * 0.67)
    WHEN InvcDtl.PartNum = 'ARI80894604' THEN (Qty * 0.67)
    WHEN InvcDtl.PartNum = 'ARI80883863' THEN (Qty * 0.89)
    WHEN InvcDtl.PartNum = 'ARI80883894' THEN (Qty * 0.89)
    WHEN InvcDtl.PartNum = 'ARI80880974' THEN (Qty * 0.93)
    WHEN InvcDtl.PartNum = 'ARI80880976' THEN (Qty * 0.93)
    WHEN InvcDtl.PartNum = 'FAI80769368A' THEN (Qty * 0.42)
    WHEN InvcDtl.PartNum = 'FAIC012488' THEN (Qty * 0.77)
    WHEN InvcDtl.PartNum = 'FAIC012497' THEN (Qty * 0.7)
    WHEN InvcDtl.PartNum = 'FAIC012502' THEN (Qty * 0.3)
    ELSE 0
END