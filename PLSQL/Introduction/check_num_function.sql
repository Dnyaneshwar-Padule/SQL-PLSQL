
CREATE OR REPLACE FUNCTION check_num(a in int)
RETURNS varchar AS $$
BEGIN 
    if a < 0 then
        return a || ' is negative !';
    elsif a > 0 then
        return a || ' is positive !';
    else
        return a || ' is zero !';
    end if;
END;
$$ LANGUAGE 'plpgsql';