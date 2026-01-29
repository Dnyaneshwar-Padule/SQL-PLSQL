/*

        In programming languages we use data types to tell what kind of data a variable can hold.
    SQL also uses data types, but here they are used to define what kind of data a column in a table can store.
    Different DBMS (MySQL, PostgreSQL, Oracle, SQL Server) may have different names or limits for datatypes, but the core idea is same everywhere.

    Below are the commonly used SQL data types, with practical explanations.

    1. INT / INTEGER

        Used when a column should store whole numbers (positive or negative).
        No decimal part is allowed.
        Different DBMS have different integer ranges like SMALLINT, BIGINT, etc.

        Example:
        age INT — age will always be a whole number.

    2. CHAR(n)

        CHAR is a fixed-length string.
        If the length is CHAR(20), SQL will always reserve 20 bytes for that column, even if you store just 5 characters.

        So CHAR is useful only when the string length is always constant (like country codes, fixed IDs).

        Example:
        country_code CHAR(3) → Always stores exactly 3 characters.

    3. VARCHAR(n)

        VARCHAR is a variable-length string.
        If you write VARCHAR(50), it means maximum allowed size is 50 characters, but storage will depend only on the actual string size.

        Example:
        name VARCHAR(50)
        If name is “Ravi”, only 4 bytes are used.

    4. TEXT / CLOB

        Used when the column has to store large text — paragraphs, descriptions, logs, comments.
        Unlike VARCHAR, TEXT doesn’t need a length.

        Different DBMS have variations:

        MySQL → TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT

        PostgreSQL → TEXT

        Oracle → CLOB (Character Large Object)

    5. FLOAT / DOUBLE / REAL

        Used to store decimal numbers (numbers with a fractional part).
        Different DBMS prefer different names, but idea is same.
        FLOAT and DOUBLE also differ in precision: DOUBLE usually stores more accurate values.

        Example:
        price DOUBLE → 599.99, 109.5, etc.

    6. DECIMAL(p, s) / NUMERIC(p, s)

        Used for storing exact decimal values (no rounding errors).
        Mostly used in banks, finance, money-related calculations.

        p = precision (total digits)

        s = scale (digits after decimal)

        Example:
        DECIMAL(10,2) → 99999999.99 max value
        Perfect for salaries, money, transactions.

    7. DATE

        Stores only a calendar date: year–month–day.
        No time.

        Example:
        birth_date DATE → ‘2026-01-28’

    8. TIME

        Stores only time: hours, minutes, seconds.
        No date.

    9. DATETIME / TIMESTAMP

        Stores both date + time.
        TIMESTAMP also keeps timezone / UTC-related behaviour in some DBMS.

        Used for created_at, updated_at columns.

        Example:
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

    10. BOOLEAN

        Represents TRUE or FALSE values.
        Some DBMS internally store it as tinyint (0/1), but behave like boolean.

    11. BINARY / VARBINARY

        Used to store raw binary data (files, images, encrypted bytes, etc).

        Example:
        file_hash BINARY(32)
        image VARBINARY(10000)

    12. JSON

        Modern DBMS like MySQL, PostgreSQL support native JSON type.
        Used to store structured JSON data with validation.

        Example:
        data JSON

    13. ENUM

        A set of predefined values.
        Column can store only one value from this list.

        Example:
        status ENUM('pending','success','failed')

        PostgreSQL supports custom ENUM types using CREATE TYPE.

    14. UUID

        A 128-bit globally unique identifier.
        PostgreSQL has native UUID type.
        Useful for generating distributed unique IDs instead of auto-increment numbers.

        Example:
        user_id UUID DEFAULT gen_random_uuid()

    15. XML (rare now)

        Some DBMS offer an XML type to store XML documents.
        Mostly used in older enterprise applications.

    16. GEOMETRY / POINT / GIS types

        Used in spatial databases (location, map data).
        MySQL & PostGIS (PostgreSQL extension) support these types.

        Example:
        location POINT
        Used for latitude/longitude.

    17. BLOB

        Binary Large Object.
        Used for storing large files, images, documents.

        MySQL has TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB.

        These are the major SQL datatypes you will see across relational databases.
        Each DBMS may have extra custom types, but the fundamental categories remain consistent.
     
    
*/