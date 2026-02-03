
CREATE OR REPLACE FUNCTION get_all_info(t_rno in student.rno%TYPE)
RETURNS SETOF student AS $$
BEGIN 
    RETURN QUERY 
    SELECT *
    FROM student 
    WHERE rno = t_rno;
END;
$$ LANGUAGE 'plpgsql';