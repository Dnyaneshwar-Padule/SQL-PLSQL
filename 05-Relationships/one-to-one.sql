    ONE-TO-ONE RELATIONSHIP (1-1)
    -----------------------------

    Definition:
        In a One-to-One relationship, one row in Table-A
        is connected to exactly one row in Table-B,
        and one row in Table-B is connected to exactly one row in Table-A.

        So:
            One A → One B
            One B → One A


    Real-World Example:
        A person has one passport.
        A passport belongs to one person.

        One person → one passport
        One passport → one person


    Why do we use 1-1 relationships?
    --------------------------------
        Sometimes we split a table into two parts:

        - To store optional information separately
        - To improve security (e.g., sensitive data)
        - To improve organization
        - To reduce NULL values in the main table

        Example:
            student table → basic details
            student_profile table → extra details like address, phone, etc.

        Not every student may have profile details.
        So we separate it.


    How to implement 1-1 relationship
    ----------------------------------

    Method 1 (Most Common & Correct):
        Use Primary Key of parent table
        as both Primary Key AND Foreign Key in child table.

    Example:

    CREATE TABLE student (
        rno INT PRIMARY KEY,
        name VARCHAR(32),
        per FLOAT,
        city VARCHAR(32)
    );

    CREATE TABLE student_profile (
        rno INT PRIMARY KEY,
        phone VARCHAR(15),
        address VARCHAR(100),
        FOREIGN KEY (rno) REFERENCES student(rno)
    );

    Explanation:
        - student_profile.rno is PRIMARY KEY
        - student_profile.rno is also FOREIGN KEY
        - This ensures:
            * Only one profile per student
            * Profile must belong to existing student

        So:
            student 101 → at most one profile row
            profile row 101 → must match student 101


    How does the Primary Key enforce 1-1?
    -------------------------------------
        Because rno is PRIMARY KEY in student_profile,
        duplicate rno values are not allowed.

        So you cannot insert:

            (101, '9999999999', 'Pune')
            (101, '8888888888', 'Mumbai')

        Second insert will fail.

        This guarantees one-to-one mapping.


    Alternative Method (Using UNIQUE)
    ----------------------------------

    CREATE TABLE student_profile (
        id INT AUTO_INCREMENT PRIMARY KEY,
        rno INT UNIQUE,
        phone VARCHAR(15),
        FOREIGN KEY (rno) REFERENCES student(rno)
    );

    Here:
        rno is UNIQUE.
        UNIQUE ensures only one profile per student.
        But rno is not the primary key of this table.

    This also creates 1-1.


    Why not just store everything in one table?
    --------------------------------------------
        You can.
        But sometimes:

        - Profile info is optional.
        - Profile info is sensitive.
        - Profile info is large.
        - Profile info is rarely accessed.

        Splitting improves design.


    What happens if we do not use PRIMARY KEY or UNIQUE?
    ---------------------------------------------------
        If rno is neither PRIMARY KEY nor UNIQUE,
        then this is allowed:

            (101, '9999999999')
            (101, '8888888888')

        Now student 101 has two profiles.
        That becomes 1-M relationship.

        So PRIMARY KEY or UNIQUE is required
        to enforce 1-1.


    Internal Logic:
    ---------------
        In 1-1 relationship:

        Parent Table:
            student (rno)

        Child Table:
            student_profile (rno)

        Database checks:
            - rno in profile must exist in student
            - rno in profile must be unique

        So relationship stays strictly 1-1.


    Summary:
    -----------------
        - 1-1 means one row connects to exactly one row.
        - Implemented using:
            PRIMARY KEY + FOREIGN KEY
            or UNIQUE + FOREIGN KEY
        - Prevents duplicates in child table.
        - Useful for optional or extended information.
        - Without UNIQUE or PRIMARY KEY,
        1-1 turns into 1-M automatically.
