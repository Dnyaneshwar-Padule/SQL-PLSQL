
CREATE OR REPLACE FUNCTION largest(a in int, b in int, c in int) RETURNS int AS'
BEGIN 
    if a > b and a > c then 
        return a;
    elsif b > c then 
        return b;
    else 
        return c;
    end if;
END;
'LANGUAGE 'plpgsql';