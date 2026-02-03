
CREATE OR REPLACE FUNCTION get_all_info(t_rno in student.rno%TYPE)
RETURNS SETOF student AS $$
DECLARE
    s_rec student%ROWTYPE;
BEGIN 

    SELECT * INTO s_rec
    FROM student 
    WHERE rno = t_rno;

    return next s_rec;
END;
$$ LANGUAGE 'plpgsql';