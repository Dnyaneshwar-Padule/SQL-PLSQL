
DROP TABLE account;
CREATE TABLE account (
    acc_no int PRIMARY KEY,
    holder varchar(32) NOT NULL,
    balance numeric CHECK(balance >= 0)
);

DROP TABLE transaction_log;

CREATE TABLE transaction_log (
    txn_id serial PRIMARY KEY,
    from_acc int,
    to_acc int,
    amount numeric,
    txn_time timestamp
);

--Question
--Create a trigger that ensures:
--When a new row is inserted into transaction_log (a transfer request), automatically deduct the amount from from_acc and add it to to_acc in the account table.
--If the from_acc does not have sufficient balance, reject the insert with an error.
--The audit row in transaction_log must still be stored only if the transfer succeeds.

--Trigger functions

CREATE OR REPLACE FUNCTION transaction_log_insert_trigger_fn()
RETURNS TRIGGER AS $$
DECLARE 
    from_acc_balance numeric;
    to_acc_balance numeric;
BEGIN 
    if NEW.from_acc = NEW.to_acc then
        raise exception 'Transaction should be done in two people.';
    end if;

    if NEW.amount < 0 then
        raise exception 'Amount should be positive.';
    end if;

    SELECT balance into from_acc_balance
    from account
    where acc_no = NEW.from_acc;

    if NOT FOUND then
        raise exception 'Sender''s account does not exists.';
    end if;

    SELECT balance into to_acc_balance
    from account
    where acc_no = NEW.to_acc;
    
    if NOT FOUND then
        raise exception 'Receiver''s account does not exists.';
    end if;

    -- Check if from account balance is sufficient
    if from_acc_balance < NEW.amount then
        raise exception 'Insufficient balance in sender''s account.';
    end if;

    --Update the account of both members
    -- deduct amount from sender
    UPDATE account 
    SET balance = balance - NEW.amount
    WHERE acc_no = NEW.from_acc;
    
    -- add amount in the receiver's account
    UPDATE account 
    SET balance = balance + NEW.amount
    WHERE acc_no = NEW.to_acc;

    return NEW;
END;
$$ LANGUAGE 'plpgsql';

-- TRIGGER
CREATE TRIGGER transaction_log_insert_trigger
BEFORE INSERT
ON transaction_log
FOR EACH ROW
EXECUTE PROCEDURE transaction_log_insert_trigger_fn();

INSERT INTO account VALUES (301, 'Ravi', 10000);
INSERT INTO account VALUES (302, 'Maya', 5000);
INSERT INTO account VALUES (303, 'Neha', 20000);

INSERT INTO transaction_log(from_acc, to_acc, amount, txn_time) VALUES(302, 301, 500, CURRENT_TIMESTAMP);