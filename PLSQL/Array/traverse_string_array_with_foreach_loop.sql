


CREATE OR REPLACE FUNCTION traverse_str_arr()
RETURNS void AS $$
DECLARE 
    colors varchar[] = Array['RED', 'ORANGE', 'PURPLE', 'YELLOW', 'GREEN', 'WHITE'];
    color text;
BEGIN 

    FOREACH color IN ARRAY colors
    loop
        raise notice 'Color : %', color;
    end loop;

END;
$$ LANGUAGE 'plpgsql';