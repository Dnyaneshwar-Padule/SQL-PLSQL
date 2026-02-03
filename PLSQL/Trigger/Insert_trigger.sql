
-- Table
DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float,
    age int not null,
    is_adult boolean not null
);

-- User will insert rno, name, per and age
-- We will put value in is_adult column with a trigger

-- The function which will be executed by the trigger
CREATE OR REPLACE FUNCTION insert_trg()
RETURNS TRIGGER AS $$
BEGIN
    if NEW.age > 18 then
        NEW.is_adult = true;
    else
        NEW.is_adult = false;
    end if;

    return NEW;
END;
$$ LANGUAGE 'plpgsql';

--TRIGGER
CREATE TRIGGER insert_trg
BEFORE INSERT or UPDATE
ON student
FOR EACH ROW
EXECUTE PROCEDURE insert_trg();