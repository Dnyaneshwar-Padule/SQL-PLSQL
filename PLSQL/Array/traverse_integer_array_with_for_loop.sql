
CREATE OR REPLACE FUNCTION traverse_arr()
RETURNS void AS $$
DECLARE 
    integers int[] = Array[9,8,7,6,5,4,3,2,1,0];
BEGIN 

    for i in 1..array_length(integers, 1)
    loop
        raise notice 'Element: %  ,Index: %', integers[i], i;
    end loop;

END;
$$ LANGUAGE 'plpgsql';