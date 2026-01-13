CREATE DATABASE prime;
USE prime; 

CREATE TABLE accounts (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    balance DECIMAL(10,2)
);

INSERT INTO accounts (name,balance) VALUES
("adam",500.00),
("bob", 300.00),
("charlie",1000.00);

SELECT * FROM accounts;

-- TRANSACTION

START TRANSACTION;

UPDATE accounts SET balance = balance - 50 WHERE id=1;
UPDATE accounts SET balance = balance + 50 WHERE id=2;

COMMIT;

-- ROLLBACK
UPDATE accounts SET balance = balance - 50 WHERE id=1;
COMMIT;
UPDATE accounts SET balance = balance + 50 WHERE id=2;
ROLLBACK;


-- SAVEPOINT

START TRANSACTION;
UPDATE accounts SET balance = balance +1000 WHERE id = 1;

SAVEPOINT after_wallet_topup;

UPDATE accounts SET balance = balance +10 WHERE id=1;
-- some error occured

ROLLBACK TO after_wallet_topup;

COMMIT;


-- JOINS

CREATE TABLE CUSTOMERS (
	customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1,"Alice","Mumbai"),
(2,"Bob","Delhi"),
(3,"Charlie","Banglore"),
(4,"David","Mumbai");

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
    customer_id INT,
    amountt INT
);

INSERT INTO orders VALUES
(101,1,500),
(102,1,900),
(103,2,300),
(104,5,700);

SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN

SELECT c.customer_id,o.order_id,c.name -- can write here * to access all
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

--  LEFT/RIGHT JOIN -COMMON VALUES + LEFT/RIGHT TABLE

SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- OUTER JOIN - ALL VALUES OF BOTH THE TABLE

SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
UNION
SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- CROSS JOIN 
SELECT * FROM customers
CROSS JOIN orders;

-- SELF JOIN - same table ke upar join based on some columns

SELECT *
FROM customers as a
JOIN customers as b
ON a.customer_id = b.customer_id;




-- EXCLUSIVE JOINS
SELECT *
FROM customers as A 
LEFT JOIN orders as B
ON A.customer_id = B.customer_id
WHERE B.customer_id IS NULL;

SELECT *
FROM customers as A
RIGHT JOIN orders as B
ON A.customer_id = B.customer_id
WHERE A.customer_id IS NULL;


-- SUB QUERY

-- using under WHERE
SELECT *
FROM orders
WHERE amountt > (
	SELECT AVG(amountt)
    FROM orders
);-- all the orders jo avg se jyada hai

-- using under SELECT
SELECT name,
	(
		SELECT COUNT(*)
		FROM orders  o
        WHERE o.customer_id =c.customer_id
    ) AS order_count
FROM customers c; -- to print name and order count of each customer

-- using under FROM

SELECT 
	summary.customer_id,
    summary.avg_amount
FROM (
	SELECT 
		customer_id ,
		AVG(amountt) as avg_amount
	FROM orders
	GROUP BY customer_id
	) AS summary;
 

--	VIEW - select few columns to show to sales person

CREATE VIEW v1 AS
SELECT customer_id, name FROM customers;

SELECT * FROM v1;

-- those customers jinka order hai apne paas

CREATE VIEW v2 AS
SELECT c.customer_id,c.name,o.order_id
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

SELECT * FROM V2;

DROP VIEW v1;


-- INDEX IN SQL - make data retrival faster for reading and not writing

CREATE TABLE acc (
	acc_id INT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10,2),
    branch VARCHAR(50)
);

INSERT INTO acc VALUES
(1,"adam",500.00,"Mumbai"),
(2,"bob",300.00,"Delhi"),
(3,"charlie",700.00,"Noida");


SELECT * FROM acc;

CREATE INDEX idx_branch ON acc(branch);

SHOW INDEX FROM acc;

SELECT * FROM acc
WHERE branch = "Mumbai";


CREATE INDEX idx2 ON acc(branch,balance);

DROP INDEX idx2 ON acc;


-- STORED PROCEDURES - predefined set of SQL statements that can be executed again and again

DELIMITER $$
CREATE PROCEDURE check_balance(IN ac_id INT, OUT bal DECIMAL(10,2))
BEGIN
	SELECT balance
    FROM acc
    WHERE acc_id = ac_id;
END $$

DELIMITER ;
CALL check_balance(2, @balance);
SELECT @balance;
SELECT * FROM acc;
DROP PROCEDURE IF EXISTS check_bala;






















