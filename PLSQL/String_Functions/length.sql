

CREATE OR REPLACE FUNCTION str_length(str in varchar)
RETURNS int AS $$
BEGIN 
    return LENGTH(str);
END;
$$ LANGUAGE 'plpgsql';