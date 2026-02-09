/*
    Note: First See group-by.sql


    HAVING:
        The HAVING clause works on the buckets created by GROUP BY.
        Unlike WHERE (which checks each record row-by-row),
        HAVING checks conditions ON GROUPS, not on individual rows.

        WHERE     → filters rows BEFORE grouping  
        HAVING   → filters groups AFTER grouping

        HAVING is mostly used with aggregate functions
        or with the same columns used in GROUP BY.

    Syntax:
        SELECT column, aggregate_function
        FROM table
        GROUP BY column
        HAVING condition;


    Example Table (same student data)
    ----------------------------------
    name   rno   per
    -----+------+-----
    AAA   101    60
    BBB   102    70
    CCC   103    80
    DDD   104    90
    EEE   105    60
    AAA   106    70
    BBB   107    80
    CCC   108    90
    DDD   109    60
    EEE   110    70
    AAA   111    80
    BBB   112    90


    Suppose we group by name:
        GROUP BY name

    This creates buckets like:

    Bucket AAA:
        (101,60), (106,70), (111,80)

    Bucket BBB:
        (102,70), (107,80), (112,90)

    Bucket CCC:
        (103,80), (108,90)

    Bucket DDD:
        (104,90), (109,60)

    Bucket EEE:
        (105,60), (110,70)


    Now, let's apply HAVING
    -----------------------

    Query:
        SELECT name, AVG(per)
        FROM student
        GROUP BY name
        HAVING AVG(per) > 70;


    How it works (step-by-step)
    ----------------------------

    STEP 1:
        GROUP BY creates buckets (as shown above).

    STEP 2:
        For each bucket, SQL calculates AVG(per).

        AAA → (60 + 70 + 80) / 3 = 70.00
        BBB → (70 + 80 + 90) / 3 = 80.00
        CCC → (80 + 90) / 2 = 85.00
        DDD → (90 + 60) / 2 = 75.00
        EEE → (60 + 70) / 2 = 65.00

    STEP 3:
        HAVING applies condition on each bucket:

        HAVING AVG(per) > 70

        AAA → 70     → fails
        BBB → 80     → pass
        CCC → 85     → pass
        DDD → 75     → pass
        EEE → 65     → fails

    STEP 4:
        Only buckets that pass the HAVING condition
        will appear in the final output.

    Final Result:
    -------------
    name   avg_per
    -----+----------
    BBB     80
    CCC     85
    DDD     75


    Why WHERE cannot do this?
    -------------------------
        WHERE works row-by-row.
        It has NO idea what the AVG of a bucket will be,
        because at WHERE stage, buckets do not exist yet.

        WHERE cannot check grouped/aggregated values.
        HAVING can.


    Rules of HAVING:
    ----------------
    Rule 1:
        HAVING works AFTER GROUP BY.
        WHERE works BEFORE GROUP BY.

    Rule 2:
        HAVING can use aggregate functions.
        WHERE cannot.

    Rule 3:
        HAVING filters groups (buckets),
        not individual rows.

    Rule 4:
        Having can also filter using group-by column itself, like:

            HAVING name = 'AAA'

    Rule 5:
        If you want to filter rows → use WHERE
        If you want to filter groups → use HAVING


    Internal Working (Behind the Scenes)
    ------------------------------------

    GROUP BY creates buckets using a Hash Table:
        Key   = group-by column values (e.g., "AAA")
        Value = list of rows belonging to that key

    HAVING works like this:

    STEP 1:
        SQL iterates over each bucket.

    STEP 2:
        For each bucket, SQL computes required aggregates:
        SUM, MAX, MIN, AVG, COUNT...

    STEP 3:
        SQL checks:
            "Does this bucket satisfy the HAVING condition?"

    STEP 4:
        If YES → include bucket in output.
        If NO  → bucket is ignored.

    Pseudo internal structure:

        Buckets = {
            "AAA": [ (101,60), (106,70), (111,80) ],
            "BBB": [ (102,70), (107,80), (112,90) ],
            ...
        }

        For bucket in Buckets:
            if condition_on(bucket):
                output_row(bucket)

    There is NO row-by-row checking here.
    HAVING always works bucket-by-bucket.


    Summary:
    -----------------
        HAVING is like a filter for GROUPS.
        WHERE filters ROWS; HAVING filters BUCKETS.
        HAVING is usually used with aggregate functions.
        HAVING runs only AFTER grouping has happened.


*/