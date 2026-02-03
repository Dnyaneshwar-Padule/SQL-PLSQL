
CREATE OR REPLACE FUNCTION get_student_per(trno in student.rno%TYPE)
RETURNS student.per%TYPE AS $$
DECLARE
    t_per student.per%TYPE;
BEGIN
    select per INTO t_per
    from student
    where rno = trno;

    return t_per;
END;
$$ LANGUAGE 'plpgsql';