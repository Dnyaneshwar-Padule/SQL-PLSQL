/*

    While we create a table, some fields (attributes/columns) should always have a value
    logically they can't be null.

    for example, name of someon, as everybody got a name
    or salary of an employee

    so in this case, we use NOT NULL constraint, for that specific column

    once we apply NOT NULL constraint to a column, then while inserting a record in that table, we always need to give a value for that column,
    if we don't provide a value to that column, it won't insert that record, and give CONSTRAINT VIOLATION error.

*/

/*
    The following example describes the use of NOT NUL.
*/

/*

    Scenario 1 :
        student.name column without not null.
*/

CREATE TABLE student(
    rno int PRIMARY KEY, 
    name varchar(32), 
    per float
);

INSERT INTO student values(101,'AAA', 60);
INSERT INTO student values(102,'BBB', 70);
INSERT INTO student values(103,'CCC', 80);
INSERT INTO student values(104,'DDD', 90);

INSERT INTO student(rno, per) values(105, 65);
INSERT INTO student(rno, per) values(106, 75);
INSERT INTO student(rno, per) values(107, 85);

/* MySQL */
select * from student;
/*
+-----+------+------+
| rno | name | per  |
+-----+------+------+
| 101 | AAA  |   60 |
| 102 | BBB  |   70 |
| 103 | CCC  |   80 |
| 104 | DDD  |   90 |
| 105 | NULL |   65 |
| 106 | NULL |   75 |
| 107 | NULL |   85 |
+-----+------+------+
*/

/* PostgreSQL */
select * from student;
/*
 rno | name | per 
-----+------+-----
 101 | AAA  |  60
 102 | BBB  |  70
 103 | CCC  |  80
 104 | DDD  |  90
 105 |      |  65
 106 |      |  75
 107 |      |  85
*/

/*
    Did you see student with rno 105, 106 and 107 does not have a name, which is logically wrong, every student should have a name.
*/

/* Better design, with not null constraint */
CREATE TABLE student(
    rno int PRIMARY KEY, 
    name varchar(32) NOT NULL,
    per float
);

INSERT INTO student values(101,'AAA', 60);
INSERT INTO student values(102,'BBB', 70);
INSERT INTO student values(103,'CCC', 80);
INSERT INTO student values(104,'DDD', 90);

INSERT INTO student(rno, per) values(105, 65);
INSERT INTO student(rno, per) values(106, 75);
INSERT INTO student(rno, per) values(107, 85);


/* MySQL */

    -- INSERT INTO student(rno, per) values(105, 65);
        ERROR 1364 (HY000): Field 'name' does not have a default value
    
    -- INSERT INTO student(rno, per) values(106, 75);
        ERROR 1364 (HY000): Field 'name' does not have a default value

    -- INSERT INTO student(rno, per) values(107, 85);
        ERROR 1364 (HY000): Field 'name' does not have a default value

/*
select * from student;
+-----+------+------+
| rno | name | per  |
+-----+------+------+
| 101 | AAA  |   60 |
| 102 | BBB  |   70 |
| 103 | CCC  |   80 |
| 104 | DDD  |   90 |
+-----+------+------+
*/


/* PostgreSQL */

    ERROR:  null value in column "name" of relation "student" violates not-null constraint
    DETAIL:  Failing row contains (105, null, 65).

    ERROR:  null value in column "name" of relation "student" violates not-null constraint
    DETAIL:  Failing row contains (106, null, 75).

    ERROR:  null value in column "name" of relation "student" violates not-null constraint
    DETAIL:  Failing row contains (107, null, 85).

/*
select * from student;
 rno | name | per 
-----+------+-----
 101 | AAA  |  60
 102 | BBB  |  70
 103 | CCC  |  80
 104 | DDD  |  90

*/

/*
    You can see, it doesn't allowed records which does not have name, or where name is null.
    It only allowed valid records.
 */