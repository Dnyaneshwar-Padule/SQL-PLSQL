
CREATE OR REPLACE FUNCTION is_palindrome(num in int)
RETURNS boolean AS $$
DECLARE
    reverse int := 0;
    temp int := num; 
BEGIN

    WHILE num != 0 loop
        reverse := (reverse * 10) + num % 10;
        num = num / 10;
    end loop;

    if temp = reverse then
        return true;
    else 
        return false;
    end if;
END;
$$ LANGUAGE 'plpgsql';