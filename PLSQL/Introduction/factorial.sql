
CREATE OR REPLACE FUNCTION factorial(n in int)
RETURNS int AS $$
BEGIN 
    if n <= 1 then 
        return 1;
    end if;

    return n * (factorial(n - 1));
END;
$$ LANGUAGE 'plpgsql';