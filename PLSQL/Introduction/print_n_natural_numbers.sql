
CREATE OR REPLACE FUNCTION print_n_natural_numbers( n in int) 
RETURNS void AS $$ 
BEGIN 
    for i in 1..n
    loop
        raise notice '%', i;
    end loop;
END;
$$ LANGUAGE 'plpgsql';