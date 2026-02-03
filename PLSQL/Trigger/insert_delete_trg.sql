DROP TABLE customer;
CREATE TABLE customer (
    cid int PRIMARY KEY,
    cname varchar(50) NOT NULL
);

DROP TABLE orders;
CREATE TABLE orders (
    oid serial PRIMARY KEY,
    cid int REFERENCES customer(cid),
    order_date date DEFAULT CURRENT_DATE
);

DROP TABLE order_item;
CREATE TABLE order_item (
    oid int REFERENCES orders(oid),
    pid int,
    qty int CHECK (qty > 0),
    PRIMARY KEY (oid, pid)
);

DROP TABLE product;
CREATE TABLE product (
    pid int PRIMARY KEY,
    pname varchar(50) NOT NULL,
    stock int CHECK (stock >= 0),
    price numeric CHECK(price > 0)
);

-- Question
-- You need to implement triggers with these rules:
-- When inserting into order_item:
-- Check if the product exists.
-- Check if enough stock is available.
-- If valid, reduce the stock by qty.
-- If stock reaches 0, raise a notice.

-- When deleting from order_item (like canceling an item from an order):
-- Increase the product stock back by the qty.
-- If the last item of an order is deleted, automatically delete the corresponding orders row too.

-- FUNCTIONS
CREATE OR REPLACE FUNCTION order_item_insert_trg_fn()
RETURNS TRIGGER AS $$
DECLARE
    available_product_stock int;
BEGIN 

    if NEW.qty < 1 then
        raise exception 'Invalid quantity !';
    end if; 

    SELECT stock into available_product_stock
    FROM product 
    WHERE pid = NEW.pid;

    if NOT FOUND then
        raise exception 'Product with pid : % does not exists !', NEW.pid;
    end if;

    if available_product_stock < NEW.qty then 
        raise exception 'Insufficient product stock !';
    end if;

    UPDATE product
    SET stock = stock - NEW.qty
    WHERE pid = NEW.pid;

    if available_product_stock - NEW.qty = 0 then 
        raise notice 'Stock of product with pid : % is 0', NEW.pid;
    end if;

    return NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION order_item_delete_trg_fn()
RETURNS TRIGGER AS $$
DECLARE 
    item_count int;
BEGIN
    -- Increase product stock
    UPDATE product
    SET stock = stock + OLD.qty
    WHERE pid = OLD.pid;

    -- To check if it's the last item
    SELECT count(*) INTO item_count
    FROM order_item
    WHERE oid = OLD.oid;

    if item_count = 0 then
        DELETE FROM orders WHERE oid = OLD.oid;
    end if; 
    return NULL;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER order_item_insert_trg
BEFORE INSERT
ON order_item
FOR EACH ROW
EXECUTE PROCEDURE order_item_insert_trg_fn();

CREATE TRIGGER order_item_delete_trg
AFTER DELETE
ON order_item
FOR EACH ROW
EXECUTE PROCEDURE order_item_delete_trg_fn();