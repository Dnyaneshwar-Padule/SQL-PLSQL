/*

    When we use the deafult constraint,
    while inserting a record, if we don't provide the value for this column, it will take the default provided value

    Syntax :-
        column_name datatype DEFAULT <default_value>

        Note: The data type of <default_value> should be same to datatype of the column

    We use use this to set the created_at timestamp


    Example :- 
*/
DROP TABLE student;

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO student(rno, name, per) VALUES(101, 'AAA', 60);
INSERT INTO student(rno, name, per) VALUES(102, 'BBB', 70);
INSERT INTO student(rno, name, per) VALUES(103, 'CCC', 80);
INSERT INTO student(rno, name, per) VALUES(104, 'DDD', 90);
INSERT INTO student(rno, name, per) VALUES(105, 'EEE', 65);
INSERT INTO student(rno, name, per) VALUES(106, 'FFF', 75);

/* MySQL */
select * from student;
+-----+------+------+---------------------+
| rno | name | per  | created_at          |
+-----+------+------+---------------------+
| 101 | AAA  |   60 | 2026-02-03 12:00:02 |
| 102 | BBB  |   70 | 2026-02-03 12:00:02 |
| 103 | CCC  |   80 | 2026-02-03 12:00:02 |
| 104 | DDD  |   90 | 2026-02-03 12:00:02 |
| 105 | EEE  |   65 | 2026-02-03 12:00:02 |
| 106 | FFF  |   75 | 2026-02-03 12:00:02 |
+-----+------+------+---------------------+


/* PostgreSQL */
select * from student;
 rno | name | per |         created_at         
-----+------+-----+----------------------------
 101 | AAA  |  60 | 2026-02-03 06:30:07.878139
 102 | BBB  |  70 | 2026-02-03 06:30:07.881312
 103 | CCC  |  80 | 2026-02-03 06:30:07.883508
 104 | DDD  |  90 | 2026-02-03 06:30:07.885877
 105 | EEE  |  65 | 2026-02-03 06:30:07.888301
 106 | FFF  |  75 | 2026-02-03 06:30:07.890082


/*
    We can see that, while inserting the records, we didn't provide value for created_at column, but it automatically take the default provided value
    Note :- If we explicitely provide a value for created_at column, it will insert out given value, not default value.
*/