/*

    If we apply UNIQUE constraint to a column, then that column does not allow duplicate values.
    We need this constraint for column for Unique values like phone number, email ID, and other unique values.


    Syntax:
        column_name datatype UNIQUE

    Example :-
*/

/* without UNIQUE */
DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float,
    phone char(10)
);

INSERT INTO student VALUES(101, 'AAA', 60, '9090909090');
INSERT INTO student VALUES(102, 'BBB', 70, '9876543210');
INSERT INTO student VALUES(103, 'CCC', 80, '9078563412');
INSERT INTO student VALUES(104, 'DDD', 90, '8990789078');
INSERT INTO student VALUES(105, 'EEE', 65, '9090909090');
INSERT INTO student VALUES(106, 'FFF', 70, '9090909090');



/* MySQL */
select * from student;
+-----+------+------+------------+
| rno | name | per  | phone      |
+-----+------+------+------------+
| 101 | AAA  |   60 | 9090909090 |
| 102 | BBB  |   70 | 9876543210 |
| 103 | CCC  |   80 | 9078563412 |
| 104 | DDD  |   90 | 8990789078 |
| 105 | EEE  |   65 | 9090909090 |
| 106 | FFF  |   70 | 9090909090 |
+-----+------+------+------------+


/* PostgreSQL*/
 select * from student;
 rno | name | per |   phone    
-----+------+-----+------------
 101 | AAA  |  60 | 9090909090
 102 | BBB  |  70 | 9876543210
 103 | CCC  |  80 | 9078563412
 104 | DDD  |  90 | 8990789078
 105 | EEE  |  65 | 9090909090
 106 | FFF  |  70 | 9090909090



/*
    We can see that students wil rno 101, 105 and 106 got same phone number, and it is not correct
    Every student should have an nunique phone number.
*/


/* Table with UNIQUE constraint */
DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float,
    phone char(10) UNIQUE
);

INSERT INTO student VALUES(101, 'AAA', 60, '9090909090');
INSERT INTO student VALUES(102, 'BBB', 70, '9876543210');
INSERT INTO student VALUES(103, 'CCC', 80, '9078563412');
INSERT INTO student VALUES(104, 'DDD', 90, '8990789078');
INSERT INTO student VALUES(105, 'EEE', 65, '9090909090');
INSERT INTO student VALUES(106, 'FFF', 70, '9090909090');


/* MySQL */
    --  INSERT INTO student VALUES(101, 'AAA', 60, '9090909090');
    -- Query OK, 1 row affected (0.002 sec)
    -- Record Inserted.

    -- INSERT INTO student VALUES(102, 'BBB', 70, '9876543210');
    -- Query OK, 1 row affected (0.001 sec)
    -- Record Inserted.

    -- INSERT INTO student VALUES(103, 'CCC', 80, '9078563412');
    -- Query OK, 1 row affected (0.001 sec)
    -- Record Inserted.

    -- INSERT INTO student VALUES(104, 'DDD', 90, '8990789078');
    -- Query OK, 1 row affected (0.002 sec)
    -- Record Inserted.

    INSERT INTO student VALUES(105, 'EEE', 65, '9090909090');
    ERROR 1062 (23000): Duplicate entry '9090909090' for key 'phone'
        -- Duplicate phone number not allowed.

    INSERT INTO student VALUES(106, 'FFF', 70, '9090909090');
    ERROR 1062 (23000): Duplicate entry '9090909090' for key 'phone'
        -- Duplicate phone number not allowed.


select * from student;
+-----+------+------+------------+
| rno | name | per  | phone      |
+-----+------+------+------------+
| 101 | AAA  |   60 | 9090909090 |
| 102 | BBB  |   70 | 9876543210 |
| 103 | CCC  |   80 | 9078563412 |
| 104 | DDD  |   90 | 8990789078 |
+-----+------+------+------------+

-- Only Records with UNIQUE phone.



/* PostgreSQL */
    ERROR:  duplicate key value violates unique constraint "student_phone_key"
    DETAIL:  Key (phone)=(9090909090) already exists.
        -- Duplicate phone number not allowed

    ERROR:  duplicate key value violates unique constraint "student_phone_key"
    DETAIL:  Key (phone)=(9090909090) already exists.
        -- Duplicate phone number not allowed.

select * from student;
 rno | name | per |   phone    
-----+------+-----+------------
 101 | AAA  |  60 | 9090909090
 102 | BBB  |  70 | 9876543210
 103 | CCC  |  80 | 9078563412
 104 | DDD  |  90 | 8990789078

-- Only record with unique phone.