
CREATE OR REPLACE FUNCTION add(a in int, b in int) RETURNS int AS'
DECLARE 
    ans int;
BEGIN
    ans = a + b;
    return ans;
END;
'LANGUAGE 'plpgsql';