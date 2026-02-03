
CREATE OR REPLACE FUNCTION get_min(numbers in int[])
RETURNS int AS $$
DECLARE 
    min int;
BEGIN 

    if array_length(numbers, 1) IS NULL then
        raise notice 'Array is empty !';
        return 0;
    end if;

    min := numbers[1];

    for i in 2..array_length(numbers, 1) loop
        if min > numbers[i] then
            min := numbers[i];
        end if;
    end loop;

    return min;

END;
$$ LANGUAGE 'plpgsql';