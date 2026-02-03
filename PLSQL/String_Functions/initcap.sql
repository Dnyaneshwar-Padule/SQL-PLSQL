
CREATE OR REPLACE FUNCTION initial_cap(str in varchar)
RETURNS varchar AS $$
BEGIN 
    return INITCAP(str);
END;
$$ LANGUAGE 'plpgsql';