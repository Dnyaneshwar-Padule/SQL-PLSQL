

CREATE OR REPLACE FUNCTION get_average_per()
RETURNS float AS $$
DECLARE
    avg float;
BEGIN

    SELECT avg(per) INTO avg
    from student;

    return avg;
END;
$$ LANGUAGE 'plpgsql';