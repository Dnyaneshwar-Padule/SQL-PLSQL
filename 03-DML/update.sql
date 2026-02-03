/*
    The UPDATE query can update one record or multiple records, depending on the WHERE condition we use.
    It is used to change values in one or more columns of a table.
    If we do not provide a WHERE condition, then all rows in the table will get updated — so we should always be careful and double-check the condition before running an UPDATE.
    We can also update multiple columns at the same time in a single query.

    Syntax:

    UPDATE table_name
    SET column1 = value1,
        column2 = value2,
        ...
    WHERE condition;


    It is always a good habit to first run a SELECT query with the same WHERE condition to check which rows will get updated.
*/

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
INSERT INTO student VALUES(120, 'TTT', 96, 'Solapur');



/*=============================================================================*/
--    Initial Table
/*=============================================================================*/
MariaDB [test]> select * from student;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 101 | AAA  |   60 | Pune      |
| 102 | BBB  |   70 | Panji     |
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 105 | EEE  |   65 | Banglore  |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
| 108 | HHH  |   95 | Pune      |
| 109 | III  |   45 | Banglore  |
| 110 | JJJ  |   35 | Panji     |
| 111 | KKK  |   82 | Pune      |
| 112 | LLL  |   58 | Mumbai    |
| 113 | MMM  |   92 | Hyderabad |
| 114 | NNN  |   73 | Solapur   |
| 115 | OOO  |   67 | Banglore  |
| 116 | PPP  |   88 | Pune      |
| 117 | QQQ  |   49 | Panji     |
| 118 | RRR  |   77 | Mumbai    |
| 119 | SSS  |   33 | Hyderabad |
| 120 | TTT  |   96 | Solapur   |
+-----+------+------+-----------+
20 rows in set (0.001 sec)
/*=============================================================================*/

/*=============================================================================*/
Basic Update
/*=============================================================================*/
    (Reverting all changes...)

--Update the city of the student with roll number 101 to 'Mumbai'.
    MariaDB [test]> UPDATE student 
        -> SET city = 'Mumbai'
        -> where rno = 101;
    Query OK, 1 row affected (0.008 sec)
    Rows matched: 1  Changed: 1  Warnings: 0


--Change the percentage of the student 'EEE' to 72.
    MariaDB [test]> UPDATE student
        -> SET per = 72
        -> where name LIKE 'EEE';
    Query OK, 1 row affected (0.008 sec)
    Rows matched: 1  Changed: 1  Warnings: 0


--Update the name of roll number 108 to 'Hitesh'.
    MariaDB [test]> update student
        -> set name = 'Hitesh'
        -> where rno = 108;
    Query OK, 1 row affected (0.007 sec)
    Rows matched: 1  Changed: 1  Warnings: 0

### Records after all update queries ###
MariaDB [test]> select * from student;
+-----+--------+------+-----------+
| rno | name   | per  | city      |
+-----+--------+------+-----------+
| 101 | AAA    |   60 | Mumbai    |
| 102 | BBB    |   70 | Panji     |
| 103 | CCC    |   80 | Mumbai    |
| 104 | DDD    |   90 | Solapur   |
| 105 | EEE    |   72 | Banglore  |
| 106 | FFF    |   75 | Hyderabad |
| 107 | GGG    |   85 | Mumbai    |
| 108 | Hitesh |   95 | Pune      |
| 109 | III    |   45 | Banglore  |
| 110 | JJJ    |   35 | Panji     |
| 111 | KKK    |   82 | Pune      |
| 112 | LLL    |   58 | Mumbai    |
| 113 | MMM    |   92 | Hyderabad |
| 114 | NNN    |   73 | Solapur   |
| 115 | OOO    |   67 | Banglore  |
| 116 | PPP    |   88 | Pune      |
| 117 | QQQ    |   49 | Panji     |
| 118 | RRR    |   77 | Mumbai    |
| 119 | SSS    |   33 | Hyderabad |
| 120 | TTT    |   96 | Solapur   |
+-----+--------+------+-----------+



/*=============================================================================*/
Udate Based on Conditions
/*=============================================================================*/
    (Reverting all changes...)

--Increase the percentage of all students from Pune by 5.
    MariaDB [test]> UPDATE student
        -> SET per = per + 5
        -> where city LIKE 'PUNE';
    Query OK, 4 rows affected (0.007 sec)
    Rows matched: 4  Changed: 4  Warnings: 0


--Reduce the percentage of students whose percentage is below 50 by 5.
    MariaDB [test]> UPDATE student
        -> set per = per - 5
        -> WHERE per < 50;
    Query OK, 4 rows affected (0.007 sec)
    Rows matched: 4  Changed: 4  Warnings: 0


--Set city to 'Unknown' for students who live in Banglore.
    MariaDB [test]> UPDATE student
        -> SET city = 'Unknown'
        -> WHERE city LIKE 'Banglore';
    Query OK, 3 rows affected (0.007 sec)
    Rows matched: 3  Changed: 3  Warnings: 0


--Update percentage to 80 for all students whose city is Panji.
    MariaDB [test]> UPDATE student
        -> SET per = 80
        -> WHERE city LIKE 'Panji';
    Query OK, 3 rows affected (0.007 sec)
    Rows matched: 3  Changed: 3  Warnings: 0


### Records after all update queries ###
MariaDB [test]> select * from student;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 101 | AAA  |   65 | Pune      |
| 102 | BBB  |   80 | Panji     |
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 105 | EEE  |   65 | Unknown   |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
| 108 | HHH  |  100 | Pune      |
| 109 | III  |   40 | Unknown   |
| 110 | JJJ  |   80 | Panji     |
| 111 | KKK  |   87 | Pune      |
| 112 | LLL  |   58 | Mumbai    |
| 113 | MMM  |   92 | Hyderabad |
| 114 | NNN  |   73 | Solapur   |
| 115 | OOO  |   67 | Unknown   |
| 116 | PPP  |   93 | Pune      |
| 117 | QQQ  |   80 | Panji     |
| 118 | RRR  |   77 | Mumbai    |
| 119 | SSS  |   28 | Hyderabad |
| 120 | TTT  |   96 | Solapur   |
+-----+------+------+-----------+


/*=============================================================================*/
Multiple Column Update
/*=============================================================================*/
    (Reverting all changes...)

--Update both city = 'Pune' and per = 90 for roll number 109.
    MariaDB [test]> UPDATE student 
        -> SET city = 'Pune',
        ->     per = 90
        -> WHERE rno = 109;
    Query OK, 1 row affected (0.007 sec)
    Rows matched: 1  Changed: 1  Warnings: 0

--Set name = 'Temp' and city = 'TempCity' for all students with percentage less than 40.
    MariaDB [test]> UPDATE student
        -> SET name = 'Temp', 
        ->     city = 'TempCity'
        -> WHERE per < 40;
    Query OK, 2 rows affected (0.007 sec)
    Rows matched: 2  Changed: 2  Warnings: 0


### Records after all update queries ###
MariaDB [test]> select * from student;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 101 | AAA  |   60 | Pune      |
| 102 | BBB  |   70 | Panji     |
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 105 | EEE  |   65 | Banglore  |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
| 108 | HHH  |   95 | Pune      |
| 109 | III  |   90 | Pune      |
| 110 | Temp |   35 | TempCity  |
| 111 | KKK  |   82 | Pune      |
| 112 | LLL  |   58 | Mumbai    |
| 113 | MMM  |   92 | Hyderabad |
| 114 | NNN  |   73 | Solapur   |
| 115 | OOO  |   67 | Banglore  |
| 116 | PPP  |   88 | Pune      |
| 117 | QQQ  |   49 | Panji     |
| 118 | RRR  |   77 | Mumbai    |
| 119 | Temp |   33 | TempCity  |
| 120 | TTT  |   96 | Solapur   |
+-----+------+------+-----------+

/*=============================================================================*/
Using LIKE
/*=============================================================================*/
    (Reverting all changes...)

--Update city to 'Metro' for students whose name starts with 'A'.
    MariaDB [test]> UPDATE student
        -> SET city = 'Metro'
        -> WHERE name LIKE 'A%';
    Query OK, 1 row affected (0.007 sec)
    Rows matched: 1  Changed: 1  Warnings: 0

--Update percentage to 100 for students whose name ends with **'T'`.
    MariaDB [test]> UPDATE student
        -> SET per = 100
        -> WHERE name LIKE '%T';
    Query OK, 1 row affected (0.007 sec)
    Rows matched: 1  Changed: 1  Warnings: 0


### Records after all update queries ###
MariaDB [test]> select * from student;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 101 | AAA  |   60 | Metro     |
| 102 | BBB  |   70 | Panji     |
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 105 | EEE  |   65 | Banglore  |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
| 108 | HHH  |   95 | Pune      |
| 109 | III  |   45 | Banglore  |
| 110 | JJJ  |   35 | Panji     |
| 111 | KKK  |   82 | Pune      |
| 112 | LLL  |   58 | Mumbai    |
| 113 | MMM  |   92 | Hyderabad |
| 114 | NNN  |   73 | Solapur   |
| 115 | OOO  |   67 | Banglore  |
| 116 | PPP  |   88 | Pune      |
| 117 | QQQ  |   49 | Panji     |
| 118 | RRR  |   77 | Mumbai    |
| 119 | SSS  |   33 | Hyderabad |
| 120 | TTT  |  100 | Solapur   |
+-----+------+------+-----------+


/*=============================================================================*/
Using IN / NOT IN
/*=============================================================================*/
    (Reverting all changes...)

--Set percentage to 75 for students whose city is in ('Mumbai', 'Pune').
    MariaDB [test]> UPDATE student
        -> SET per = 75
        -> WHERE city IN ('Mumbai', 'Pune');
    Query OK, 8 rows affected (0.007 sec)
    Rows matched: 8  Changed: 8  Warnings: 0

--Update city to 'Other' for students whose city is not in ('Pune', 'Mumbai', 'Hyderabad').
    MariaDB [test]> Update student
        -> SET city = 'Other'
        -> WHERE city NOT IN ('Pune', 'Mumbai', 'Hyderabad');
    Query OK, 9 rows affected (0.008 sec)
    Rows matched: 9  Changed: 9  Warnings: 0


### Records after all update queries ###
MariaDB [test]> select * from student;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 101 | AAA  |   75 | Pune      |
| 102 | BBB  |   70 | Other     |
| 103 | CCC  |   75 | Mumbai    |
| 104 | DDD  |   90 | Other     |
| 105 | EEE  |   65 | Other     |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   75 | Mumbai    |
| 108 | HHH  |   75 | Pune      |
| 109 | III  |   45 | Other     |
| 110 | JJJ  |   35 | Other     |
| 111 | KKK  |   75 | Pune      |
| 112 | LLL  |   75 | Mumbai    |
| 113 | MMM  |   92 | Hyderabad |
| 114 | NNN  |   73 | Other     |
| 115 | OOO  |   67 | Other     |
| 116 | PPP  |   75 | Pune      |
| 117 | QQQ  |   49 | Other     |
| 118 | RRR  |   75 | Mumbai    |
| 119 | SSS  |   33 | Hyderabad |
| 120 | TTT  |   96 | Other     |
+-----+------+------+-----------+


/*=============================================================================*/
Complex Conditions
/*=============================================================================*/
    (Reverting all changes...)

--Update percentage to 85 for students whose percentage is between 60 and 70 and city is 'Solapur'.
    MariaDB [test]> UPDATE student     
        -> SET per = 85
        -> WHERE per BETWEEN 60 and 70
        -> AND city LIKE 'Solapur';
    Query OK, 0 rows affected (0.000 sec)
    Rows matched: 0  Changed: 0  Warnings: 0

    MariaDB [test]> select * from student where city like 'Solapur';
    +-----+------+------+---------+
    | rno | name | per  | city    |
    +-----+------+------+---------+
    | 104 | DDD  |   90 | Solapur |
    | 114 | NNN  |   73 | Solapur |
    | 120 | TTT  |   96 | Solapur |
    +-----+------+------+---------+



--Update city to 'Tier-1' for students with percentage above 90 or whose name contains 'G'.
    MariaDB [test]> UPDATE student
        -> SET city = 'Tier-1'
        -> WHERE per > 90
        -> AND name LIKE '%G%';
    Query OK, 0 rows affected (0.001 sec)
    Rows matched: 0  Changed: 0  Warnings: 0

    MariaDB [test]> select * from student WHERE per > 90 and name LIKE '%G%';
    Empty set (0.001 sec)

    MariaDB [test]> select * from student WHERE name LIKE '%G%';
    +-----+------+------+--------+
    | rno | name | per  | city   |
    +-----+------+------+--------+
    | 107 | GGG  |   85 | Mumbai |
    +-----+------+------+--------+

--Add 2 marks bonus for all students except those living in Panji.
    MariaDB [test]> UPDATE student
        -> SET per = per + 2
        -> WHERE city NOT LIKE 'Panji';
    Query OK, 17 rows affected (0.007 sec)
    Rows matched: 17  Changed: 17  Warnings: 0



### Records after all update queries ###
MariaDB [test]> select * from student;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 101 | AAA  |   62 | Pune      |
| 102 | BBB  |   70 | Panji     |
| 103 | CCC  |   82 | Mumbai    |
| 104 | DDD  |   92 | Solapur   |
| 105 | EEE  |   67 | Banglore  |
| 106 | FFF  |   77 | Hyderabad |
| 107 | GGG  |   87 | Mumbai    |
| 108 | HHH  |   97 | Pune      |
| 109 | III  |   47 | Banglore  |
| 110 | JJJ  |   35 | Panji     |
| 111 | KKK  |   84 | Pune      |
| 112 | LLL  |   60 | Mumbai    |
| 113 | MMM  |   94 | Hyderabad |
| 114 | NNN  |   75 | Solapur   |
| 115 | OOO  |   69 | Banglore  |
| 116 | PPP  |   90 | Pune      |
| 117 | QQQ  |   49 | Panji     |
| 118 | RRR  |   79 | Mumbai    |
| 119 | SSS  |   35 | Hyderabad |
| 120 | TTT  |   98 | Solapur   |
+-----+------+------+-----------+



/*=============================================================================*/
Challenge Questions
/*=============================================================================*/
    (Reverting all changes...)

--Increase percentage by 10 only for those students whose roll number is greater than 110 and percentage is below 60.
    MariaDB [test]> UPDATE student
        -> SET per = per + 10
        -> WHERE rno > 110
        -> AND per < 60;
    Query OK, 3 rows affected (0.008 sec)
    Rows matched: 3  Changed: 3  Warnings: 0


--Change name to uppercase (manual value) for all students who live in Hyderabad.
    MariaDB [test]> UPDATE student
        -> SET name = UPPER(name)
        -> WHERE city LIKE 'Hyderabad';
    Query OK, 0 rows affected (0.001 sec)
    Rows matched: 3  Changed: 0  Warnings: 0


--Set percentage = 0 for students whose city is 'Solapur' or 'Banglore'.
    MariaDB [test]> UPDATE student
        -> SET per = 0
        -> WHERE city IN ('Solapur', 'Banglore');
    Query OK, 6 rows affected (0.007 sec)
    Rows matched: 6  Changed: 6  Warnings: 0


--Update the city of the top 3 percentage students to 'TopperCity' (Hint: You can't use LIMIT inside UPDATE directly in most SQL engines, so think logically.)

test=# SELECT DISTINCT per FROM student ORDER BY per DESC LIMIT 3;
 per 
-----
  96
  95
  92
(3 rows)

test=# UPDATE student
test-# SET city = 'TopperCity'
test-# WHERE per IN (
test(#              SELECT DISTINCT per FROM student ORDER BY per DESC LIMIT 3
test(#             );
UPDATE 3

---------------------------------------------------------------------------
UPDATE student
SET city = 'TopperCity'
WHERE per IN (
                SELECT DISTINCT per FROM student ORDER BY per DESC LIMIT 3
             );
---------------------------------------------------------------------------