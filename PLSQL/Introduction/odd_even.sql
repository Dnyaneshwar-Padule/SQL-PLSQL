
CREATE OR REPLACE FUNCTION is_even(a in int) RETURNS boolean AS'
BEGIN 
    if a % 2 then 
        raise notice ''% is Odd.'', a;
        return false;
    else
        raise notice ''% is Even.'', a;
        return true;
    end if;
END;
'LANGUAGE 'plpgsql';