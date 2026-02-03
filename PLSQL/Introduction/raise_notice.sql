
CREATE OR REPLACE FUNCTION show() RETURNS void AS'
BEGIN
    raise notice ''This is an reaised notice !'';
END;
'LANGUAGE 'plpgsql';