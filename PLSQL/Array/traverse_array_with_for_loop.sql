
CREATE OR REPLACE FUNCTION traverse_str_arr()
RETURNS void AS $$
DECLARE 
    colors varchar[] = ARRAY['RED', 'ORANGE', 'YELLOW', 'PINK', 'CYAN', 'MAROON', 'OLIVE', 'INDIGO'];
BEGIN 

    for i in 1..array_length(colors, 1)
    loop
        raise notice 'Color : %', colors[i];
    end loop;

END;
$$ LANGUAGE 'plpgsql';