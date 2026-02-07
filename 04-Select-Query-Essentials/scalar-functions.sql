/*
    SQL Scalar Functions are built-in functions that operate on a single value and return a single value.
    Scalar functions in SQL helps in efficient data manipulation and simplification of complex calculations in SQL queries.

*/

                                /*  MySQL */
                            /* ### DATA SET ### */
select * from student;
+-----+------+------+--------+------------------+
| rno | name | per  | city   | email_ID         |
+-----+------+------+--------+------------------+
| 101 | AAA  |   60 | Pune   | AAA101@gmail.com |
| 102 | BBB  |   70 | Pune   | BBB102@gmail.com |
| 103 | CCC  |   80 | Pune   | CCC103@gmail.com |
| 104 | DDD  |   90 | Mumbai | DDD104@gmail.com |
+-----+------+------+--------+------------------+
4 rows in set (0.002 sec)


        /*     ### String Scalar Functions ###      */
        /* RIGHT('String', n)
            For a Given String, it gives the n characters from the right side
            n is like how many characters you want from right.
        */
SELECT RIGHT(email_ID, 10) from student;
+---------------------+
| RIGHT(email_ID, 10) |
+---------------------+
| @gmail.com          |
| @gmail.com          |
| @gmail.com          |
| @gmail.com          |
+---------------------+


        /* LEFT('String', n)
            For a Given String, it gives the n characters from the left side
            n is like how many characters you want from left.
        */
SELECT LEFT(email_ID, 6) from student;
+-------------------+
| LEFT(email_ID, 6) |
+-------------------+
| AAA101            |
| BBB102            |
| CCC103            |
| DDD104            |
+-------------------+


        /* LCASE('String')  / LOWER()
            Converts the given String to Lower Case
        */
SELECT name, LCASE(name) as lower_case_name from student;
+------+-----------------+
| name | lower_case_name |
+------+-----------------+
| AAA  | aaa             |
| BBB  | bbb             |
| CCC  | ccc             |
| DDD  | ddd             |
+------+-----------------+


        /* UCASE() / UPPER()
            Converts the given String to upper case
        */
select city, UCASE(city) upper_case_city from student;
+--------+-----------------+
| city   | upper_case_city |
+--------+-----------------+
| Pune   | PUNE            |
| Pune   | PUNE            |
| Pune   | PUNE            |
| Mumbai | MUMBAI          |
+--------+-----------------+


        /* MID('String', starting_index, n)
            For a given string, it gives a substring starting with the 'starting_index' and gets the n characters 

            ex.) for String '111234567'
                if starting_index = 3
                n = 7
                then the resulting string will be: '1234567'
         */
select email_ID, MID(email_ID, 4, 3) from student;
+------------------+---------------------+
| email_ID         | MID(email_ID, 4, 3) |
+------------------+---------------------+
| AAA101@gmail.com | 101                 |
| BBB102@gmail.com | 102                 |
| CCC103@gmail.com | 103                 |
| DDD104@gmail.com | 104                 |
+------------------+---------------------+

        /* LENTH('String')
            It gives the length of the String.
        */
select city, LENGTH(city) as city_length from student;
+--------+-------------+
| city   | city_length |
+--------+-------------+
| Pune   |           4 |
| Pune   |           4 |
| Pune   |           4 |
| Mumbai |           6 |
+--------+-------------+


        /* REVERSE('String')
            Reverse a given String.
        */
select email_ID, REVERSE(email_ID) from student;
+------------------+-------------------+
| email_ID         | REVERSE(email_ID) |
+------------------+-------------------+
| AAA101@gmail.com | moc.liamg@101AAA  |
| BBB102@gmail.com | moc.liamg@201BBB  |
| CCC103@gmail.com | moc.liamg@301CCC  |
| DDD104@gmail.com | moc.liamg@401DDD  |
+------------------+-------------------+


        /*
            TRIM()
                removes blank spaces from both sides

            RTRIM()
                removes blank spaces from right side

            LTRIM()
                removes blank spaces from left side
        */
test=# select '           aaa                       ';
               ?column?                
---------------------------------------
            aaa                       
(1 row)

test=# select RTRIM('           aaa                       ');
     rtrim      
----------------
            aaa
(1 row)

test=# select TRIM('           aaa                       ');
 btrim 
-------
 aaa
(1 row)

test=# select LTRIM('           aaa                       ');
           ltrim            
----------------------------
 aaa                       
(1 row)



        /* ### OTHER SCALAR FUNCTIONS  */
        /* 
            NOW()
                Gives current time stamp
        */
MariaDB [test]> select now();
+---------------------+
| now()               |
+---------------------+
| 2026-02-07 15:19:34 |
+---------------------+

test=# select now();
              now              
-------------------------------
 2026-02-07 09:49:42.338636+00