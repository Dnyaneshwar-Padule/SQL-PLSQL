
CREATE OR REPLACE FUNCTION squr(a in int)
RETURNS int AS $$
BEGIN
    return a * a;
END;
$$ LANGUAGE 'plpgsql';