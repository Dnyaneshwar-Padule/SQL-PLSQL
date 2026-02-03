
CREATE OR REPLACE FUNCTION get_max(numbers in int[])
RETURNS int AS $$
DECLARE
    max int;
BEGIN 

    if array_length(numbers, 1) IS NULL then
        raise notice 'Array is empty !';
        return 0;
    end if;

    max := numbers[1];

    for i in 2..array_length(numbers, 1) loop
        if max < numbers[i] then
            max := numbers[i];
        end if;
    end loop;

    return max;
END;
$$ LANGUAGE 'plpgsql';