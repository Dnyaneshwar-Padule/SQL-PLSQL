

CREATE OR REPLACE FUNCTION get_char(ch in int)
RETURNS CHAR(1) AS $$
BEGIN 
    return CHR(ch);
END;
$$ LANGUAGE 'plpgsql';