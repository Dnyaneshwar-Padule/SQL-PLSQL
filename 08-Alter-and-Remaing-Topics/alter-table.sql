
    Suppose we created a table using the CREATE command, but later we realize that the table is not fully normalized, or maybe the structure has some mistakes.
    Now if the table already contains many records, then dropping the table and creating it again becomes a big problem.

    Because:
        We have to take backup
        Drop the table
        Create a new table
        Insert all the data again
    So long… and honestly, very time-consuming.
    And yes, a bit frustrating too!
    To save our time, we have a simple, powerful feature: the ALTER command.
    Using ALTER we can change the table structure without losing any data.

    We can:
        Add a column
        Drop a column
        Rename a column
        Add a constraint
        Remove a constraint
        Change datatype
        Increase size of a column
        Add a PRIMARY KEY or FOREIGN KEY (later)
    Basically, ALTER lets us correct our mistakes even after creating the table.

    * Syntax
        Add a column
            ALTER TABLE table_name
            ADD COLUMN column_name data_type;

        Add a column with constraints
            ALTER TABLE table_name
            ADD COLUMN column_name data_type CONSTRAINT;

        Drop a column
            ALTER TABLE table_name
            DROP COLUMN column_name;

        Rename a column
            ALTER TABLE table_name
            RENAME COLUMN old_name TO new_name;

        Modify datatype or size
            ALTER TABLE table_name
            MODIFY COLUMN column_name new_datatype_or_size;

            (MySQL)
            (PostgreSQL uses ALTER COLUMN … TYPE)

        Add PRIMARY KEY
            ALTER TABLE table_name
            ADD CONSTRAINT constraint_name PRIMARY KEY(column_name);

        Add FOREIGN KEY
            ALTER TABLE table_name
            ADD CONSTRAINT constraint_name 
            FOREIGN KEY(column_name) REFERENCES other_table(other_column);

        Drop a constraint
            (MySQL)
            ALTER TABLE table_name
            DROP INDEX constraint_name;

            (PostgreSQL)
            ALTER TABLE table_name
            DROP CONSTRAINT constraint_name;



    ## Example Scenario

    We have a table:

        CREATE TABLE student(
            rno INT,
            name VARCHAR(32),
            marks FLOAT,
            city VARCHAR(16)
        );

    We inserted some valid records.
    But after some time, we realize the table has issues:

        No PRIMARY KEY
        No constraints
        City length is too small
        We need an email_ID column
        And later we also want an aadhar column
        And then we want to rename marks → per

    Now how do we fix all this?
        Should we drop and recreate the table?
        NO!
        We use the ALTER command.


    ## Step-by-step ALTER corrections ##

    1. Make rno the PRIMARY KEY
        ALTER TABLE student
        ADD CONSTRAINT pk_student PRIMARY KEY(rno);

    2. Add NOT NULL to name
        (MySQL)
        ALTER TABLE student
        MODIFY COLUMN name VARCHAR(32) NOT NULL;


        (PostgreSQL)
        ALTER TABLE student
        ALTER COLUMN name SET NOT NULL;

    3. Add CHECK constraint to marks (0–100 range)
        ALTER TABLE student
        ADD CONSTRAINT chk_marks CHECK(marks >= 0 AND marks <= 100);

    4. Add NOT NULL to city + increase size

        (MySQL)
        ALTER TABLE student
        MODIFY COLUMN city VARCHAR(32) NOT NULL;


        (PostgreSQL)

        ALTER TABLE student
        ALTER COLUMN city TYPE VARCHAR(32);

        ALTER TABLE student
        ALTER COLUMN city SET NOT NULL;


    5. Add new column email_ID (UNIQUE, NOT NULL)
   
    If we apply NOT NULL, how will it work? We already have rows and new column requires values!
    Answer:
        If the table already has records, and we add a NOT NULL column, the database will say NO, because existing rows do not have a value for that new column.

    So first add the column without NOT NULL:

        ALTER TABLE student
        ADD COLUMN email_ID VARCHAR(128);


    Then fill values for all existing rows:

        UPDATE student
        SET email_ID = CONCAT('temp', rno, '@gmail.com');


    Now apply NOT NULL + UNIQUE:

        (MySQL)

        ALTER TABLE student
        MODIFY COLUMN email_ID VARCHAR(128) NOT NULL UNIQUE;

    6. Rename marks → per

        (MySQL)

        ALTER TABLE student
        RENAME COLUMN marks TO per;


        (PostgreSQL uses similar syntax)


    7. Add aadhar column (UNIQUE, NOT NULL)

    Same rule:
    First add → fill values → apply NOT NULL

        ALTER TABLE student
        ADD COLUMN aadhar VARCHAR(16);

        UPDATE student
        SET aadhar = CONCAT('TEMP', rno, 'A');


    Then apply UNIQUE + NOT NULL

        (MySQL)

        ALTER TABLE student
        MODIFY COLUMN aadhar VARCHAR(16) NOT NULL UNIQUE;

    8. Later we decide aadhar should not be in this table → drop the column
        ALTER TABLE student
        DROP COLUMN aadhar;

