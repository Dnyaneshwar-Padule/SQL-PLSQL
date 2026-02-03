
CREATE OR REPLACE FUNCTION add() RETURNS int AS'
DECLARE
    a int := 5;
    b int := 10;
    ans int;
BEGIN
    ans := a + b;
    return ans;
END;
'LANGUAGE 'plpgsql';