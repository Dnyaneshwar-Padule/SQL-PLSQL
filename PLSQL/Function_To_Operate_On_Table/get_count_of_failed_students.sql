
CREATE OR REPLACE FUNCTION get_failed_students_count()
RETURNS int AS $$
DECLARE
    count int;
BEGIN

    SELECT count(*) INTO count
    FROM student
    WHERE per < 40;

    return count;
END;
$$ LANGUAGE 'plpgsql';
