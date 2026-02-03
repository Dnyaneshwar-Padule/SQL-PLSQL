-- ONLY UPDATE EMPLOYEE record, if new SAlARY is equal to or greater than OLD salary

--TABLE
DROP TABLE employee;

CREATE TABLE employee(
    eid int PRIMARY KEY,
    name varchar(32) NOT NULL,
    salary float CHECk(salary > 0)
);

--Function
CREATE OR REPLACE FUNCTION employee_update_trg()
RETURNS TRIGGER AS $$
BEGIN
    if NEW.salary >= OLD.salary then
        return NEW;
    else
        return OLD;
    end if;
END;
$$ LANGUAGE 'plpgsql';

--TRIGGER
CREATE TRIGGER employee_update_trg
BEFORE UPDATE
ON employee
FOR EACH ROW
EXECUTE PROCEDURE employee_update_trg();

-- some initial records
INSERT INTO employee values(101, 'AAA', 20000);
INSERT INTO employee values(102, 'BBB', 30000);
INSERT INTO employee values(103, 'CCC', 30000);
INSERT INTO employee values(104, 'DDD', 40000);

-- UPDATE 
UPDATE employee set salary = (salary + 5);
UPDATE employee set salary = (salary - 5);