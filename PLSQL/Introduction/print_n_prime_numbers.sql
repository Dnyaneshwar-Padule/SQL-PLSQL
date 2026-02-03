CREATE OR REPLACE PROCEDURE is_prime(num in int, result out boolean) 
AS $$
BEGIN 
    result := true;

    if num < 2 then 
        result := false;
    end if;

    for i in 2..num-1
    loop
        if num % i = 0 then
            result := false;
            EXIT;
        end if;  
    end loop;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION print_n_prime_numbers(n in int) 
RETURNS void AS $$
DECLARE 
    is_prime_flag boolean := false;
BEGIN
    for i in 1..n-1
    loop
        CALL is_prime(i, is_prime_flag);
        if  is_prime_flag then
            raise notice '% is prime', i;
        end if;
    end loop;
END;
$$ LANGUAGE 'plpgsql';