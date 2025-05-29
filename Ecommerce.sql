-- Ecommerce Database SQL Analysis
-- Author: [Your Name]
-- Date: [Submission Date]

-- Database Setup
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Table Creation
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Data Insertion
INSERT INTO customers VALUES
(1, 'Ananya Sharma', 'ananya@example.com', 'Mumbai'),
(2, 'Raj Verma', 'raj@example.com', 'Delhi'),
(3, 'Simran Kaur', 'simran@example.com', 'Bangalore');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Smartphone', 'Electronics', 22000.00),
(103, 'Book', 'Stationery', 500.00);

INSERT INTO orders VALUES
(1001, 1, '2024-05-10', 77000.00),
(1002, 2, '2024-05-12', 500.00),
(1003, 3, '2024-05-15', 22000.00);

INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1001, 102, 1),
(3, 1002, 103, 1),
(4, 1003, 102, 1);

-- Basic Queries
-- 1. Get customers from Delhi
SELECT * FROM customers WHERE city = 'Delhi';

-- 2. List products by price (high to low)
SELECT * FROM products ORDER BY price DESC;

-- Aggregations
-- 3. Total spending per customer
SELECT customer_id, SUM(total_amount) AS total_spent 
FROM orders 
GROUP BY customer_id;

-- Joins
-- 4. Order details with customer names
SELECT o.order_id, c.name AS customer_name, o.order_date, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- Subqueries
-- 5. Customers who spent more than average
SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (SELECT AVG(total_amount) FROM orders)
);

-- Views
-- 6. Create order summary view
CREATE VIEW order_summary AS
SELECT o.order_id, c.name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- NULL Handling
-- 7. Replace NULL emails with placeholder
SELECT IFNULL(email, 'No Email') FROM customers;

-- Indexes for Optimization
CREATE INDEX idx_customer_city ON customers(city);
CREATE INDEX idx_product_category ON products(category);