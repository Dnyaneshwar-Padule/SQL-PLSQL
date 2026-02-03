
CREATE OR REPLACE FUNCTION get_students_with_per_greater_than(t_per in student.per%TYPE)
RETURNS TABLE(
    new_rno student.rno%TYPE,
    new_name student.name%TYPE,
    new_per student.per%TYPE,
    new_username student.username%TYPE,
    new_password student.password%TYPE
    )
 
AS $$
BEGIN 
    RETURN QUERY
    SELECT * FROM student
    WHERE per > t_per; 
END;
$$ LANGUAGE 'plpgsql';