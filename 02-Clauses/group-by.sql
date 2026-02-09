/*

    GROUP BY:
        The GROUP BY clause in SQL groups rows into buckets, where each bucket contains rows 
        with the same value for the column(s) used in GROUP BY. 
        In simple words, GROUP BY collects rows that share the same value and puts them together.


    Syntax: 
        GROUP BY column_1, column_2....


    For example:-
        Suppose we have a result set like this
            For table student, with records

            name rno  per
           -----+----+----
            AAA  101  60
            BBB  102  70
            CCC  103  80
            DDD  104  90
            EEE  105  60
            AAA  106  70
            BBB  107  80
            CCC  108  90
            DDD  109  60
            EEE  110  70
            AAA  111  80
            BBB  112  90

        and suppose, we group these records by name
        So what  will happen ?

        SQL engine will scan each row one by one and maintain buckets.
        You can imagine a bucket as a HashTable entry or a Dictionary entry,
        where the "key" is the value used for grouping (here: name),
        and the "value" is a list of all rows that belong to that key.

        See, at first there is {AAA, 101, 60}
        Then what it does is, It sees is there any bucket with It's ID (bucket-identifier) as 'AAA', 
            For now, there are not a single bucket, So it creates a new Bucket with a label or ID as 'AAA' and puts the other values into that bucket

            +------------+
            |     AAA    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  101 |  60 |  <- Other values
            +------+-----+

            Now, It has created a bucket for AAA.


        Then, It goes to the next records which is {BBB, 102, 70}, now it again checks, is there any bucket with lable/name/ID as 'BBB'
            No, there is only one bucket as it's label is 'AAA', so it creates a new bucket for 'BBB'
            
            +------------+
            |     BBB    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  102 |  70 |  <- Other values
            +------+-----+
            
            Now, there are two Buckets, one for 'AAA' and other for 'BBB'

        Then, It goes to the next record, which is {CCC, 103, 80}, it again checks, it there any bucket for CCC, 
            No, so it create a new bucket for C

            +------------+
            |     CCC    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  103 |  80 |  <- Other values
            +------+-----+

            Now, there are three buckets, one for 'AAA', one for 'BBB' and one for 'CCC'

        Then, It goes to the next records, which is {DDD, 104, 90}, it checks Bucket for 'DDD'
            and, there is no bucket for 'DDD', so creates a new one

            +------------+
            |     DDD    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  104 |  90 |  <- Other values
            +------+-----+
    
            Now, there are four buckets, for 'AAA', 'BBB', 'CCC' and 'DDD'

        Then, It goes for the next record, which is {EEE, 105, 60}, it checks if there is a bucket for 'EEE'
            No, there isn't any, So it creates a new bucket for 'EEE'

            +------------+
            |     EEE    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  105 |  60 |  <- Other values
            +------+-----+

            Now, there are five buckets, for 'AAA', 'BBB', 'CCC', 'DDD' and 'EEE'

        Then it goes for the next record, which is {AAA,106, 70}, It checks Is there any bucket for 'AAA'
            and YES !!, There is one bucket with label 'AAA', so it inserts rno and per of this record into that bucket

            +------------+
            |     AAA    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  101 |  60 |  
            |  106 |  70 | <- Another record inserted here...
            +------+-----+

            We, can see that the student.name is used as the bucket name or bucket label,
                and it makes senese, that we are group all the records by name, so duplicating name, with each record does not make sense
                like this

                +------------------+
                |        AAA       |   <- Bucket Label or Bucket ID
                +------+-----+-----+
                | name | rno | per |     
                +------+-----+-----+
                |  AAA | 101 |  60 |  
                |  AAA | 106 |  70 |
                +------+-----+-----+
                
                This does not make sense, as we know all these records have same name, so there should only be one name for all of those
                    like there in the previous table...


        Then it goes for the next record, which is {BBB, 107, 80}, It checks's If there is a bucket for 'BBB'
            Yes, there is an existing bucket for 'BBB', so it inserts this record into that bucket

            
            +------------+
            |     BBB    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  102 |  70 | 
            |  107 |  80 |
            +------+-----+

        Then, it goes for next record, which is {CCC, 108, 90}, it checks is there a bucket exists for 'CCC', 
           Yes, there is a bucke for CCC, so insert this record into that bucket

            +------------+
            |     CCC    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  103 |  80 |
            |  108 |  90 |
            +------+-----+

        Then, it goes for the next record which is {DDD, 109, 60}, it checks, is there any bucket exists, for 'DDD'
            Yes, there is a bucket for 'DDD', so insert this record there

            +------------+
            |     DDD    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  104 |  90 |  
            |  109 |  60 | 
            +------+-----+

        Next record, {EEE, 110, 70}, check if there is a bucket exists for 'EEE'
            Yes, now insert this record into that bucket

            +------------+
            |     EEE    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  105 |  60 |  
            |  110 |  70 | 
            +------+-----+

        Next record, {AAA, 111, 80}, check if there is a bucket for 'AAA'
            Yes, so insert this record into that bucket

            +------------+
            |     AAA    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  101 |  60 |  
            |  106 |  70 | 
            |  111 |  80 |
            +------+-----+

        Last record, {BBB, 112, 90}, check is there is a bucket for 'BBB'
            Yes, then insert the record into that record

                        
            +------------+
            |     BBB    |   <- Bucket Label or Bucket ID
            +------------+
            |  rno | per |     
            +------+-----+
            |  102 |  70 | 
            |  107 |  80 |
            |  112 |  90 | 
            +------+-----+

        
        So, It's DONE !!!
        We have successfully grouped all records acording to the name, 
        which looke like this

        The original table
            name rno  per
           -----+----+----
            AAA  101  60
            BBB  102  70
            CCC  103  80
            DDD  104  90
            EEE  105  60
            AAA  106  70
            BBB  107  80
            CCC  108  90
            DDD  109  60
            EEE  110  70
            AAA  111  80
            BBB  112  90


        After grouping by names

        +------------+  +------------+  +------------+  +------------+  +------------+
        |     AAA    |  |     BBB    |  |     CCC    |  |     DDD    |  |     EEE    |
        +------------+  +------------+  +------------+  +------------+  +------------+
        |  rno | per |  |  rno | per |  |  rno | per |  |  rno | per |  |  rno | per |
        +------+-----+  +------+-----+  +------+-----+  +------+-----+  +------+-----+
        |  101 |  60 |  |  102 |  70 |  |  103 |  80 |  |  104 |  90 |  |  105 |  60 |
        |  106 |  70 |  |  107 |  80 |  |  108 |  90 |  |  109 |  60 |  |  110 |  70 |
        |  111 |  80 |  |  112 |  90 |  +------+-----+  +------+-----+  +------+-----+  
        +------+-----+  +------+-----+



        =============================================================================

        HOW GROUP BY WORKS INTERNALLY (REAL SQL ENGINE EXPLANATION)
            
            Internally SQL uses Hashing
            Almost all modern databases use:
            Hash Table (HashMap / Dictionary)

                Key → grouping column value (name)
                Value → list of rows belonging to that key

            Example internal structure:
                HashTable = {
                    "AAA": [ (101,60), (106,70), (111,80) ],
                    "BBB": [ (102,70), (107,80), (112,90) ],
                    "CCC": [ (103,80), (108,90) ],
                    "DDD": [ (104,90), (109,60) ],
                    "EEE": [ (105,60), (110,70) ]
                }

            Steps 
                SQL scans each row one-by-one
                Computes a hash for the key (e.g., "AAA")
                Looks in the hashtable:
                    If bucket exists → append
                    Else → create bucket and append
                After all rows processed → each bucket → one group
                Aggregate functions (MAX, SUM, COUNT) run on each bucket
                Final result: one row per bucket


        =====================================================================================

        And here are some rules for Group By, 
            Rule 1:
                When using GROUP BY, every column in SELECT must be:
                    - either included in GROUP BY
                    OR
                    - used inside an aggregate function (like COUNT, SUM, AVG, MAX, MIN)

                Why?
                    Because GROUP BY collapses multiple rows into a single row per group.
                    Columns not part of grouping become ambiguous unless you aggregate them.
                    
                    Invalid:
                        SELECT name, rno
                        FROM student
                        GROUP BY name;
                        Because rno has multiple values for the same name.

                        See in the above example of name, We grouped it by the name, and buckets are formed
                        now, those buckets are like rows, i.e. There are rows (as there are five buckets)
                        and if we try to select rno or per, then, SQL engine will confuse which value to choose
                            for example, take this bucket
                            +------------+
                            |     BBB    |  
                            +------------+
                            |  rno | per |     
                            +------+-----+
                            |  102 |  70 | 
                            |  107 |  80 |
                            |  112 |  90 | 
                            +------+-----+
                        See, there is only one value for name, which is BBB, but for per there are three values (70,80,90)
                        SQL engine won't get which to choose, (though MariaDB choose random value)

                    Valid:
                        SELECT name, MIN(rno)
                        FROM student
                        GROUP BY name;
                        Now SQL knows which rno to show.


            Rule 2:
                You can apply aggregate functions on non-grouped columns.

                How?
                    Aggregate functions summarize the rows inside each bucket:
                        COUNT(*) → how many rows?
                        MAX(per) → highest marks in that group?
                        SUM(per) → total marks?
                        AVG(per) → average marks?
                Example:
                    SELECT name, AVG(per)
                    FROM student
                    GROUP BY name;


            Rule 3:
                GROUP BY always works on the original table.
                Not on the output of another GROUP BY.

                Meaning:
                    GROUP BY does NOT group an already grouped result.
                    Each GROUP BY starts fresh on the raw table.

            --------------------------------------------------------------------------------------
                Neat Explanation of Rule 3:
                GROUP BY (Rule 3 - Multi Column Grouping)
                -----------------------------------------

                Rule:
                    GROUP BY always works on the original table.
                    It does NOT group the result of another GROUP BY.
                    When we group by multiple columns, SQL creates buckets using
                    the *combined value* of those columns.

                    Meaning:
                        GROUP BY name, per
                        creates groups by the unique pair (name, per),
                        NOT by grouping name first and then grouping per inside it.


                Table (Example)
                ---------------
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


                Query:
                ------
                    SELECT name, per
                    FROM student
                    GROUP BY name, per;


                How SQL Actually Groups
                ------------------------
                SQL reads each row one-by-one and maintains a HashTable (Dictionary).

                Key     = (name, per)
                Value   = list of rows (rno, per)

                Each unique (name, per) pair becomes its own bucket.


                STEP-BY-STEP BUCKET CREATION
                ----------------------------

                Row 1: AAA, 101, 60
                Key = (AAA,60)
                No bucket → Create

                    +----------------+
                    |  AAA , 60      |
                    +----------------+
                    | rno | per      |
                    +------------ ----+
                    | 101 | 60       |
                    +----------------+

                Row 2: BBB, 102, 70 → Create (BBB,70)
                Row 3: CCC, 103, 80 → Create (CCC,80)
                Row 4: DDD, 104, 90 → Create (DDD,90)
                Row 5: EEE, 105, 60 → Create (EEE,60)

                Row 6: AAA, 106, 70
                Key = (AAA,70)
                This is a NEW combination → Create bucket

                Row 7: BBB, 107, 80 → Create (BBB,80)
                Row 8: CCC, 108, 90 → Create (CCC,90)
                Row 9: DDD, 109, 60 → Create (DDD,60)
                Row 10: EEE,110, 70 → Create (EEE,70)

                Row 11: AAA,111, 80 → Create (AAA,80)
                Row 12: BBB,112, 90 → Create (BBB,90)


                FINAL BUCKETS
                --------------

                (AAA,60) → 101
                (AAA,70) → 106
                (AAA,80) → 111

                (BBB,70) → 102
                (BBB,80) → 107
                (BBB,90) → 112

                (CCC,80) → 103
                (CCC,90) → 108

                (DDD,90) → 104
                (DDD,60) → 109

                (EEE,60) → 105
                (EEE,70) → 110


                INTERNAL HASH TABLE (behind the scenes)
                ----------------------------------------
                SQL internally constructs:

                HashTable = {
                    ("AAA",60): [101],
                    ("AAA",70): [106],
                    ("AAA",80): [111],

                    ("BBB",70): [102],
                    ("BBB",80): [107],
                    ("BBB",90): [112],

                    ("CCC",80): [103],
                    ("CCC",90): [108],

                    ("DDD",90): [104],
                    ("DDD",60): [109],

                    ("EEE",60): [105],
                    ("EEE",70): [110]
                }

                Key → combined grouping value
                Value → rows belonging to that key

                This is how SQL groups efficiently.


                IMPORTANT NOTES
                ----------------
                1. GROUP BY (name, per) does not mean:
                    group by name → then group inside by per
                That never happens.

                2. GROUP BY always starts fresh on the original table.

                3. GROUP BY creates a bucket for every unique combination
                of the columns used in group by.

                4. Aggregates (COUNT, MAX, SUM, AVG, MIN) operate INSIDE
                each bucket.

                5. Final result shows ONLY ONE ROW per bucket.


                Friendly Summary
                ----------------
                    GROUP BY name, per
                    means:
                        "Create a bucket for each unique pair (name + per),
                        and place all matching rows inside that bucket."

                    SQL internally stores:
                        key   = (name, per)
                        value = list of rows

                    Each unique pair produces exactly one output row.

*/