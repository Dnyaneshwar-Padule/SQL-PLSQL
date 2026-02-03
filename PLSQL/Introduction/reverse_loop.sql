
CREATE OR REPLACE FUNCTION rev(n in int) 
RETURNS void AS $$
BEGIN 
    loop
        if n < 1 then 
            EXIT;
        end if;

        raise notice '%', n; 
        n := n - 1;
    end loop;
END;
$$ LANGUAGE 'plpgsql';