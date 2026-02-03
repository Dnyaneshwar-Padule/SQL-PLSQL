
CREATE OR REPLACE FUNCTION max_min()
RETURNS SETOF student.per%TYPE AS $$
DECLARE
    max_per student.per%TYPE;
    min_per student.per%TYPE;
BEGIN 

    SELECT max(per), min(per) INTO max_per, min_per
    FROM student;

    if FOUND then
        return next max_per;
        return next min_per;
    else
        return next NULL;
    end if;
END;
$$ LANGUAGE 'plpgsql';