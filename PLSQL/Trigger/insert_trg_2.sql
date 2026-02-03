DROP TABLE employee;

CREATE TABLE employee (
    eid int PRIMARY KEY,
    name varchar(32) NOT NULL,
    salary float CHECK(salary > 0)
);

-- Question
-- Create a trigger such that:
-- * Whenever a new employee is inserted, if the salary is less than 25000, automatically set it to 25000.
-- * Also, maintain an audit table that records every insert (eid, name, final_salary, inserted_at).

-- Audit Table
CREATE TABLE employee_audit (
    eid int,
    name varchar(32),
    final_salary float,
    inserted_at timestamp
);

-- TRIGGER FUNCTION
CREATE OR REPLACE FUNCTION employee_insert_trg()
RETURNS TRIGGER AS $$
DECLARE
    ts TIMESTAMP ; -- CURRENT_TIMESTAMP();
BEGIN

    if NEW.salary < 25000 then
        NEW.salary := 25000;
    end if;

    ts := NOW();
    -- log in audit table
    INSERT INTO employee_audit VALUES(NEW.eid, NEW.name, NEW.salary, ts);

    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

--TRIGGER
CREATE TRIGGER employee_insert_trg
BEFORE INSERT
ON employee
FOR EACH ROW
EXECUTE PROCEDURE employee_insert_trg();