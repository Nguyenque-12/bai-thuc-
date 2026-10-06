CREATE DATABASE IF NOT EXISTS flashmart_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE flashmart_db;

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

TRUNCATE TABLE Orders;
TRUNCATE TABLE Customers;
TRUNCATE TABLE Products;

INSERT INTO Customers (customer_id, name) VALUES 
(1, 'Alice'), 
(2, 'Bob'), 
(3, 'Charlie'); -- Charlie chưa từng mua hàng

INSERT INTO Products (product_id, product_name) VALUES 
(101, 'Laptop'), 
(102, 'Mouse'), 
(103, 'Keyboard'); -- Keyboard chưa từng được mua

INSERT INTO Orders (order_id, customer_id, product_id) VALUES 
(1001, 1, 101), 
(1002, 1, 102), 
(1003, 2, 101);

SELECT 
    c.customer_id, 
    c.name, 
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

SELECT 
    p.product_id, 
    p.product_name
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;