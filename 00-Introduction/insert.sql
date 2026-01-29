/*

    INSERT is a DML (Data Manupulation Language) command.
    The insert command is used to insert a record into the table.

    * Syntax.
        INSERT INTO table_name(column_name_1, column_name_2, column_name_N)
        VALUES (value_1, value_2, value_3);

        OR

        INSERT INTO table_name
        VALUES(value_1, value_2, value_N);

        OR

        INSERT INTO table_name
        VALUES
            (value_1, value_2, value_N),     -- 1st record
            (value_1, value_2, value_N),     -- 2nd record
            (value_1, value_2, value_N),     -- 3rd record
            (value_1, value_2, value_N);     -- nth record
    

    In the first command, we are specifying that we are adding values in specified columns, 
    and when we use this type of insert command, remember the sequence of values should match with the sequence of columns

    and in another insert command, we are inserting values into all the tables, 
    at this time, we need to match the sequence of values with the columns of the table
*/

/*

    Q. Given a table,
    
    CREATE TABLE student(
        roll_no int,
        name varchar(32),
        address varchar(256),
        per float,
        mobile_no char(10),
        email varchar(128)
    );

    Insert these records into the table

    record 1:
        roll_no: 101 
        name: Amar
        address: Nanded, Maharashtra
        per: 84.30
        mobile_no: 9900112233

    record 2:
        roll_no: 102
        name: Pranav
        address: Dharashiv, Maharashtra
        per: 83.90
        mobile_no: 9080706050
        email: pranav@gmail.com

    record 3:
        roll_no: 103
        name: Vedant
        address: Solapur, Maharashtra
        per: 90.23
        mobile_no: 9087654321
        email: vedant01@gmail.com
*/


-- Adding first record
INSERT INTO student(roll_no, name, address, per, mobile_no)
VALUES (101, 'Amar', 'Nanded, Maharashtra', 84.30, '9900112233');

--Adding 2nd record
INSERT INTO student VALUES(102, 'Pranav', 'Dharashiv, Maharashtra', 83.90, '9080706050', 'pranav@gmail.com');

-- Adding 3rd record
INSERT INTO student(103, 'Vedant', 'Solapur, Maharashtra', 90.23, '9087654321', 'vedant01@gmail.com');


-- We can add 2nd and 3rd record in a single INSERT query
--    INSERT INTO student
--    VALUES
--        (102, 'Pranav', 'Dharashiv, Maharashtra', 83.90, '9080706050', 'pranav@gmail.com'),
--        (103, 'Vedant', 'Solapur, Maharashtra', 90.23, '9087654321', 'vedant01@gmail.com');