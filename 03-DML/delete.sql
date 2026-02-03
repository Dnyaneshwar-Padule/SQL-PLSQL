/*
    The DELETE statement is used to remove rows from a table.
    We can delete a single record or multiple records.
    To do that safely, we use the WHERE clause to target only the rows we want to delete.

    We should use DELETE very carefully!
    Before running the actual DELETE query, we should first run the same SELECT query with the same WHERE condition to check which rows will be deleted.

    If we run DELETE without a WHERE clause, then all rows in the table will be deleted, so double-checking is always a good habit.


    Syntax :- 
        DELETE FROM table_name WHERE condition;

        WHERE Clause with condition is optional.... (But necessary !!)

*/


/*
    Questions on DELETE query, for this table
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
Basic DELETE
/*=============================================================================*/
--Delete the student whose roll number is 105.
    MariaDB [test]> delete from student where rno = 105;
    Query OK, 1 row affected (0.012 sec)


--Delete the student whose name is 'CCC'.
    MariaDB [test]> delete from student where name LIKE 'CCC';
    Query OK, 1 row affected (0.007 sec)


--Delete the student who lives in Solapur.
    MariaDB [test]> delete from student where city LIKE 'Solapur';
    Query OK, 3 rows affected (0.007 sec)


--Delete all students from Banglore.
    MariaDB [test]> delete from student where city LIKE 'Banglore';
    Query OK, 2 rows affected (0.007 sec)


#### TABLE AFTER ALL DELETE QUERIES ###
MariaDB [test]> select * from student;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 101 | AAA  |   60 | Pune      |
| 102 | BBB  |   70 | Panji     |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
| 108 | HHH  |   95 | Pune      |
| 110 | JJJ  |   35 | Panji     |
| 111 | KKK  |   82 | Pune      |
| 112 | LLL  |   58 | Mumbai    |
| 113 | MMM  |   92 | Hyderabad |
| 116 | PPP  |   88 | Pune      |
| 117 | QQQ  |   49 | Panji     |
| 118 | RRR  |   77 | Mumbai    |
| 119 | SSS  |   33 | Hyderabad |
+-----+------+------+-----------+


/*=============================================================================*/
DELETE with conditions
/*=============================================================================*/
    (Again inserting all deleted records)

--Delete students whose percentage is less than 50.
    MariaDB [test]> delete from student where per < 50;
    Query OK, 4 rows affected (0.007 sec)


--Delete students whose percentage is between 60 and 70.
    MariaDB [test]> delete from student where per between 60 and 70;
    Query OK, 4 rows affected (0.006 sec)


--Delete students who live in Panji and have percentage below 60.
    MariaDB [test]> delete from student where city LIKE 'Panji' and per < 60;
    Query OK, 0 rows affected (0.001 sec)


--Delete students who live in Mumbai or Hyderabad.
    MariaDB [test]> delete from student where city IN ('Mumbai', 'Hyderabad');
    Query OK, 6 rows affected (0.007 sec)


### TABLE AFTER ALL DELETE QUERIES ###
MariaDB [test]> select * from student;
+-----+------+------+---------+
| rno | name | per  | city    |
+-----+------+------+---------+
| 104 | DDD  |   90 | Solapur |
| 108 | HHH  |   95 | Pune    |
| 111 | KKK  |   82 | Pune    |
| 114 | NNN  |   73 | Solapur |
| 116 | PPP  |   88 | Pune    |
| 120 | TTT  |   96 | Solapur |
+-----+------+------+---------+



/*=============================================================================*/
DELETE using LIKE
/*=============================================================================*/
    (Again inserting all deleted records)

--Delete students whose name starts with 'H'.
    MariaDB [test]> delete from student where name LIKE 'H%';
    Query OK, 1 row affected (0.007 sec)


--Delete students whose name ends with 'T'.
    MariaDB [test]> delete from student where name LIKE '%T';
    Query OK, 1 row affected (0.007 sec)


### TABLE AFTER ALL DELETE QUERIES ###
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
+-----+------+------+-----------+


/*=============================================================================*/
DELETE using IN / NOT IN
/*=============================================================================*/
    (Again inserting all deleted records)

--Delete students whose city is in ('Pune', 'Mumbai').
    MariaDB [test]> delete from student where city IN ('Pune', 'Mumbai');
    Query OK, 8 rows affected (0.007 sec)


--Delete students whose city is not in ('Pune', 'Panji').
    MariaDB [test]> delete from student where city NOT IN ('Pune', 'Panji');
    Query OK, 9 rows affected (0.007 sec)


### TABLE AFTER ALL DELETE QUERIES ###
MariaDB [test]> select * from student;
+-----+------+------+-------+
| rno | name | per  | city  |
+-----+------+------+-------+
| 102 | BBB  |   70 | Panji |
| 110 | JJJ  |   35 | Panji |
| 117 | QQQ  |   49 | Panji |
+-----+------+------+-------+


/*=============================================================================*/
DELETE using complex conditions
/*=============================================================================*/
    (Again inserting all deleted records)

--Delete students whose percentage is above 90 and city is Solapur.
    MariaDB [test]> delete from student where per > 90 and city LIKE 'Solapur';
    Query OK, 1 row affected (0.007 sec)


--Delete students whose roll number is greater than 110 but percentage is below 60.
    MariaDB [test]> delete from student where rno > 110 and per < 60;
    Query OK, 3 rows affected (0.007 sec)


--Delete students whose percentage is not between 70 and 90.
    MariaDB [test]> delete from student where per NOT between 70 and 90;
    Query OK, 7 rows affected (0.007 sec)


### TABLE AFTER ALL DELETE QUERIES ###
MariaDB [test]> select * from student;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 102 | BBB  |   70 | Panji     |
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
| 111 | KKK  |   82 | Pune      |
| 114 | NNN  |   73 | Solapur   |
| 116 | PPP  |   88 | Pune      |
| 118 | RRR  |   77 | Mumbai    |
+-----+------+------+-----------+


/*=============================================================================*/
DELETE all (dangerous)
/*=============================================================================*/
    (Again inserting all deleted records)

--Delete all records from the student table.
    MariaDB [test]> delete from student;
    Query OK, 20 rows affected (0.007 sec)


### TABLE AFTER ALL DELETE QUERIES ### 

MariaDB [test]> select * from student;
Empty set (0.001 sec)

-------------------------------------------------------------------------------------------------------------------