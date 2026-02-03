
CREATE OR REPLACE FUNCTION max(a in int, b in int) RETURNS int AS'
BEGIN
    if a > b then 
        return a;
    else
        return b;
    end if;
END;
'LANGUAGE 'plpgsql';