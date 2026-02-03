

CREATE OR REPLACE FUNCTION traverse_arr()
RETURNS void AS $$
DECLARE 
    int_arr int[] = ARRAY[1,2,3,4,5,6,7,8,9,10];
    element int;
BEGIN 
   -- Using for each loop
   FOREACH  element in ARRAY int_arr
   loop
        raise notice 'Element : %', element;
   end loop; 

END;
$$ LANGUAGE 'plpgsql';