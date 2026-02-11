/*

    Pagination:
        Pagination means fetching the result set in small chunks (pages) 
        instead of loading all records at once.

        Pagination is done using LIMIT and OFFSET.
        We already know:
            LIMIT  → how many records to show
            OFFSET → how many records to skip

        Suppose a table has 100 records, and we want to show only 10 records per page.
        Then logically:
            Page 1 → first 10 records
            Page 2 → next 10 records
            Page 3 → next 10 records
            ...
            Page 10 → last 10 records

        So overall we have 10 pages (10 x 10 = 100).

        To calculate which rows to skip for a page, we use a small formula:

            OFFSET = n * (p - 1)
            LIMIT  = n

            Where:
                n = number of records per page (like 10)
                p = page number (1,2,3,...)

        For example (n = 10):
            Page 1 → OFFSET = 10 * (1 - 1) = 0   → skip 0 → show rows 1–10
            Page 2 → OFFSET = 10 * (2 - 1) = 10  → skip 10 → show rows 11–20
            Page 3 → OFFSET = 10 * (3 - 1) = 20  → skip 20 → show rows 21–30
            and so on...


    Pagination Query (PostgreSQL)
    ------------------------------
        SELECT *
        FROM student
        ORDER BY id
        LIMIT 10 OFFSET (10 * (p - 1));


    Pagination Query (MySQL)
    ------------------------
    MySQL also supports the same LIMIT + OFFSET syntax:

        SELECT *
        FROM student
        ORDER BY id
        LIMIT 10 OFFSET (10 * (p - 1));

    But MySQL has an additional shortcut:
        LIMIT offset, limit

    So Page 2 (offset 10, limit 10):

        SELECT *
        FROM student
        ORDER BY id
        LIMIT 10, 10;

    This means:
        Skip first 10 rows → show next 10 rows.


    Friendly Summary:
    -----------------
        - Pagination breaks big data into smaller pages.
        - LIMIT = how many rows to fetch.
        - OFFSET = how many rows to skip.
        - Page formula:
                OFFSET = n * (p - 1)
                LIMIT  = n
        - PostgreSQL uses:  LIMIT n OFFSET x
        - MySQL uses:       LIMIT n OFFSET x   or   LIMIT x, n


    ###########################################
                    Example
    ##########################################

    ----------------------------
            PostgreSQL
    ----------------------------
    rno | name | per |    city    
   -----+------+-----+------------
    101 | AAA  |  60 | Pune
    102 | BBB  |  70 | Panji
    103 | CCC  |  80 | Mumbai
    104 | DDD  |  90 | Solapur
    105 | EEE  |  65 | Banglore
    106 | FFF  |  75 | Hyderabad
    107 | GGG  |  85 | Mumbai
    108 | HHH  |  95 | TopperCity
    109 | III  |  45 | Banglore
    110 | JJJ  |  35 | Panji
    111 | KKK  |  82 | Pune
    112 | LLL  |  58 | Mumbai
    113 | MMM  |  92 | TopperCity
    114 | NNN  |  73 | Solapur
    115 | OOO  |  67 | Banglore
    116 | PPP  |  88 | Pune
    117 | QQQ  |  49 | Panji
    118 | RRR  |  77 | Mumbai
    119 | SSS  |  33 | Hyderabad
    120 | TTT  |  96 | TopperCity

        
        =========> FIRST PAGE <===========
        test=# select * from student order by rno offset ( 10 * (1-1) ) limit 10;
        rno | name | per |    city    
        -----+------+-----+------------
        101 | AAA  |  60 | Pune
        102 | BBB  |  70 | Panji
        103 | CCC  |  80 | Mumbai
        104 | DDD  |  90 | Solapur
        105 | EEE  |  65 | Banglore
        106 | FFF  |  75 | Hyderabad
        107 | GGG  |  85 | Mumbai
        108 | HHH  |  95 | TopperCity
        109 | III  |  45 | Banglore
        110 | JJJ  |  35 | Panji


        =========> Second Page <============
        test=# select * from student order by rno offset ( 10 * (2-1) ) limit 10;
        rno | name | per |    city    
        -----+------+-----+------------
        111 | KKK  |  82 | Pune
        112 | LLL  |  58 | Mumbai
        113 | MMM  |  92 | TopperCity
        114 | NNN  |  73 | Solapur
        115 | OOO  |  67 | Banglore
        116 | PPP  |  88 | Pune
        117 | QQQ  |  49 | Panji
        118 | RRR  |  77 | Mumbai
        119 | SSS  |  33 | Hyderabad
        120 | TTT  |  96 | TopperCity



    ---------------------
            MySQL
    ---------------------

    MariaDB [test]> select * from student order by rno;
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



        ===============> First Page <==================
        MariaDB [test]> select * from student order by rno limit 0, 10;
        +-----+-------+-----------+-------+------------+
        | rno | name  | city      | marks | dob        |
        +-----+-------+-----------+-------+------------+
        | 101 | Amit  | Pune      |    85 | 2003-05-12 |
        | 102 | Neha  | Mumbai    |    92 | 2002-11-23 |
        | 103 | Rohan | Delhi     |    67 | 2004-01-17 |
        | 104 | Amit  | Pune      |    75 | 2003-05-12 |
        | 105 | Sneha | Pune      |    92 | 2002-03-05 |
        | 106 | Vikas | Chennai   |    55 | 2005-07-19 |
        | 107 | Rohit | Mumbai    |    67 | 2003-09-13 |
        | 108 | Amit  | Delhi     |    85 | 2004-02-28 |
        | 109 | Meera | Hyderabad |    77 | 2003-04-10 |
        | 110 | Neha  | Pune      |    88 | 2002-11-23 |
        +-----+-------+-----------+-------+------------+

        ===============> Second Page <==================
        MariaDB [test]> select * from student order by rno limit 10, 10;
        +-----+---------+-----------+-------+------------+
        | rno | name    | city      | marks | dob        |
        +-----+---------+-----------+-------+------------+
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


*/