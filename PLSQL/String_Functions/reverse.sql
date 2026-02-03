
CREATE OR REPLACE FUNCTION reverse_str(str in varchar)
RETURNS varchar AS $$
BEGIN 
    return REVERSE(str);
END;
$$ LANGUAGE 'plpgsql';