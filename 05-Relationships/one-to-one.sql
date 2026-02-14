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


    Types of One-to-One Relationships
    ---------------------------------

    1) Weak (Optional) 1-1 Relationship:
        This happens when the child table depends on the parent,
        but the parent does not strictly require the child.

        Example:
            student → student_profile

        Not every student must have a profile.
        So the relationship is optional from the parent''s side.

        This is sometimes called a weak relationship
        because the child table depends on the parent table for identity.


    2) Strong (Mandatory) 1-1 Relationship:
        This happens when both entities must exist together.

        Real-life example:
            Bride and Groom in a Marriage Registration System.

        One bride → one groom
        One groom → one bride

        If a bride exists in the marriage table,
        a groom must exist.
        Neither side is optional.

        This is a strict 1-1.


    Why do we use 1-1 relationships?
    --------------------------------
        Sometimes we split a table into two parts:

        - To store optional information separately
        - To improve security (e.g., sensitive data)
        - To improve organization
        - To reduce NULL values in the main table
        - To separate sensitive data (e.g., salary, passport info)

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


    When should we use NOT NULL?
    -----------------------------

    NOT NULL determines whether the relationship is mandatory.

    Case 1: Optional 1-1
        If rno in student_profile is NOT NULL (it usually is),
        but the profile table row itself may or may not exist,
        then the relationship is optional from the student side.

        Meaning:
            Student can exist without profile.
            But profile cannot exist without student.

    Case 2: Mandatory 1-1
        Suppose in a marriage registration system:

    CREATE TABLE bride (
        bride_id INT PRIMARY KEY
    );

    CREATE TABLE groom (
        bride_id INT PRIMARY KEY,
        FOREIGN KEY (bride_id) REFERENCES bride(bride_id)
    );

        Here:
            Every groom must correspond to exactly one bride.
            Every bride must have exactly one groom.

        If we make the foreign key NOT NULL,
        it enforces that the relationship must exist.

    Real-life NOT NULL Example:
        Consider Aadhaar and Citizen.

        Every Aadhaar must belong to a citizen.
        So Aadhaar.citizen_id should be:
            NOT NULL
            PRIMARY KEY
            FOREIGN KEY

        This makes the relationship strict and mandatory.


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
            - If NOT NULL is used, relationship becomes mandatory

        So relationship stays strictly 1-1.


    Important Concept:
    ------------------
        PRIMARY KEY ensures uniqueness.
        FOREIGN KEY ensures existence.
        NOT NULL ensures mandatory participation.

        Together they define the strength of the relationship.


    Summary:
    -----------------
        - 1-1 means one row connects to exactly one row.
        - Can be weak (optional) or strong (mandatory).
        - Implemented using:
            PRIMARY KEY + FOREIGN KEY
            or UNIQUE + FOREIGN KEY
        - NOT NULL makes the relationship mandatory.
        - Prevents duplicates in child table.
        - Without UNIQUE or PRIMARY KEY,
        1-1 turns into 1-M automatically.
