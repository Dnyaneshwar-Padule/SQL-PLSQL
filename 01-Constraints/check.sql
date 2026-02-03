/*

    When we apply CHECK constraint to a column, it checks given condition before inserting the record.
    If the condition is met, it inseets the records, else not.

    Syntax :
        column datatype CHECK( condition )

    condition may have 'and', 'or'.
    - condition_1 and condition_2
    - condition_1 or condition_2
    - (consition_1 and condition_2) or (consition_3 and consition_4)

    We can use it for columns like, percentage, as we know percentage is always in between 0 to 100 (inclusive)
    there is no negative percentage or above 100, so here we can apply the check constraint, to check is percentage is valid or not.

    ex. percentage float CHECK(per >= 0 and per <= 100) 
*/

/*
    Student table without CHECK constraint.
*/
DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per FLOAT
);

INSERT INTO student VALUES(101, 'AAA', 78.23);
INSERT INTO student VALUES(102, 'BBB', 56.80);
INSERT INTO student VALUES(103, 'CCC', 85.76);
INSERT INTO student VALUES(104, 'DDD', -35.90);
INSERT INTO student VALUES(105, 'EEE', 125.80);

/* MySQL */ 
select * from student;
+-----+------+-------+
| rno | name | per   |
+-----+------+-------+
| 101 | AAA  | 78.23 |
| 102 | BBB  |  56.8 |
| 103 | CCC  | 85.76 |
| 104 | DDD  | -35.9 |  <-- Invalid record (Invalid percentage)
| 105 | EEE  | 125.8 |  <-- Invalid record (Invalid percentage)
+-----+------+-------+



/* PostgreSQL */
select * from student;
 rno | name |  per  
-----+------+-------
 101 | AAA  | 78.23
 102 | BBB  |  56.8
 103 | CCC  | 85.76
 104 | DDD  | -35.9  <-- Invalid record (Invalid percentage)
 105 | EEE  | 125.8  <-- Invalid record (Invalid percentage)


/*
    We can see, here two invalid records are added in the table
*/


/* 
    Student table with CHECK constraint 
*/
DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per FLOAT CHECK(per >= 0 and per <= 100)
);

INSERT INTO student VALUES(101, 'AAA', 78.23);
INSERT INTO student VALUES(102, 'BBB', 56.80);
INSERT INTO student VALUES(103, 'CCC', 85.76);
INSERT INTO student VALUES(104, 'DDD', -35.90);
INSERT INTO student VALUES(105, 'EEE', 125.80);


/* MySQL */
    -- INSERT INTO student VALUES(101, 'AAA', 78.23);
    -- Query OK, 1 row affected (0.001 sec)

    -- INSERT INTO student VALUES(102, 'BBB', 56.80);
    -- Query OK, 1 row affected (0.001 sec)

    -- INSERT INTO student VALUES(103, 'CCC', 85.76);
    -- Query OK, 1 row affected (0.001 sec)

    INSERT INTO student VALUES(104, 'DDD', -35.90);
    ERROR 4025 (23000): CONSTRAINT `student.per` failed for `test`.`student`
        -- Record not inserted.

    INSERT INTO student VALUES(105, 'EEE', 125.80);
    ERROR 4025 (23000): CONSTRAINT `student.per` failed for `test`.`student`
        -- Record not inserted.

select * from student;
+-----+------+-------+
| rno | name | per   |
+-----+------+-------+
| 101 | AAA  | 78.23 |
| 102 | BBB  |  56.8 |
| 103 | CCC  | 85.76 |
+-----+------+-------+


/* PostgreSQL */
    ERROR:  new row for relation "student" violates check constraint "student_per_check"
    DETAIL:  Failing row contains (104, DDD, -35.9).
        -- Record not inserted.

    ERROR:  new row for relation "student" violates check constraint "student_per_check"
    DETAIL:  Failing row contains (105, EEE, 125.8).
        -- Record not inserted.

select * from student;
 rno | name |  per  
-----+------+-------
 101 | AAA  | 78.23
 102 | BBB  |  56.8
 103 | CCC  | 85.76



/*
    We can see, with CHECK constraint, only the valid records are inserted.
*/
