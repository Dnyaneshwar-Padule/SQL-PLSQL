NULL (What it actually means)
-----------------------------
    NULL does not mean 0.
    NULL does not mean empty string.
    NULL does not mean false.

    NULL simply means:
        “Value is unknown / unavailable / not provided.”

    The best way to imagine NULL:
        NULL is like a closed box.
        We don't know what's inside.
        Maybe something is inside, maybe nothing.
        But we cannot look inside that box.

    Because of this, NULL cannot be compared to any value.
    We cannot say:
        NULL = NULL  (false)
        NULL = 10     (false)
        NULL != 10    (false)

    Why?
        Because NULL means "unknown", and you cannot compare
        something unknown with anything — not even with itself.


Why WHERE = NULL never works
----------------------------
    Because '=' means “compare two known values”.

    But NULL is unknown.
    So SQL refuses to say:
        “This unknown value equals that value.”

    That''s why this NEVER works:
        WHERE column = NULL      (always false)

    SQL instead provides special operators:
        IS NULL
        IS NOT NULL

    These do NOT compare values.
    They only check whether the value box is empty or not.


IS NULL
-------
    Checks whether the column contains NULL (unknown).

Example (MySQL & PostgreSQL):

    SELECT * FROM student
    WHERE email IS NULL;

Meaning:
    “Show rows where email is missing.”


IS NOT NULL
-----------
    Checks whether a value is present (not NULL).

Example:

    SELECT * FROM student
    WHERE marks IS NOT NULL;

Meaning:
    “Show rows where marks is available.”


Why this works in programming languages but not in SQL?
-------------------------------------------------------

    In programming languages (C, Java, Python):
        null / None behaves like a special literal value.
        It CAN be compared.
        e.g.,  if (x == null)   → valid

    But in relational databases:
        NULL follows 3-valued logic:
            TRUE
            FALSE
            UNKNOWN

        Comparing NULL with anything produces UNKNOWN.

    Example:
        NULL = NULL  → UNKNOWN
        NULL != NULL → UNKNOWN
        NULL = 5     → UNKNOWN

    SQL cannot use UNKNOWN in WHERE filtering,
    because WHERE needs TRUE to include a row.
    UNKNOWN is treated as FALSE.

    That’s why:
        WHERE column = NULL     → never true


Deep Theory (Why SQL uses UNKNOWN logic)
----------------------------------------
    SQL follows "Three-Valued Logic" (3VL),
    because NULL represents “missing information”.

    In 3VL:
        TRUE AND UNKNOWN → UNKNOWN
        FALSE AND UNKNOWN → FALSE
        UNKNOWN = UNKNOWN → UNKNOWN

    This model allows SQL to deal with incomplete data
    more correctly than binary logic.


Examples with Both Databases
----------------------------

MySQL:
    SELECT * FROM student
    WHERE phone IS NULL;

PostgreSQL:
    SELECT * FROM student
    WHERE address IS NOT NULL;

PostgreSQL + ORDER BY (NULLS FIRST/LAST):
    SELECT * FROM student
    ORDER BY marks NULLS LAST;


Summary
----------------
    - NULL means “unknown value”, not zero or empty.
    - NULL cannot be compared using = or !=.
    - WHERE = NULL never works.
    - We must use:
            IS NULL
            IS NOT NULL
    - Programming languages treat null as a value.
      SQL treats NULL as “unknown”, so comparisons are invalid.
