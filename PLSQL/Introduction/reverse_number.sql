
CREATE OR REPLACE FUNCTION reverse_num(num in int)
RETURNS int AS $$
DECLARE
    reverse int = 0;
BEGIN

    while num != 0 loop
        reverse := (reverse * 10 ) + num % 10;
        num := num / 10;
    end loop;
    return reverse;
END;
$$ LANGUAGE 'plpgsql';