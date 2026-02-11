    IN and NOT IN:
        The IN clause is used to compare a value against a group (list) of values.
        It behaves like:
            "Is this value present in this list?"

        NOT IN does exactly the opposite:
            "Is this value NOT present in this list?"


    How IN Works:
        IN checks the column value one row at a time,
        but instead of comparing with a single value,
        it checks if the value exists inside the given group.

    Example:
        SELECT * FROM student
        WHERE city IN ('Pune', 'Delhi', 'Chennai');

        +-----+-------+---------+-------+------------+
        | rno | name  | city    | marks | dob        |
        +-----+-------+---------+-------+------------+
        | 101 | Amit  | Pune    |    85 | 2003-05-12 |
        | 103 | Rohan | Delhi   |    67 | 2004-01-17 |
        | 104 | Amit  | Pune    |    75 | 2003-05-12 |
        | 105 | Sneha | Pune    |    92 | 2002-03-05 |
        | 106 | Vikas | Chennai |    55 | 2005-07-19 |
        | 108 | Amit  | Delhi   |    85 | 2004-02-28 |
        | 110 | Neha  | Pune    |    88 | 2002-11-23 |
        | 111 | Aman  | Delhi   |    35 | 2005-12-02 |
        | 112 | Rhea  | Pune    |    85 | 2003-03-21 |
        | 113 | Zara  | Chennai |    92 | 2004-09-06 |
        | 115 | Karan | Delhi   |    92 | 2002-05-26 |
        | 117 | Meera | Pune    |    55 | 2003-04-10 |
        | 119 | Aditi | Delhi   |    92 | 2004-09-06 |
        | 120 | Zara  | Pune    |    88 | 2004-09-06 |
        +-----+-------+---------+-------+------------+


    Meaning:
        Take only those rows where city is either Pune, or Delhi, or Chennai.

    How search happens:
        For each row:
            row.city → check inside the list ('Pune','Delhi','Chennai')
            If it matches any one → row is selected
            If no match → row is rejected

    Think of IN as:
        city == 'Pune' OR city == 'Delhi' OR city == 'Chennai'


    NOT IN:
        Same logic, but reversed.

    Example:
        SELECT * FROM student
        WHERE per NOT IN (60, 70);

    Meaning:
        If per is 60 or 70 → reject  
        Otherwise → include the row


    Where/When IN is used:
        - When you want to match a value against multiple possible values
        - Cleaner and shorter than writing many OR conditions
        - Very useful with categories, cities, status values, IDs, etc.

        Example:
            WHERE status IN ('Active', 'Pending')
            WHERE rno IN (101, 105, 110)
            WHERE marks IN (80, 90, 95)


    IN with Subquery:
        IN can also check values from a subquery result.

    Example:
        SELECT * FROM student
        WHERE rno IN (SELECT topper_rno FROM toppers);


    How IN works internally:
        Internally SQL does this for each row:
            1) Take the row’s column value
            2) Scan inside the IN list
            3) If found → true
            4) If not found → false

        For bigger IN lists or subqueries, SQL may:
            - convert the list into a hash (fast lookup)
            - remove duplicates
            - optimize the order of comparisons

    So IN behaves like:
        "Check this row’s value inside this set of values."

    And NOT IN behaves like:
        "Select only those rows whose value is not inside this set."


    Summary:
        IN  → pick rows whose value matches ANY value in the list.
        NOT IN → pick rows whose value matches NONE of the values.
        IN is cleaner and faster to write than multiple OR conditions.
