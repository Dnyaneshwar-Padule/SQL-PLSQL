CREATE OR REPLACE FUNCTION is_prime(num in int) 
RETURNS boolean AS $$
DECLARE   
    is_prime_flag boolean := true;
BEGIN

    if num < 2 then
        -- raise notice '% is not prime !', num;
        return false;
    end if;   

    for i in 2..num-1
    loop
        if num % i = 0 then
            is_prime_flag = false;
            EXIT;
        end if;
    end loop;

    if is_prime_flag then
        -- raise notice '% is prime !', num;
        return true;
    else 
        -- raise notice '% is not prime !', num;
        return false;
    end if;
END;
$$ LANGUAGE 'plpgsql';