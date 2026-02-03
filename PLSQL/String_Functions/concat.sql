
CREATE OR REPLACE FUNCTION concat_str(str1 in varchar, str2 in varchar)
RETURNS varchar AS $$
BEGIN 
    return CONCAT(str1, str2);
END;
$$ LANGUAGE 'plpgsql';