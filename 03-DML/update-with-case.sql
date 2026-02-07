/*
    Example on UPDATE Query on this student table
*/
DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float CHECK(per >= 0 and per <= 100),
    city varchar(32) NOT NULL
);

INSERT INTO student VALUES(101, 'AAA', 60, 'Pune');
INSERT INTO student VALUES(102, 'BBB', 70, 'Panji');
INSERT INTO student VALUES(103, 'CCC', 80, 'Mumbai');
INSERT INTO student VALUES(104, 'DDD', 90, 'Solapur');
INSERT INTO student VALUES(105, 'EEE', 65, 'Banglore');
INSERT INTO student VALUES(106, 'FFF', 75, 'Hyderabad');
INSERT INTO student VALUES(107, 'GGG', 85, 'Mumbai');
INSERT INTO student VALUES(108, 'HHH', 95, 'Pune');
INSERT INTO student VALUES(109, 'III', 45, 'Banglore');
INSERT INTO student VALUES(110, 'JJJ', 35, 'Panji');
INSERT INTO student VALUES(111, 'KKK', 82, 'Pune');
INSERT INTO student VALUES(112, 'LLL', 58, 'Mumbai');
INSERT INTO student VALUES(113, 'MMM', 92, 'Hyderabad');
INSERT INTO student VALUES(114, 'NNN', 73, 'Solapur');
INSERT INTO student VALUES(115, 'OOO', 67, 'Banglore');
INSERT INTO student VALUES(116, 'PPP', 88, 'Pune');
INSERT INTO student VALUES(117, 'QQQ', 49, 'Panji');
INSERT INTO student VALUES(118, 'RRR', 77, 'Mumbai');
INSERT INTO student VALUES(119, 'SSS', 33, 'Hyderabad');
INSERT INTO student VALUES(120, 'TTT', 96, 'Solapur')

/*
    Suppose. our student table needs an extra column, GRADE
    and grade is an Derieved attribute, i.e, we can get the value of Grade from per column (percentage)

    like if, per >= 90, Grade is 'A'
    per >= 80 and per < 90, Grade is 'B'
    per >= 70 and per < 80, Grade is 'C'
    per >= 60 and per < 70, Grade is 'D'
    per >= 50 and per < 60, Grade is 'E'
    per < 40, Grade is 'F'
*/

/*
    To do it, we will first add an extra column with ALTER command

    ALTER TABLE student
    ADD COLUMN grade char(1);
*/


/*
    Then we will fire UPDATE COMMANDS like

    UPDATE student
    SET grade = 'A' where per >= 90;

    UPDATE student
    SET grade = 'B' where per >= 80 and per < 90

    UPDATE student
    SET grade = 'C' where per >= 70 and per < 80;

    UPDATE student
    SET grade = 'D' where per >= 60 and per < 70;
    
    UPDATE student
    SET grade = 'E' where per >= 50 and per < 60;
    
    UPDATE student
    SET grade = 'F' where per < 40;
*/

/*
    To do this, we required to fire 6 UPDATE statements.
    But we can do it in one Command, with CASE 
*/

/*
    * Syntax:
    UPDATE table_name
    SET column_name = 
    CASE
        WHEN condition
            THEN value
        WHEN condition
            THEN value
        WHEN condition
            THEN value
        WHEN condition
            THEN value
    END;
*/



ALTER TABLE student
ADD COLUMN grade char(1);

UPDATE student 
SET grade = 
CASE
    WHEN per >= 90
        THEN 'A'
    WHEN per >= 80 and per < 90 
        THEN 'B'
    WHEN per >= 70 and per < 80
        THEN 'C'
    WHEN per >= 60 and per < 70
        THEN 'D'
    WHEN per >= 50 and per < 60
        THEN 'E'
    WHEN per < 40
        THEN 'F'
END;


-- ############################################################ --

MariaDB [test]> ALTER TABLE student
    -> ADD COLUMN grade char(1);
Query OK, 0 rows affected (0.018 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [test]> 
MariaDB [test]> UPDATE student 
    -> SET grade = 
    -> CASE
    ->     WHEN per >= 90
    ->         THEN 'A'
    ->     WHEN per >= 80 and per < 90 
    ->         THEN 'B'
    ->     WHEN per >= 70 and per < 80
    ->         THEN 'C'
    ->     WHEN per >= 60 and per < 70
    ->         THEN 'D'
    ->     WHEN per >= 50 and per < 60
    ->         THEN 'E'
    ->     WHEN per < 40
    ->         THEN 'F'
    -> END;
Query OK, 4 rows affected (0.007 sec)
Rows matched: 4  Changed: 4  Warnings: 0

MariaDB [test]> select * from student;
+-----+------+------+--------+------------------+-------+
| rno | name | per  | city   | email_ID         | grade |
+-----+------+------+--------+------------------+-------+
| 101 | AAA  |   60 | Pune   | AAA101@gmail.com | D     |
| 102 | BBB  |   70 | Pune   | BBB102@gmail.com | C     |
| 103 | CCC  |   80 | Pune   | CCC103@gmail.com | B     |
| 104 | DDD  |   90 | Mumbai | DDD104@gmail.com | A     |
+-----+------+------+--------+------------------+-------+
