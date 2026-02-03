CREATE OR REPLACE FUNCTION reverse_array(nums in int[])
RETURNS int[] AS $$
DECLARE
    temp int := 0;
    i int := 1;
    j int := array_length(nums, 1);
BEGIN
    if j IS NULL then
        raise notice 'Array is empty !';
        return nums;
    end if;
    
    WHILE i < j loop
        temp := nums[i];
        nums[i] := nums[j];
        nums[j] := temp;

        i := i + 1;
        j := j - 1;
    end loop;

    return nums;
END;
$$ LANGUAGE 'plpgsql';