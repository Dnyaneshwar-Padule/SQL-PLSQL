    BETWEEN:
        The BETWEEN operator is used to check if a value lies inside a range.
        It is used for filtering numbers, dates, or even characters.

        BETWEEN always includes both the start and the end values.
        (It is inclusive.)

    Syntax:
        column BETWEEN lower_value AND upper_value

    This means:
        lower_value <= column <= upper_value


    Examples:
    ---------

    1) Numeric Range:
        SELECT * FROM student
        WHERE marks BETWEEN 70 AND 90;

        Meaning:
            Show rows where marks are 70, 80, 85, 90 — all included.


    2) Date Range:
        SELECT * FROM student
        WHERE dob BETWEEN '2003-01-01' AND '2003-12-31';

        Meaning:
            All students born in the year 2003.


    3) Character Range:
        SELECT * FROM student
        WHERE name BETWEEN 'A' AND 'M';

        Meaning:
            Names starting from A to M (according to alphabetical order).


    How BETWEEN works internally:
    -----------------------------
        BETWEEN is simply shorthand for:
            (column >= lower_value) AND (column <= upper_value)

        SQL checks both boundaries.
        If either side fails, row is rejected.


    NOT BETWEEN:
    ------------
        Reverses the logic.

        SELECT * FROM student
        WHERE marks NOT BETWEEN 70 AND 90;

    Meaning:
        Select rows with marks below 70 or above 90.


    Important Notes:
    ----------------
    1) BETWEEN is inclusive:
        70 BETWEEN 70 AND 90   → true
        90 BETWEEN 70 AND 90   → true

    2) Works with:
        numbers
        dates
        text ranges

    3) BETWEEN becomes ambiguous with strings if the user is unaware
    that SQL uses alphabetical (lexicographical) comparison.

    4) For date comparisons, format must be correct (YYYY-MM-DD).


    Summary:
    -----------------
        BETWEEN checks if a value lies inside a range (inclusive).
        It is just a cleaner form of:
            >=  AND  <=
        NOT BETWEEN selects values outside the range.
