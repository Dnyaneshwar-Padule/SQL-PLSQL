

CREATE OR REPLACE FUNCTION get_students_with_name_containing(ch in char(1))
RETURNS SETOF student aS $$
BEGIN
    RETURN QUERY
    select * 
    from student
    WHERE name like '%' || ch || '%'; 
END;
$$ LANGUAGE 'plpgsql';