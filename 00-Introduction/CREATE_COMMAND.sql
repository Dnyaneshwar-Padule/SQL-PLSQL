/*

    * The create command in SQL is a DDL (Data Definition Language) command

    We can create a Database, Table, View, Index, Sequence, Procedure, Function, Trigger, User, Role, Schema, Type, Temporary Table, Synonym, Event, Materialized View with the help of CREATE command

    1. Create Database:
        Used to create a new database.
        - Syntax: CREATE DATABASE database_name;
        - ex. CREATE DATABASE test_db;

    2. Create table:
        Used to create a table.
        - Syntax: CREATE TABLE table_name(
                        column_name datatype constraint,
                        .
                        .
                        .
                  );

            - The constraint is optional.
        - ex. CREATE TABLE student(
                    rno int PRIMARY key,
                    name varchar(32) NOT NULL,
                    per float,
                );
        - WE will see the constraint later...


    - We will see other uses of CREATE command later...
*/

/*
    Q. Create a database named nmiet_db, and create a student table in it with fields (rno, name, per)
*/

CREATE DATABASE nmiet_db;  -- creating database

connect nmiet_db; -- Switching to nmiet_db databse or using it 
-- use nmiet_db;
-- /c nmiet_db; 
-- We can use anything among these, but it depends on the database


-- creating student table
CREATE TABLE student(
    rno int PRIMARY KEY,                     -- setting rno as the PRIMARY KEY
    name varchar(32) NOT NULL,               -- name should not be null
    per float CHECK(per >= 0 and per <= 100) -- per should be between 0-100
);

/*
    Note:- 
        Constraints help us to avoid inserting invalid data.
*/