
CREATE OR REPLACE FUNCTION get_ascii(ch in char)
RETURNS int AS $$
BEGIN 
    return ASCII(ch);
END;
$$ LANGUAGE 'plpgsql';