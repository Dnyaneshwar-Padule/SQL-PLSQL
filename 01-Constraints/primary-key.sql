/*
    PRIMARY KEY is used to uniquely identify every record in a table.
    It is basically a combination of UNIQUE and NOT NULL, so a PRIMARY KEY can never be null and every value must be unique.

    The real purpose of a PRIMARY KEY is for relationships and JOINS,
    because it helps connect one table to another in a reliable way.

    Technically, we can achieve the same using NOT NULL + UNIQUE,
    but the RDBMS cannot depend on the user to always apply both correctly.
    So they created a separate PRIMARY KEY constraint for this purpose.

    - A table can have only one PRIMARY KEY.

    Syntax:
        column_name data_type PRIMARY KEY
*/


------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* 
Creating student table with rno (roll_number) as PRIMARY KEY.

    A Student table can have **rno (roll_no)** as the PRIMARY KEY, and it makes sense because we usually use roll numbers to uniquely identify a student.

    A student may have other unique values like email ID, phone number, PNR, or enrollment number.
    But all of these **cannot** be PRIMARY KEYs.
    A table can have **only one** PRIMARY KEY.

    Logically, we do not use phone numbers or email IDs to identify a student in a database.
    Values like **roll_no, PNR, and enrollment_number** are more closely connected to the student entity.

    So any one of them can be chosen as the PRIMARY KEY based on requirements.
    Most of the time roll_no is used, but using PNR or enrollment_number also makes sense.
*/

DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per FLOAT CHECK(per >= 0 and per <= 100)
);


INSERT INTO student VALUES(101, 'AAA', 60);
INSERT INTO student VALUES(102, 'BBB', 70);
INSERT INTO student VALUES(103, 'CCC', 80);
INSERT INTO student VALUES(103, 'DDD', 90);
INSERT INTO student VALUES(105, 'EEE', 65);
INSERT INTO student VALUES(106, 'FFF', 75);
INSERT INTO student VALUES(106, 'GGG', 85);



/* MySQL */
    INSERT INTO student VALUES(101, 'AAA', 60);
    Query OK, 1 row affected (0.001 sec)

    INSERT INTO student VALUES(102, 'BBB', 70);
    Query OK, 1 row affected (0.001 sec)

    INSERT INTO student VALUES(103, 'CCC', 80);
    Query OK, 1 row affected (0.002 sec)

    INSERT INTO student VALUES(103, 'DDD', 90);
    ERROR 1062 (23000): Duplicate entry '103' for key 'PRIMARY'
        -- Record does not inserted as rno 103 is already used or present in the table. (Duplicates not allowed.)

    INSERT INTO student VALUES(105, 'EEE', 65);
    Query OK, 1 row affected (0.001 sec)

    MariaDB [test]> INSERT INTO student VALUES(106, 'FFF', 75);
    Query OK, 1 row affected (0.001 sec)

    MariaDB [test]> INSERT INTO student VALUES(106, 'GGG', 85);
    ERROR 1062 (23000): Duplicate entry '106' for key 'PRIMARY'
        -- Record does not inserted as rno 103 is already used or present in the table. (Duplicates not allowed.)

select * from student;
+-----+------+------+
| rno | name | per  |
+-----+------+------+
| 101 | AAA  |   60 |
| 102 | BBB  |   70 |
| 103 | CCC  |   80 |
| 105 | EEE  |   65 |
| 106 | FFF  |   75 |
+-----+------+------+




/* PostgreSQL */

    ERROR:  duplicate key value violates unique constraint "student_pkey"
    DETAIL:  Key (rno)=(103) already exists.
        -- Record does not inserted as rno 103 is already used or present in the table. (Duplicates not allowed.)
    

    ERROR:  duplicate key value violates unique constraint "student_pkey"
    DETAIL:  Key (rno)=(106) already exists.
        -- Record does not inserted as rno 103 is already used or present in the table. (Duplicates not allowed.)


    INSERT INTO student(name, per) VALUES('III', 85);
    ERROR:  null value in column "rno" of relation "student" violates not-null constraint
    DETAIL:  Failing row contains (null, III, 85).
        -- Record does not inserted as rno can not be null. (NULL not allowed).
 
select * from student;
 rno | name | per 
-----+------+-----
 101 | AAA  |  60
 102 | BBB  |  70
 103 | CCC  |  80
 105 | EEE  |  65
 106 | FFF  |  75




/*  
    Creating table with multiple PRIMARY KEYs 
*/

DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    PNR char(10) PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float CHECK(per >= 0 and per <= 100)
);

/* MySQL */
MariaDB [test]> CREATE TABLE student(
    ->     rno int PRIMARY KEY,
    ->     PNR char(10) PRIMARY KEY,
    ->     name varchar(32) NOT NULL,
    ->     per float CHECK(per >= 0 and per <= 100)
    -> );
ERROR 1068 (42000): Multiple primary key defined
MariaDB [test]> 



/* PostgreSQL */
CREATE TABLE student(
    rno int PRIMARY KEY,
    PNR char(10) PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float CHECK(per >= 0 and per <= 100)
);

ERROR:  multiple primary keys for table "student" are not allowed
LINE 3:     PNR char(10) PRIMARY KEY,
