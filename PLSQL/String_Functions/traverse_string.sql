
CREATE OR REPLACE FUNCTION traverse(str in varchar)
RETURNS TEXT AS $$
DECLARE    
    ch char(1);
    result TEXT := '';
BEGIN 

    FOR i in 1..LENGTH(str)-1
    LOOP
        ch := SUBSTRING(str, i , 1);
        result := result || ch || ' ';
        raise notice '%, %', ch, result;
    END LOOP;
    return result;
END;
$$ LANGUAGE 'plpgsql';