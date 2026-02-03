

CREATE OR REPLACE FUNCTION get_student_per_by_name(t_name in student.name%TYPE)
RETURNS student.per%TYPE AS $$
DECLARE
    t_per student.per%TYPE;
BEGIN 

    SELECT per INTO t_per
    from student 
    WHERE name LIKE t_name;

    return t_per;
END;
$$ LANGUAGE 'plpgsql';