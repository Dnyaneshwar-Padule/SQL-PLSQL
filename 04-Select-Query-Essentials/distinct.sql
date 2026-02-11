    DISTINCT:
        DISTINCT is used to remove duplicate values from the result.
        When a column has repeating values, DISTINCT keeps only one copy
        and removes all duplicates.

        DISTINCT works on the final result set, after filtering (WHERE),
        but before sorting (ORDER BY).


    Basic Example:
        MariaDB [test]> select city from student;
            +-----------+
            | city      |
            +-----------+
            | Pune      |
            | Mumbai    |
            | Delhi     |
            | Pune      |
            | Pune      |
            | Chennai   |
            | Mumbai    |
            | Delhi     |
            | Hyderabad |
            | Pune      |
            | Delhi     |
            | Pune      |
            | Chennai   |
            | Mumbai    |
            | Delhi     |
            | Mumbai    |
            | Pune      |
            | Hyderabad |
            | Delhi     |
            | Pune      |
            +-----------+


       MariaDB [test]> select DISTINCT city from student;
            +-----------+
            | city      |
            +-----------+
            | Pune      |
            | Mumbai    |
            | Delhi     |
            | Chennai   |
            | Hyderabad |
            +-----------+

        Only unique values remain.


    DISTINCT on Multiple Columns:
        DISTINCT also works on combinations of columns.

    Example:
        SELECT DISTINCT name, per FROM student;

        Here SQL checks pairs (name, per).
        Only unique pairs will remain.

        If (AAA, 60) repeats twice, it still appears only once.


    Order of Operation:
        1) WHERE filters rows
        2) DISTINCT removes duplicates
        3) ORDER BY (if used) sorts the distinct result


    Important Notes:
        - DISTINCT applies to the entire select list, not just one column.
        - DISTINCT(column) is not valid in SQL (except in aggregates).
        - DISTINCT can be slower on large tables because duplicates must be checked.

    Summary:
        DISTINCT removes repeated values.
        If values repeat, DISTINCT keeps only one.
        For multiple columns, it keeps unique combinations.
