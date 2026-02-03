/*

    The WHERE clause checks every row in the table and compares it with the given condition.
    If the row matches the condition, it is kept.
    If it does not match, that row is removed from the final result.

    WHERE is used only with SELECT, UPDATE, and DELETE queries to filter specific rows.
    It can work with comparison operators like =, >, <, >=, <=, != and also with LIKE, IN, BETWEEN, AND, OR, and NOT.

    The WHERE clause always runs before GROUP BY, HAVING, and ORDER BY,
    so it filters rows at the earliest step of execution.
*/

-- Student Tabel 
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


-- All reocrds
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
+-----+------+------+-----------+


-- Students with distinction.
MariaDB [test]> select name,per from student where per >= 75;
+------+------+
| name | per  |
+------+------+
| CCC  |   80 |
| DDD  |   90 |
| FFF  |   75 |
| GGG  |   85 |
| HHH  |   95 |
+------+------+


-- Show all students who live in Mumbai.
MariaDB [test]> select * from student where city = 'Mumbai';
+-----+------+------+--------+
| rno | name | per  | city   |
+-----+------+------+--------+
| 103 | CCC  |   80 | Mumbai |
| 107 | GGG  |   85 | Mumbai |
+-----+------+------+--------+

MariaDB [test]> select * from student where city LIKE 'Mumbai';
+-----+------+------+--------+
| rno | name | per  | city   |
+-----+------+------+--------+
| 103 | CCC  |   80 | Mumbai |
| 107 | GGG  |   85 | Mumbai |
+-----+------+------+--------+


-- Show students whose percentage is greater than 70.
test=# select * from student where per > 70;
 rno | name | per |   city    
-----+------+-----+-----------
 103 | CCC  |  80 | Mumbai
 104 | DDD  |  90 | Solapur
 106 | FFF  |  75 | Hyderabad
 107 | GGG  |  85 | Mumbai
 108 | HHH  |  95 | Pune



-- Show students whose percentage is less than or equal to 60.
test=# select * from student where per <= 60;
 rno | name | per |   city   
-----+------+-----+----------
 101 | AAA  |  60 | Pune
 109 | III  |  45 | Banglore
 110 | JJJ  |  35 | Panji



-- Show students whose city is Pune.
test=# select name from student where city = 'Pune';
 name 
------
 AAA
 HHH

test=# select name from student where city LIKE 'Pune';
 name 
------
 AAA
 HHH


-- Show students whose roll number is greater than 105.
MariaDB [test]> select * from student where rno > 105;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
| 108 | HHH  |   95 | Pune      |
| 109 | III  |   45 | Banglore  |
| 110 | JJJ  |   35 | Panji     |
+-----+------+------+-----------+


-- Show students who live in Pune and have percentage greater than 80.
MariaDB [test]> select * from student where city = 'Pune' and per > 80;
+-----+------+------+------+
| rno | name | per  | city |
+-----+------+------+------+
| 108 | HHH  |   95 | Pune |
+-----+------+------+------+



-- Show students who live in Mumbai or Panji.
MariaDB [test]> select * from student where city LIKE 'Mumbai' or city LIKE 'Panji';
+-----+------+------+--------+
| rno | name | per  | city   |
+-----+------+------+--------+
| 102 | BBB  |   70 | Panji  |
| 103 | CCC  |   80 | Mumbai |
| 107 | GGG  |   85 | Mumbai |
| 110 | JJJ  |   35 | Panji  |
+-----+------+------+--------+



-- Show students whose percentage is between 60 and 80 and city is not Mumbai.
MariaDB [test]> select name,per,city from student where (per BETWEEN 60 and 80) and city NOT LIKE 'Mumbai';
+------+------+-----------+
| name | per  | city      |
+------+------+-----------+
| AAA  |   60 | Pune      |
| BBB  |   70 | Panji     |
| EEE  |   65 | Banglore  |
| FFF  |   75 | Hyderabad |
+------+------+-----------+

MariaDB [test]> select name, per, city from student where per >= 60 and per <= 80 and city != 'Mumbai';
+------+------+-----------+
| name | per  | city      |
+------+------+-----------+
| AAA  |   60 | Pune      |
| BBB  |   70 | Panji     |
| EEE  |   65 | Banglore  |
| FFF  |   75 | Hyderabad |
+------+------+-----------+



-- Show students with percentage less than 50 or city Hyderabad.
MariaDB [test]> select name, per, city from student where per < 50 or city = 'Hyderabad';
+------+------+-----------+
| name | per  | city      |
+------+------+-----------+
| FFF  |   75 | Hyderabad |
| III  |   45 | Banglore  |
| JJJ  |   35 | Panji     |
+------+------+-----------+

MariaDB [test]> select name, per, city from student where per < 50 or city LIKE 'Hyderabad';
+------+------+-----------+
| name | per  | city      |
+------+------+-----------+
| FFF  |   75 | Hyderabad |
| III  |   45 | Banglore  |
| JJJ  |   35 | Panji     |
+------+------+-----------+



-- Show all students who do not live in Banglore.
MariaDB [test]> Select name,city from student where city != 'Banglore';
+------+-----------+
| name | city      |
+------+-----------+
| AAA  | Pune      |
| BBB  | Panji     |
| CCC  | Mumbai    |
| DDD  | Solapur   |
| FFF  | Hyderabad |
| GGG  | Mumbai    |
| HHH  | Pune      |
| JJJ  | Panji     |
+------+-----------+

MariaDB [test]> Select name,city from student where city NOT LIKE 'Banglore';
+------+-----------+
| name | city      |
+------+-----------+
| AAA  | Pune      |
| BBB  | Panji     |
| CCC  | Mumbai    |
| DDD  | Solapur   |
| FFF  | Hyderabad |
| GGG  | Mumbai    |
| HHH  | Pune      |
| JJJ  | Panji     |
+------+-----------+


-- Show students who do not have percentage above 70.
MariaDB [test]> select * from student where per < 70;
+-----+------+------+----------+
| rno | name | per  | city     |
+-----+------+------+----------+
| 101 | AAA  |   60 | Pune     |
| 105 | EEE  |   65 | Banglore |
| 109 | III  |   45 | Banglore |
| 110 | JJJ  |   35 | Panji    |
+-----+------+------+----------+





-- Show students whose city is in (Pune, Mumbai).
MariaDB [test]> select * from student where city = 'Pune' or city = 'Mumbai';
+-----+------+------+--------+
| rno | name | per  | city   |
+-----+------+------+--------+
| 101 | AAA  |   60 | Pune   |
| 103 | CCC  |   80 | Mumbai |
| 107 | GGG  |   85 | Mumbai |
| 108 | HHH  |   95 | Pune   |
+-----+------+------+--------+
4 rows in set (0.001 sec)

MariaDB [test]> select * from student where city LIKE 'Pune' or city LIKE 'Mumbai';
+-----+------+------+--------+
| rno | name | per  | city   |
+-----+------+------+--------+
| 101 | AAA  |   60 | Pune   |
| 103 | CCC  |   80 | Mumbai |
| 107 | GGG  |   85 | Mumbai |
| 108 | HHH  |   95 | Pune   |
+-----+------+------+--------+
4 rows in set (0.001 sec)

MariaDB [test]> select * from student where city IN ('Pune', 'Mumbai');
+-----+------+------+--------+
| rno | name | per  | city   |
+-----+------+------+--------+
| 101 | AAA  |   60 | Pune   |
| 103 | CCC  |   80 | Mumbai |
| 107 | GGG  |   85 | Mumbai |
| 108 | HHH  |   95 | Pune   |
+-----+------+------+--------+
4 rows in set (0.000 sec)




-- Show students whose percentage is between 70 and 90.
MariaDB [test]> select * from student where per between 70 and 90;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 102 | BBB  |   70 | Panji     |
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
+-----+------+------+-----------+
5 rows in set (0.001 sec)

MariaDB [test]> select * from student where per  >= 70 and per <= 90;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 102 | BBB  |   70 | Panji     |
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
+-----+------+------+-----------+
5 rows in set (0.001 sec)



-- Show students whose roll number is between 103 and 108.
MariaDB [test]> select * from student where rno between 103 and 108;
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 105 | EEE  |   65 | Banglore  |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
| 108 | HHH  |   95 | Pune      |
+-----+------+------+-----------+


-- Show students whose name starts with 'A'.
MariaDB [test]> select * from student where name LIKE 'A%';
+-----+------+------+------+
| rno | name | per  | city |
+-----+------+------+------+
| 101 | AAA  |   60 | Pune |
+-----+------+------+------+



-- Show students whose name ends with 'H'.
MariaDB [test]> select * from student where name LIKE '%H';
+-----+------+------+------+
| rno | name | per  | city |
+-----+------+------+------+
| 108 | HHH  |   95 | Pune |
+-----+------+------+------+



-- Show students whose name contains 'G' anywhere.
MariaDB [test]> select * from student where name LIKE '%G%';
+-----+------+------+--------+
| rno | name | per  | city   |
+-----+------+------+--------+
| 107 | GGG  |   85 | Mumbai |
+-----+------+------+--------+




-- Show students from Mumbai with percentage above 85.
MariaDB [test]> select * from student where city LIKE 'Mumbai' and per > 85;
Empty set (0.001 sec)

MariaDB [test]> select * from student where city LIKE 'Mumbai' and per >= 85;
+-----+------+------+--------+
| rno | name | per  | city   |
+-----+------+------+--------+
| 107 | GGG  |   85 | Mumbai |
+-----+------+------+--------+
1 row in set (0.001 sec)




-- Show students whose percentage is between 60 and 90 and city is not Panji.
MariaDB [test]> select * from student where per between 60 and 90 and city NOT LIKE 'Panji';
+-----+------+------+-----------+
| rno | name | per  | city      |
+-----+------+------+-----------+
| 101 | AAA  |   60 | Pune      |
| 103 | CCC  |   80 | Mumbai    |
| 104 | DDD  |   90 | Solapur   |
| 105 | EEE  |   65 | Banglore  |
| 106 | FFF  |   75 | Hyderabad |
| 107 | GGG  |   85 | Mumbai    |
+-----+------+------+-----------+
6 rows in set (0.000 sec)
