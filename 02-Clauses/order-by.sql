/*

    When we want to sort our reselt set,
    at that time we use ORDER BY clasuse 
    It can order all rows ascendingly or descendingly

    * Syntax:
        ORDER BY column_name ASC/DESC

        at last we either use ASC or DESC
            ASC - For Ascending
            DESC - For Descending
        
        If we don't use any, it will automatically sort by Ascending order

        we can use multiple column to order the result set
        like, 
            ORDER BY column_1 ASC/DESC , column_2 ASC/DESC , ....

            here, initially the result set will be ordered by column_1,
            then that ordered set will be again orderd by column_2

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

MariaDB [test]> select * from student;
+-----+---------+-----------+-------+------------+
| rno | name    | city      | marks | dob        |
+-----+---------+-----------+-------+------------+
| 101 | Amit    | Pune      |    85 | 2003-05-12 |
| 102 | Neha    | Mumbai    |    92 | 2002-11-23 |
| 103 | Rohan   | Delhi     |    67 | 2004-01-17 |
| 104 | Amit    | Pune      |    75 | 2003-05-12 |
| 105 | Sneha   | Pune      |    92 | 2002-03-05 |
| 106 | Vikas   | Chennai   |    55 | 2005-07-19 |
| 107 | Rohit   | Mumbai    |    67 | 2003-09-13 |
| 108 | Amit    | Delhi     |    85 | 2004-02-28 |
| 109 | Meera   | Hyderabad |    77 | 2003-04-10 |
| 110 | Neha    | Pune      |    88 | 2002-11-23 |
| 111 | Aman    | Delhi     |    35 | 2005-12-02 |
| 112 | Rhea    | Pune      |    85 | 2003-03-21 |
| 113 | Zara    | Chennai   |    92 | 2004-09-06 |
| 114 | Aman    | Mumbai    |    60 | 2005-12-02 |
| 115 | Karan   | Delhi     |    92 | 2002-05-26 |
| 116 | Aditi   | Mumbai    |    75 | 2004-09-06 |
| 117 | Meera   | Pune      |    55 | 2003-04-10 |
| 118 | Rishabh | Hyderabad |    60 | 2004-07-19 |
| 119 | Aditi   | Delhi     |    92 | 2004-09-06 |
| 120 | Zara    | Pune      |    88 | 2004-09-06 |
+-----+---------+-----------+-------+------------+

 -- Here, it has maintained the insertion order.....


 ----------------------------------------------------------------
                   ORDER BY name ASC
 ----------------------------------------------------------------
MariaDB [test]> select * from student ORDER BY name ASC;
+-----+---------+-----------+-------+------------+
| rno | name    | city      | marks | dob        |
+-----+---------+-----------+-------+------------+
| 119 | Aditi   | Delhi     |    92 | 2004-09-06 |
| 116 | Aditi   | Mumbai    |    75 | 2004-09-06 |
| 111 | Aman    | Delhi     |    35 | 2005-12-02 |
| 114 | Aman    | Mumbai    |    60 | 2005-12-02 |
| 101 | Amit    | Pune      |    85 | 2003-05-12 |
| 108 | Amit    | Delhi     |    85 | 2004-02-28 |
| 104 | Amit    | Pune      |    75 | 2003-05-12 |
| 115 | Karan   | Delhi     |    92 | 2002-05-26 |
| 109 | Meera   | Hyderabad |    77 | 2003-04-10 |
| 117 | Meera   | Pune      |    55 | 2003-04-10 |
| 102 | Neha    | Mumbai    |    92 | 2002-11-23 |
| 110 | Neha    | Pune      |    88 | 2002-11-23 |
| 112 | Rhea    | Pune      |    85 | 2003-03-21 |
| 118 | Rishabh | Hyderabad |    60 | 2004-07-19 |
| 103 | Rohan   | Delhi     |    67 | 2004-01-17 |
| 107 | Rohit   | Mumbai    |    67 | 2003-09-13 |
| 105 | Sneha   | Pune      |    92 | 2002-03-05 |
| 106 | Vikas   | Chennai   |    55 | 2005-07-19 |
| 113 | Zara    | Chennai   |    92 | 2004-09-06 |
| 120 | Zara    | Pune      |    88 | 2004-09-06 |
+-----+---------+-----------+-------+------------+

/*
    we can see, that the rows are orderd by name (alphabetically) and in ascending order
    But, we can notice the first two records, with roll no 119 and 116
    while inserting, we first insert roll number 116, So, it should come first, but roll number 119 came first
    i.e. ORDER BY is not STABLE 
*/

------------------------------------------------------------------
                   ORDER BY name DESC
------------------------------------------------------------------
MariaDB [test]> select * from student ORDER BY name DESC;
+-----+---------+-----------+-------+------------+
| rno | name    | city      | marks | dob        |
+-----+---------+-----------+-------+------------+
| 120 | Zara    | Pune      |    88 | 2004-09-06 |
| 113 | Zara    | Chennai   |    92 | 2004-09-06 |
| 106 | Vikas   | Chennai   |    55 | 2005-07-19 |
| 105 | Sneha   | Pune      |    92 | 2002-03-05 |
| 107 | Rohit   | Mumbai    |    67 | 2003-09-13 |
| 103 | Rohan   | Delhi     |    67 | 2004-01-17 |
| 118 | Rishabh | Hyderabad |    60 | 2004-07-19 |
| 112 | Rhea    | Pune      |    85 | 2003-03-21 |
| 102 | Neha    | Mumbai    |    92 | 2002-11-23 |
| 110 | Neha    | Pune      |    88 | 2002-11-23 |
| 109 | Meera   | Hyderabad |    77 | 2003-04-10 |
| 117 | Meera   | Pune      |    55 | 2003-04-10 |
| 115 | Karan   | Delhi     |    92 | 2002-05-26 |
| 101 | Amit    | Pune      |    85 | 2003-05-12 |
| 108 | Amit    | Delhi     |    85 | 2004-02-28 |
| 104 | Amit    | Pune      |    75 | 2003-05-12 |
| 114 | Aman    | Mumbai    |    60 | 2005-12-02 |
| 111 | Aman    | Delhi     |    35 | 2005-12-02 |
| 116 | Aditi   | Mumbai    |    75 | 2004-09-06 |
| 119 | Aditi   | Delhi     |    92 | 2004-09-06 |
+-----+---------+-----------+-------+------------+

/*
    Records are ordered by name, descendingly
*/


------------------------------------------------------------------
                    ORDER BY marks ASC
------------------------------------------------------------------
MariaDB [test]> select * from student ORDER BY marks ASC;
+-----+---------+-----------+-------+------------+
| rno | name    | city      | marks | dob        |
+-----+---------+-----------+-------+------------+
| 111 | Aman    | Delhi     |    35 | 2005-12-02 |
| 106 | Vikas   | Chennai   |    55 | 2005-07-19 |
| 117 | Meera   | Pune      |    55 | 2003-04-10 |
| 118 | Rishabh | Hyderabad |    60 | 2004-07-19 |
| 114 | Aman    | Mumbai    |    60 | 2005-12-02 |
| 103 | Rohan   | Delhi     |    67 | 2004-01-17 |
| 107 | Rohit   | Mumbai    |    67 | 2003-09-13 |
| 104 | Amit    | Pune      |    75 | 2003-05-12 |
| 116 | Aditi   | Mumbai    |    75 | 2004-09-06 |
| 109 | Meera   | Hyderabad |    77 | 2003-04-10 |
| 112 | Rhea    | Pune      |    85 | 2003-03-21 |
| 101 | Amit    | Pune      |    85 | 2003-05-12 |
| 108 | Amit    | Delhi     |    85 | 2004-02-28 |
| 110 | Neha    | Pune      |    88 | 2002-11-23 |
| 120 | Zara    | Pune      |    88 | 2004-09-06 |
| 113 | Zara    | Chennai   |    92 | 2004-09-06 |
| 115 | Karan   | Delhi     |    92 | 2002-05-26 |
| 105 | Sneha   | Pune      |    92 | 2002-03-05 |
| 102 | Neha    | Mumbai    |    92 | 2002-11-23 |
| 119 | Aditi   | Delhi     |    92 | 2004-09-06 |
+-----+---------+-----------+-------+------------+
                                ↑
                        Orderd By marks


------------------------------------------------------------------
                ORDER BY dob ASC
------------------------------------------------------------------
MariaDB [test]> select * from student ORDER BY dob ASC;
+-----+---------+-----------+-------+------------+
| rno | name    | city      | marks | dob        |
+-----+---------+-----------+-------+------------+
| 105 | Sneha   | Pune      |    92 | 2002-03-05 |
| 115 | Karan   | Delhi     |    92 | 2002-05-26 |
| 102 | Neha    | Mumbai    |    92 | 2002-11-23 |
| 110 | Neha    | Pune      |    88 | 2002-11-23 |
| 112 | Rhea    | Pune      |    85 | 2003-03-21 |
| 117 | Meera   | Pune      |    55 | 2003-04-10 |
| 109 | Meera   | Hyderabad |    77 | 2003-04-10 |
| 101 | Amit    | Pune      |    85 | 2003-05-12 |
| 104 | Amit    | Pune      |    75 | 2003-05-12 |
| 107 | Rohit   | Mumbai    |    67 | 2003-09-13 |
| 103 | Rohan   | Delhi     |    67 | 2004-01-17 |
| 108 | Amit    | Delhi     |    85 | 2004-02-28 |
| 118 | Rishabh | Hyderabad |    60 | 2004-07-19 |
| 119 | Aditi   | Delhi     |    92 | 2004-09-06 |
| 116 | Aditi   | Mumbai    |    75 | 2004-09-06 |
| 113 | Zara    | Chennai   |    92 | 2004-09-06 |
| 120 | Zara    | Pune      |    88 | 2004-09-06 |
| 106 | Vikas   | Chennai   |    55 | 2005-07-19 |
| 114 | Aman    | Mumbai    |    60 | 2005-12-02 |
| 111 | Aman    | Delhi     |    35 | 2005-12-02 |
+-----+---------+-----------+-------+------------+
                                          ↑
                                    Ordered By dob

------------------------------------------------------------------
            ORDER BY name ASC, rno ASC
------------------------------------------------------------------
MariaDB [test]> select * from student ORDER BY name ASC, rno ASC;
+-----+---------+-----------+-------+------------+
| rno | name    | city      | marks | dob        |
+-----+---------+-----------+-------+------------+
| 116 | Aditi   | Mumbai    |    75 | 2004-09-06 |
| 119 | Aditi   | Delhi     |    92 | 2004-09-06 |
| 111 | Aman    | Delhi     |    35 | 2005-12-02 |
| 114 | Aman    | Mumbai    |    60 | 2005-12-02 |
| 101 | Amit    | Pune      |    85 | 2003-05-12 |
| 104 | Amit    | Pune      |    75 | 2003-05-12 |
| 108 | Amit    | Delhi     |    85 | 2004-02-28 |
| 115 | Karan   | Delhi     |    92 | 2002-05-26 |
| 109 | Meera   | Hyderabad |    77 | 2003-04-10 |
| 117 | Meera   | Pune      |    55 | 2003-04-10 |
| 102 | Neha    | Mumbai    |    92 | 2002-11-23 |
| 110 | Neha    | Pune      |    88 | 2002-11-23 |
| 112 | Rhea    | Pune      |    85 | 2003-03-21 |
| 118 | Rishabh | Hyderabad |    60 | 2004-07-19 |
| 103 | Rohan   | Delhi     |    67 | 2004-01-17 |
| 107 | Rohit   | Mumbai    |    67 | 2003-09-13 |
| 105 | Sneha   | Pune      |    92 | 2002-03-05 |
| 106 | Vikas   | Chennai   |    55 | 2005-07-19 |
| 113 | Zara    | Chennai   |    92 | 2004-09-06 |
| 120 | Zara    | Pune      |    88 | 2004-09-06 |
+-----+---------+-----------+-------+------------+

/*
    Here the records are first ordered By name, and then ordered by roll no.
*/

