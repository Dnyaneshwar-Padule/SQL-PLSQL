ONE-TO-MANY RELATIONSHIP (1-M)
-----------------------------

Definition:
    In a One-to-Many relationship, one row in Table-A
    can be connected to many rows in Table-B,
    but each row in Table-B is connected to only one row in Table-A.

    So:
        One A → Many B
        One B → Only One A

    Example sentence:
        One department has many employees.
        Each employee belongs to only one department.


Important Concept:
    1-M and M-1 are the SAME relationship.
    It only depends on which side you are observing.

    From Department side:
        1 Department → Many Employees (1-M)

    From Employee side:
        Many Employees → 1 Department (M-1)

    The relationship does not change.
    Only the direction of thinking changes.


Real-Life Use Cases
-------------------

1) Department and Employee
    One department → many employees
    One employee → one department

2) Customer and Orders
    One customer → many orders
    One order → one customer

3) Teacher and Students (if each student has only one class teacher)
    One teacher → many students
    One student → one teacher

4) Country and Cities
    One country → many cities
    One city → one country


Where should we place the Foreign Key?
--------------------------------------

Rule:
    Foreign Key is always placed on the "Many" side.

Why?
    Because each "many" record needs to know
    which "one" record it belongs to.

Example:
    Department (One)
    Employee (Many)

So employee table will contain:
    dept_id (Foreign Key)

NOT the other way around.

Wrong Design:
    Putting employee_id in department table
    would require storing multiple employee IDs in one row,
    which violates relational design.


Example Implementation
----------------------

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

Explanation:
    - department is the "One" side
    - employee is the "Many" side
    - dept_id in employee is the Foreign Key
    - NOT NULL ensures every employee must belong to a department


Optional vs Mandatory 1-M
-------------------------

Case 1: Mandatory Relationship

    dept_id INT NOT NULL

    Means:
        Every employee MUST belong to a department.

Case 2: Optional Relationship

    dept_id INT

    Means:
        Employee may exist without a department.
        (Maybe temporary employee not assigned yet)


Primary Key Constraints in 1-M
------------------------------

Primary Key must always be:
    - UNIQUE
    - NOT NULL

Why?

1) UNIQUE
    Ensures no two rows share the same identity.

2) NOT NULL
    A primary key cannot be unknown.
    If it is NULL, row cannot be identified.

In SQL:
    PRIMARY KEY automatically implies:
        UNIQUE + NOT NULL

So writing PRIMARY KEY is enough.


Alternative: Using UNIQUE Instead of PRIMARY KEY
------------------------------------------------

In parent table:
    PRIMARY KEY is preferred.

But technically:

CREATE TABLE department (
    dept_id INT UNIQUE NOT NULL
);

This also enforces uniqueness,
but PRIMARY KEY is semantically correct and preferred.


What Happens If We Do not Use Foreign Key?
-----------------------------------------

If we remove:

    FOREIGN KEY (dept_id) REFERENCES department(dept_id)

Then employee table can store:

    dept_id = 9999

Even if department 9999 does not exist.

This breaks data integrity.

Foreign key ensures:
    - Parent must exist before child
    - Cannot delete parent if children exist (unless CASCADE)


Internal Logic of 1-M
---------------------

Parent Table (One side):
    department(dept_id)

Child Table (Many side):
    employee(emp_id, dept_id)

Database checks:
    - emp.dept_id must match an existing department
    - One department row can appear many times in employee table


Another Example: Customer and Orders
------------------------------------

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

Meaning:
    One customer → many orders
    Each order → one customer


Summary
-------

    - 1-M means one parent row connects to many child rows.
    - Foreign Key is always stored in the "Many" table.
    - Primary Key must be UNIQUE and NOT NULL.
    - PRIMARY KEY automatically includes UNIQUE + NOT NULL.
    - NOT NULL on Foreign Key makes relationship mandatory.
    - Without FK, data integrity is broken.
    - 1-M and M-1 are same, only perspective changes.
