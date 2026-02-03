
CREATE OR REPLACE FUNCTION in_string(str in varchar, sub_str in varchar)
RETURNS varchar AS $$
BEGIN 
    return POSITION(sub_str IN str);
END;
$$ LANGUAGE 'plpgsql';