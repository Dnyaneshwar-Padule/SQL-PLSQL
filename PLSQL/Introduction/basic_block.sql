
CREATE OR REPLACE FUNCTION message() RETURNS varchar AS'
DECLARE
    -- No variable declaration
BEGIN
    return ''Hello World !'';
END;
'LANGUAGE 'plpgsql';