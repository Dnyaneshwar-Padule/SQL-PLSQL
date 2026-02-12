    MANY-TO-MANY RELATIONSHIP (M-M)
    ------------------------------
        In a many-to-many relationship, multiple rows in Table-A are linked to 
        multiple rows in Table-B.

        Real example:
            A student learns from many teachers.
            A teacher teaches many students.

        So:
            One student → many teachers
            One teacher → many students

        Because there are two “many” sides, this is a M-M relationship.


    Why M-M cannot be stored directly in two tables?
    ------------------------------------------------
        You cannot store the foreign key of table B inside A (or vice-versa),
        because one row may need to reference multiple rows.

        Example attempt:
            Put teacher_id inside student table.

            But if student 101 learns from two teachers (T1 and T2),
            you would need two rows:
                (101, T1)
                (101, T2)

            But student has a PRIMARY KEY (say rno = 101),
            so we cannot insert 101 twice.
            PRIMARY KEY must be unique.

        Even if we remove the PRIMARY KEY (which is a very bad mistake),
        the row no longer represents a real-world entity.
        It becomes unclear which student is which.

        There is no clean way to represent “multiple teachers per student”
        using just one column or one table.


    So what do databases do instead?
    --------------------------------
        They use a 3rd table to manage the connection.

        This table is called:
            - Associative Table
            - Junction Table
            - Linking Table
            - Relationship Table

        This table holds the foreign keys of both tables.


    What about descriptive attributes?
    ----------------------------------
        A descriptive attribute is extra information about the relationship itself,
        not about the student or the teacher individually.

        Example descriptive attributes:
            - subject taught
            - start_date
            - end_date
            - class_duration
            - batch_code

        These belong to the *relationship*, not to either table,
        so they live inside the associative table.


    DIALOGUE (for the confusing part)
    ---------------------------------

    Student:
        “Why can’t we just put teacher_id inside the student table?”

    Teacher:
        “Because one student may have multiple teachers.
        You can’t store multiple values in a single column.”

    Student:
        “Then can’t we insert the student row twice?”

    Teacher:
        “No, because the student table has a PRIMARY KEY.
        PRIMARY KEY must be unique.
        If you insert the same student twice,
        you are breaking the most basic rule of relational databases.”

    Student:
        “Then remove the primary key?”

    Teacher:
        “If we remove the primary key:
            - We can no longer uniquely identify a student.
            - Updates become impossible.
            - Deleting one copy might delete too much or too little.
            - We lose all normalization.
            - Joins become confusing.
            - And relationships like 1-M or 1-1 break completely.

        A table without a primary key is not a proper table.
        It is just a bag of loose data.”

    Student:
        “So how do we connect students and teachers?”

    Teacher:
        “We create a third table.
        This third table contains:
            student_id (FK)
            teacher_id (FK)
            + optional descriptive attributes

        This table forms a clean, normalized, proper M-M relationship.”


    How M-M is implemented (Actual SQL)
    -----------------------------------

    TABLES:
        - students
        - teachers
        - student_teacher  (associative table)


    POSTGRESQL:
    -----------

    CREATE TABLE students (
        student_id SERIAL PRIMARY KEY,
        name       VARCHAR(50)
    );

    CREATE TABLE teachers (
        teacher_id SERIAL PRIMARY KEY,
        name       VARCHAR(50)
    );

    CREATE TABLE student_teacher (
        student_id  INT REFERENCES students(student_id),
        teacher_id  INT REFERENCES teachers(teacher_id),
        l_date DATE,       -- descriptive attribute
        PRIMARY KEY (student_id, teacher_id, l_date) 
    );


    MYSQL:
    ------

    CREATE TABLE students (
        student_id INT AUTO_INCREMENT PRIMARY KEY,
        name       VARCHAR(50)
    );

    CREATE TABLE teachers (
        teacher_id INT AUTO_INCREMENT PRIMARY KEY,
        name       VARCHAR(50)
    );

    CREATE TABLE student_teacher (
        student_id INT,
        teacher_id INT,
        l_date DATE,   -- descriptive attribute
        PRIMARY KEY (student_id, teacher_id, l_date),
        FOREIGN KEY(student_id) REFERENCES students(student_id),
        FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id)
    );


    Explanation of the Associative Table
    ------------------------------------
        The associative table holds pairs:
            (student_id, teacher_id)

        Each pair represents a “connection”.

        PRIMARY KEY (student_id, teacher_id) ensures:
            - No duplicate pairs
            - Each relationship is unique

        This table can store extra descriptive attributes
        that belong to the relationship itself.


    How it looks conceptually:
    --------------------------

    students table:
       student_id | name
      ------------+---------
            1     | Amit
            2     | Neha
            3     | Rohan

    teachers table:
     teacher_id | name
    ------------+---------
          10    | Mehta Sir
          11    | Roy Ma’am

    student_teacher table:
     student_id | teacher_id | l_date
    ------------+------------+---------
        1       |     10     |  01-01-2025
        1       |     11     |  02-01-2025
        2       |     11     |  02-01-2025
        3       |     10     |  03-01-2025


    Summary:
    -----------------
        - M-M means many rows in A connect to many rows in B.
        - We CANNOT do M-M by putting foreign key in one table.
        - We MUST use a 3rd associative table.
        - That table holds the relationship pairs.
        - It can also store descriptive attributes.
        - MySQL → uses AUTO_INCREMENT
        - PostgreSQL → uses SERIAL or GENERATED ALWAYS AS IDENTITY
        - M-M is the foundation for complex data models.


####################################################################################

    This relationship table stores information about lecture events.
    A lecture event means:
        which student attended,
        which teacher taught,
        and on what date the lecture happened.

    The table:

        CREATE TABLE student_teacher (
            student_id INT,
            teacher_id INT,
            l_date DATE,      -- descriptive attribute
            PRIMARY KEY (student_id, teacher_id, l_date),
            FOREIGN KEY(student_id) REFERENCES students(student_id),
            FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id)
        );


    Why l_date is NOT NULL:
        The date is the identity of the lecture.
        Without a date, we don’t know when the lecture happened.
        Attendance, reporting, filtering, daily counts — everything depends on date.
        So every lecture must have a valid date, which is why l_date cannot be NULL.


    How the Composite Primary Key works:
        PRIMARY KEY(student_id, teacher_id, l_date)
        means that the combination of:
            student_id + teacher_id + l_date
        must be unique.

        This stops duplicate lecture entries.
        Example:
            (101,111,'2025-01-01') → valid
            (101,111,'2025-01-01') → duplicate → blocked

        Because a student attending the same teacher on the same date is a single event.


    Why these three columns are used as the PRIMARY KEY:
        Each lecture is identified by:
            who attended      → student_id
            who taught        → teacher_id
            when it happened  → l_date

        If any one of them is removed from the primary key:
            - repeated lectures cannot be stored,
            - or duplicate data will not be detected,
            - or rows cannot be uniquely identified.

        Together they form the natural identity of the lecture event.


    Why not use an auto-increment ID?
        If we do this:

            id INT AUTO_INCREMENT PRIMARY KEY,

        then duplicates become possible:
            1,101,111,'2025-01-01'
            2,101,111,'2025-01-01'   ← same lecture, inserted twice

        Auto-increment does not protect the relationship.
        Composite key automatically prevents all duplicates.


    Why foreign keys are used:
        FOREIGN KEY(student_id) REFERENCES students(student_id)
        FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id)

        These ensure:
            - the student must exist in the students table,
            - the teacher must exist in the teachers table,
            - and relationships cannot point to invalid or missing data.

        This keeps the database consistent.


    summary:
        - l_date NOT NULL because every lecture needs a valid date.
        - Composite key ensures one unique row per lecture event.
        - It prevents duplicate attendance entries.
        - Foreign keys ensure student and teacher actually exist.
        - This design keeps attendance data clean, correct, and reliable.


#######################################################################################
                                    Examples
#######################################################################################

CREATE TABLE student(
    rno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    per float CHECK(per >= 0 and per <= 100),
    city varchar(32) NOT NULL
);

CREATE TABLE teacher(
    tno int PRIMARY KEY,
    name varchar(32) NOT NULL,
    city varchar(32) NOT NULL
);

CREATE TABLE student_teacher(
    rno int REFERENCES student(rno),
    tno int REFERENCES teacher(tno),
    l_date DATE,

    PRIMARY KEY (rno, tno, l_date)
);

------------
---- OR ----
------------


CREATE TABLE student_teacher(
    rno INT,
    tno INT,
    l_date DATE,
    PRIMARY KEY(rno, tno, l_date),
    FOREIGN KEY(rno) REFERENCES student(rno),
    FOREIGN KEY(tno) REFERENCES teacher(tno)
);


--------------------------------------------

-- INSERTS FOR student TABLE
INSERT INTO student (rno, name, per, city) VALUES
(101, 'Amit', 85, 'Pune'),
(102, 'Neha', 92, 'Mumbai'),
(103, 'Rohan', 67, 'Delhi'),
(104, 'Sneha', 91, 'Pune'),
(105, 'Vikas', 55, 'Solapur'),
(106, 'Rohit', 73, 'Mumbai'),
(107, 'Meera', 81, 'Delhi'),
(108, 'Aman', 40, 'Pune'),
(109, 'Rhea', 88, 'Hyderabad'),
(110, 'Zara', 95, 'Mumbai');


-- INSERTS FOR teacher TABLE
INSERT INTO teacher (tno, name, city) VALUES
(201, 'Mehta Sir', 'Pune'),
(202, 'Roy Ma’am', 'Mumbai'),
(203, 'Patil Sir', 'Delhi'),
(204, 'Sharma Ma’am', 'Hyderabad');


-- INSERTS FOR student_teacher (relationship table)
INSERT INTO student_teacher (rno, tno, l_date) VALUES
(101, 201, '2025-01-01'),
(101, 201, '2025-01-02'),
(101, 202, '2025-01-03'),

(102, 202, '2025-01-01'),
(102, 203, '2025-01-02'),

(103, 203, '2025-01-01'),
(103, 204, '2025-01-05'),

(104, 201, '2025-01-01'),
(104, 202, '2025-01-06'),

(105, 203, '2025-01-03'),

(106, 202, '2025-01-04'),
(106, 204, '2025-01-06'),

(107, 201, '2025-01-02'),

(108, 204, '2025-01-01'),
(108, 204, '2025-01-02'),

(109, 202, '2025-01-03'),

(110, 201, '2025-01-04'),
(110, 203, '2025-01-04');
