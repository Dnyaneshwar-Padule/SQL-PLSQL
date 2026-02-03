

CREATE OR REPLACE FUNCTION create_arr()
RETURNS void AS $$
DECLARE 
    int_arr int[] = ARRAY[1,2,3,4,5,6,7,8,9,10];
BEGIN 
    raise notice 'Array : %', int_arr;
END;
$$ LANGUAGE 'plpgsql';