
DROP TABLE library_member;
CREATE TABLE library_member (
    mid int PRIMARY KEY,
    mname varchar(50) NOT NULL,
    active boolean DEFAULT true
);

DROP TABLE book;
CREATE TABLE book (
    bid int PRIMARY KEY,
    bname varchar(100) NOT NULL,
    available_copies int CHECK(available_copies >= 0)
);

DROP TABLE issue_log;
CREATE TABLE issue_log (
    iid serial PRIMARY KEY,
    mid int REFERENCES library_member(mid),
    bid int REFERENCES book(bid),
    issue_date date,
    return_date date
);


-- Question
-- Create a trigger such that:
-- When a new row is inserted into issue_log, automatically set issue_date = CURRENT_DATE.
-- Before issuing, check if the member is active. If not, reject the issue.
-- Check if the book has at least one available copy. If not, reject the issue.
-- If allowed, decrement the available_copies in book.
-- When a row in issue_log gets updated with a return_date, increment the available_copies in book again.

--Function
CREATE OR REPLACE FUNCTION issue_log_insert_trigger_fn()
RETURNS TRIGGER AS $$
DECLARE 
    is_member_active boolean;
    book_available_copies int;
BEGIN 
    SELECT active INTO is_member_active
    FROM library_member 
    WHERE mid = NEW.mid;

    if NOT FOUND then 
        raise exception 'Member with mid : % does not exists !', NEW.mid;
    end if;

    if is_member_active = false then
        raise exception 'Member with mid : % is not active !', NEW.mid;
    end if;

    SELECT available_copies INTO book_available_copies
    FROM book 
    WHERE bid = NEW.bid;

    if NOT FOUND then
        raise exception 'Book with bid : % does not exists !', NEW.bid;
    end if;

    if book_available_copies < 1 then
        raise exception 'Book with bid: % has no copies left.', NEW.bid;
    end if;

    -- Decrement available copies of book
    UPDATE book 
    set available_copies = available_copies - 1
    WHERE bid = NEW.bid;

    if book_available_copies - 1 = 0 then 
        raise notice 'Last copy of the book is gone !';
    end if;

    NEW.issue_date = CURRENT_DATE;
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';



CREATE OR REPLACE FUNCTION issue_log_update_trigger_fn()
RETURNS TRIGGER AS $$
BEGIN 
    IF OLD.return_date IS NULL AND NEW.return_date IS NOT NULL THEN
        UPDATE book
        SET available_copies = available_copies + 1
        WHERE bid = NEW.bid;
    END IF;
    return NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER issue_log_insert_trigger
BEFORE insert
ON issue_log
FOR EACH row
EXECUTE PROCEDURE issue_log_insert_trigger_fn();

CREATE TRIGGER issue_log_update_trigger
BEFORE UPDATE
ON issue_log
FOR EACH ROW
EXECUTE PROCEDURE issue_log_update_trigger_fn();

-- Members
INSERT INTO library_member VALUES (1, 'Alice', true);
INSERT INTO library_member VALUES (2, 'Bob', true);
INSERT INTO library_member VALUES (3, 'Charlie', false); -- inactive member

-- Books
INSERT INTO book VALUES (101, 'Database Systems', 2);
INSERT INTO book VALUES (102, 'Operating Systems', 1);
INSERT INTO book VALUES (103, 'Computer Networks', 0); -- no copies available

INSERT INTO issue_log(mid, bid) VALUES(1,103);
INSERT INTO issue_log(mid, bid) VALUES(1,101);
INSERT INTO issue_log(mid, bid) VALUES(2,101);
INSERT INTO issue_log(mid, bid) VALUES(3,102);