DROP TABLE product;
CREATE TABLE product (
    pid int PRIMARY KEY,
    pname varchar(50) NOT NULL,
    stock int CHECK(stock >= 0),
    price numeric CHECK(price > 0)
);


DROP TABLE sales;
CREATE TABLE sales (
    sid serial PRIMARY KEY,
    pid int REFERENCES product(pid),
    qty int CHECK(qty > 0),
    sale_time timestamp
);

-- Question
-- Create a trigger such that:
-- When a new row is inserted into sales, the product.stock must automatically decrease by the sold quantity.
-- If there is not enough stock in the product table, reject the sale with an exception.
-- Every successful sale should also log the current timestamp into the sale_time column automatically.
-- Bonus: If stock becomes 0 after the sale, raise a notice saying "Product <pname> is out of stock!".

-- FUNCTION
CREATE OR REPLACE FUNCTION sales_insert_trg_fn()
RETURNS TRIGGER AS $$
DECLARE 
    available_stock int;
    temp_pname varchar(50);
BEGIN 
    if NEW.qty <= 0 then
        raise exception 'Invalid quantity !';
    end if;

    SELECT stock, pname INTO available_stock, temp_pname
    FROM product 
    WHERE pid = NEW.pid;

    if NOT FOUND then
        raise exception 'Product does not exists !';
    end if;

    if available_stock < NEW.qty then
        raise exception 'Not sufficient stock !';
    end if;

    -- Update the product stock
    UPDATE product
    SET stock = stock - NEW.qty
    WHERE pid = NEW.pid;

    NEW.sale_time = CURRENT_TIMESTAMP;

    if available_stock - NEW.qty = 0 then
        raise notice 'Product % is out of stock!', temp_pname ;
    end if;

    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER sales_insert_trg
BEFORE INSERT
on sales
FOR EACH ROW
EXECUTE PROCEDURE sales_insert_trg_fn();


INSERT INTO product VALUES (501, 'Pen', 100, 10);
INSERT INTO product VALUES (502, 'Notebook', 50, 50);
INSERT INTO product VALUES (503, 'Bag', 20, 500);

insert into sales(pid, qty, sale_time) VALUES(501, 50, CURRENT_TIMESTAMP);