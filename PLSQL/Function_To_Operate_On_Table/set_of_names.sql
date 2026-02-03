
CREATE OR REPLACE FUNCTION students_with_name_starting(ch in char(1))
RETURNS SETOF student AS $$
BEGIN 

    RETURN QUERY
    select * 
    from student
    WHERE name like ch || '%';
END;
$$ LANGUAGE 'plpgsql'; 