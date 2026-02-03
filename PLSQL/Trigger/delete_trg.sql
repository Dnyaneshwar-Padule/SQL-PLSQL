
-- Don't let the user delete the student's who has per >= 40

--TABLE
DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float
);

-- Function which will be executed by the trigger
CREATE OR REPLACE FUNCTION del_trg()
RETURNS TRIGGER AS $$
BEGIN
    if OLD.per >= 40 then
        RETURN NULL;
    else
        RETURN OLD;
    end if;
END;
$$LANGUAGE 'plpgsql';


--TRIGGER
CREATE TRIGGER del_trg
BEFORE DELETE
ON student
FOR EACH ROW
EXECUTE PROCEDURE del_trg();
