        LIMIT and OFFSET:
            LIMIT is used to restrict how many rows appear in the final result.
            OFFSET is used to skip a certain number of rows before showing results.

            LIMIT works AFTER the query has produced its result set.
            OFFSET decides how many rows to skip from the top.

            Together they are used for pagination.


        Example Table (student)
        ------------------------
        id   name    marks
        ----+--------+-------
        1    Amit      85
        2    Neha      92
        3    Rohan     67
        4    Sneha     92
        5    Vikas     55
        6    Rohit     67
        7    Meera     77
        8    Aman      35
        9    Rhea      85
        10    Zara      92


        Basic LIMIT
        -----------
        Query:
            SELECT * FROM student
            LIMIT 3;

        Meaning:
            "Give me the first 3 rows."

        Result:
        id | name  | marks
        ----+-------+------
        1   Amit     85
        2   Neha     92
        3   Rohan    67


        How LIMIT counts?
        ------------------
        LIMIT ALWAYS counts from the top.
        It does NOT skip anything unless OFFSET is used.

        LIMIT is like:
            result[0], result[1], result[2], ... until limit is reached


        OFFSET
        ------
        OFFSET tells SQL:
            "Skip these many rows, then start showing."

        Query:
            SELECT * FROM student
            OFFSET 3;

        Meaning:
            Skip first 3 rows. Show everything after that.

        Result:
        id | name  | marks
        ----+-------+------
        4   Sneha    92
        5   Vikas    55
        6   Rohit    67
        7   Meera    77
        8   Aman     35
        9   Rhea     85
        10   Zara     92


        LIMIT + OFFSET (Together)
        -------------------------
        Query:
            SELECT * FROM student
            LIMIT 3 OFFSET 3;

        Meaning:
            Skip 3 rows → show next 3 rows.

        Step-by-step:
            Skip:   (1,Amit), (2,Neha), (3,Rohan)
            Take:   next 3 rows

        Result:
        id | name  | marks
        ----+-------+------
        4   Sneha    92
        5   Vikas    55
        6   Rohit    67


        VERY IMPORTANT:
        ----------------
        OFFSET indexing starts from 0.

        Meaning:
            OFFSET 0 → skip nothing
            OFFSET 1 → skip first row
            OFFSET 2 → skip first two rows
            OFFSET 3 → skip first three rows
            And so on...


        LIMIT Forms (Different Syntax)
        ------------------------------

        1) Only LIMIT:
            SELECT * FROM student LIMIT 5;

        2) LIMIT with OFFSET:
            SELECT * FROM student LIMIT 5 OFFSET 10;

        3) MySQL Shorthand (LIMIT x, y):
            SELECT * FROM student LIMIT offset, limit;

            Example:
                SELECT * FROM student LIMIT 3, 4;

            Means:
                OFFSET = 3
                LIMIT  = 4

            So result will be:
                Skip first 3 rows → show next 4 rows


        Understanding LIMIT x, y:
        -------------------------
        LIMIT x, y  
        x = how many rows to skip  
        y = how many rows to take  

        Example:
            SELECT * FROM student LIMIT 1, 3;

            Skip 1 row → show next 3 rows

        Step-by-step:
            Row 1 (id 1) → skip
            Row 2,3,4 → show

        Result:
        id | name  | marks
        ----+-------+------
        2   Neha     92
        3   Rohan    67
        4   Sneha    92


        How LIMIT/OFFSET work internally:
        ----------------------------------
        First:
            SQL creates the final result set (after WHERE, GROUP BY, ORDER BY).

        Second:
            OFFSET is applied → rows skipped.

        Third:
            LIMIT is applied → rows taken.

        This means:
            LIMIT and OFFSET do NOT affect WHERE or GROUP BY.
            They only affect the final sliced output.


        Internal Data Flow (simple)
        ---------------------------
            FinalRows = execute full query

            Output = FinalRows[ OFFSET  :  OFFSET + LIMIT ]

        This is just like slicing a list or array.


        Summary:
        -----------------
            LIMIT = how many rows to show
            OFFSET = how many rows to skip

            LIMIT always counts from row 1 (index 0)
            OFFSET always starts from 0

            LIMIT x, y in MySQL = LIMIT y OFFSET x

            LIMIT and OFFSET work on the final result, 
            after sorting, filtering, grouping, etc.
