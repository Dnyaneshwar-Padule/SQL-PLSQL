
-- Suppose there is a student table like 
-- rno int PRIMARK KEY
-- name varchar(32) not null
-- per float check(per >= 0 and per <= 100)

-- the get_student_name(rno) will return student name, from student roll number

CREATE OR REPLACE FUNCTION get_student_name(trno in student.rno%TYPE )
RETURNS student.name%TYPE AS $$
DECLARE
    tname student.name%TYPE; -- same data type as name column in student table
BEGIN

    select name INTO tname
    from student 
    where rno = trno;

    if NOT FOUND then
        return 'No record found !';
    end if;

    return tname;
END;
$$ LANGUAGE 'plpgsql';