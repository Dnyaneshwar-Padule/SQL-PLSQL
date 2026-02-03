
CREATE OR REPLACE FUNCTION show(msg in varchar, cnt in int) 
RETURNS void AS $$
BEGIN

    if cnt < 0 then
        raise notice 'Invalid count !';
        return;
    end if;

    for i in 1..cnt
    loop
        raise notice '%',msg;
    end loop;
END;
$$ LANGUAGE 'plpgsql';
