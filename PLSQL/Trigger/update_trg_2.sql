CREATE TABLE account (
    acc_no int PRIMARY KEY,
    holder varchar(32) NOT NULL,
    balance numeric CHECK(balance >= 0)
);

CREATE TABLE account_audit (
    acc_no int,
    old_balance numeric,
    new_balance numeric,
    updated_at timestamp
);


-- some initial records
INSERT INTO account VALUES (201, 'Raj', 5000);
INSERT INTO account VALUES (202, 'Sita', 15000);
INSERT INTO account VALUES (203, 'Amit', 25000);

--Question
--  Create a trigger such that:
--  On INSERT, if the initial balance is less than 1000, reject the insert with an error.
--  On UPDATE, if the new balance becomes negative, reset it to zero instead of allowing a negative value.
--  Every time an UPDATE changes the balance, log the acc_no, old_balance, new_balance, and updated_at into a separate table account_audit.

-- TRIGGER FUNCTION

CREATE OR REPLACE FUNCTION account_insert_trg_fn()
RETURNS TRIGGER AS $$
BEGIN
    if NEW.balance < 1000 then 
        raise exception 'Initial balance can not be less than 1000.';
    else 
        return NEW;
    end if;
END;
$$ LANGUAGE 'plpgsql';

-- Prevent negative balance
CREATE OR REPLACE FUNCTION account_update_check_fn()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.balance < 0 THEN
        NEW.balance := 0;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Audit balance changes
CREATE OR REPLACE FUNCTION account_update_audit_fn()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.balance IS DISTINCT FROM NEW.balance THEN
        INSERT INTO account_audit(acc_no, old_balance, new_balance, updated_at)
        VALUES(NEW.acc_no, OLD.balance, NEW.balance, NOW());
    END IF;
    RETURN NULL; -- AFTER trigger ignores return value
END;
$$ LANGUAGE plpgsql;

-- Triggers
CREATE TRIGGER account_insert_trg
BEFORE INSERT ON account
FOR EACH ROW
EXECUTE FUNCTION account_insert_trg_fn();

CREATE TRIGGER account_update_check
BEFORE UPDATE ON account
FOR EACH ROW
EXECUTE FUNCTION account_update_check_fn();

CREATE TRIGGER account_update_audit
AFTER UPDATE ON account
FOR EACH ROW
EXECUTE FUNCTION account_update_audit_fn();