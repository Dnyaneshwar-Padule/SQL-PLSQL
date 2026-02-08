/*

    SQL provide us two types of built in function
        - Scalar Function
        - Aggregate Function

    * Scalar Function:
        These functions work on single data, or on Just a single record in a column.

    * Aggregate Function:
        Aggregate Functions work on multiple records, like on entire column values.
        Aggregate functions are mostly used with GROUP BY clause; but we can use them without GROUP BY
*/


/*
    Examples on this student table
*/
DROP TABLE IF EXISTS student;

CREATE TABLE student(
    rno INT PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    city VARCHAR(40) NOT NULL,
    marks FLOAT CHECK(marks >= 0 AND marks <= 100),
    dob DATE NOT NULL
);

INSERT INTO student VALUES (101, 'Amit',     'Pune',      85, '2003-05-12');
INSERT INTO student VALUES (102, 'Neha',     'Mumbai',    92, '2002-11-23');
INSERT INTO student VALUES (103, 'Rohan',    'Delhi',     67, '2004-01-17');
INSERT INTO student VALUES (104, 'Amit',     'Pune',      75, '2003-05-12');
INSERT INTO student VALUES (105, 'Sneha',    'Pune',      92, '2002-03-05');
INSERT INTO student VALUES (106, 'Vikas',    'Chennai',   55, '2005-07-19');
INSERT INTO student VALUES (107, 'Rohit',    'Mumbai',    67, '2003-09-13');
INSERT INTO student VALUES (108, 'Amit',     'Delhi',     85, '2004-02-28');
INSERT INTO student VALUES (109, 'Meera',    'Hyderabad', 77, '2003-04-10');
INSERT INTO student VALUES (110, 'Neha',     'Pune',      88, '2002-11-23');
INSERT INTO student VALUES (111, 'Aman',     'Delhi',     35, '2005-12-02');
INSERT INTO student VALUES (112, 'Rhea',     'Pune',      85, '2003-03-21');
INSERT INTO student VALUES (113, 'Zara',     'Chennai',   92, '2004-09-06');
INSERT INTO student VALUES (114, 'Aman',     'Mumbai',    60, '2005-12-02');
INSERT INTO student VALUES (115, 'Karan',    'Delhi',     92, '2002-05-26');
INSERT INTO student VALUES (116, 'Aditi',    'Mumbai',    75, '2004-09-06');
INSERT INTO student VALUES (117, 'Meera',    'Pune',      55, '2003-04-10');
INSERT INTO student VALUES (118, 'Rishabh',  'Hyderabad', 60, '2004-07-19');
INSERT INTO student VALUES (119, 'Aditi',    'Delhi',     92, '2004-09-06');
INSERT INTO student VALUES (120, 'Zara',     'Pune',      88, '2004-09-06');



-- ########################################################################### --
--                                    Queries                                  --
-- ########################################################################### --





/*
    1. SUM():
        Just like the name, SUM(), gives addition of all records in a column
        That column should contain numbers, although it don't give error, but it don't work on them
*/
MariaDB [test]> select SUM(marks) from student;
+------------+
| SUM(marks) |
+------------+
|       1517 |
+------------+

MariaDB [test]> select SUM(name) from student;
+-----------+
| SUM(name) |
+-----------+
|         0 |
+-----------+



/*
    2. AVG();
        It finds average, of all values in a column
*/
MariaDB [test]> select AVG(marks) from student;
+------------+
| AVG(marks) |
+------------+
|      75.85 |
+------------+



/*
    3. MIN();
        Gives the minimum value, from multiple values or from a column
*/
MariaDB [test]> SELECT MIN(marks) from student;
+------------+
| MIN(marks) |
+------------+
|         35 |
+------------+

MariaDB [test]> SELECT MIN(name) from student;
+-----------+
| MIN(name) |
+-----------+
| Aditi     |
+-----------+



/*
    4. MAX()
        Gives maimum value from a column
*/
MariaDB [test]> SELECT MAX(marks) from student;
+------------+
| MAX(marks) |
+------------+
|         92 |
+------------+

MariaDB [test]> SELECT MAX(name) from student;
+-----------+
| MAX(name) |
+-----------+
| Zara      |
+-----------+


/*
    5. COUNT():
        It counts the number of records in the column.
        We can use it with one column or entire column

        for single column:
            COUNT(column_name)

        for entire table or all columns
            COUNT(*)
*/
MariaDB [test]> select count(rno) from student;
+------------+
| count(rno) |
+------------+
|         20 |
+------------+

MariaDB [test]> select count(*) from student;
+----------+
| count(*) |
+----------+
|       20 |
+----------+

    -- For another example, see this column
    MariaDB [test]> select * from full_name;
    +-------------+-------------+-----------+
    | first_name  | middle_name | last_name |
    +-------------+-------------+-----------+
    |             |             |           |
    | Ram         |             |           |
    |             | GANESH      |           |
    |             |             | Patil     |
    |             |             | Shinde    |
    | Shreyas     |             | Shinde    |
    | Vipin       |             | Hole      |
    | Athrva      | Mahesh      | Gheware   |
    | Dnyaneshwar | Rajendra    | Padule    |
    | Swapnil     | NULL        | NULL      |
    | Mayur       | NULL        | NULL      |
    | Kunal       | NULL        | Bhoge     |
    | Gaurav      | NULL        | Dabhade   |
    | Sumit       | NULL        | More      |
    | Tejas       | Babasaheb   | Tupe      |
    +-------------+-------------+-----------+
    15 rows in set (0.001 sec)

    -- The empty cells are not NULL.....

    MariaDB [test]> select COUNT(first_name) from full_name;
    +-------------------+
    | COUNT(first_name) |
    +-------------------+
    |                15 |
    +-------------------+

    MariaDB [test]> select COUNT(middle_name) from full_name;
    +--------------------+
    | COUNT(middle_name) |
    +--------------------+
    |                 10 |
    +--------------------+

    MariaDB [test]> select COUNT(last_name) from full_name;
    +------------------+
    | COUNT(last_name) |
    +------------------+
    |               13 |
    +------------------+

    MariaDB [test]> select COUNT(*) from full_name;
    +----------+
    | COUNT(*) |
    +----------+
    |       15 |
    +----------+

    /*
        Here, we can observe that, COUNT() only counts non-NULL records
    */

