
CREATE OR REPLACE FUNCTION name_and_marks()
RETURNS void AS $$
DECLARE 
    -- Data of five students
    students varchar[] = Array['Soham', 'Mohan', 'Madan', 'Kundan', 'Mayur'];
    marks float[] = Array[78.34, 69.34, 56.45, 90.34, 92.34]; 
BEGIN 

    for i in 1..array_length(students, 1)
    loop
        raise notice 'Student: %,  Marks: %', students[i], marks[i];
    end loop;

END;
$$ LANGUAGE 'plpgsql';