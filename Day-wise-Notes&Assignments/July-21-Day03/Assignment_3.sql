-- ASSIGNMENT - 03
-- PART 1: Design the Database
CREATE DATABASE assignment3;
USE assignment3;

-- Table creation
CREATE TABLE books(
book_id INT PRIMARY KEY,
title VARCHAR(200),
author VARCHAR(100),
genre VARCHAR(50),
price DECIMAL(5,2)

);

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(200),
city VARCHAR(100)

);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
book_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
order_date DATE,
quantity INT

);

-- PART 2: Insert Sample Data
INSERT INTO books  VALUES
(1, 'A Song of Ice and Fire', 'GRR Martin', 'High Fantasy', 650.00),
(2, 'Bridgerton', 'Julia Quinn', 'Romance', 450.00),
(3, 'The Code Book', 'Simon Singh', 'Science', 520.00),
(4, 'Wings of Fire', 'A.P.J Abdul Kalam', 'Biography', 300.00),
(5, 'Learning SQL', 'Alan Beaulieu', 'Technology', 750.00);

INSERT INTO customers  VALUES
(101, 'Arjun Reddy', 'arjun@example.com', 'Hyderabad'),
(102, 'Meena Kumari', 'meena@example.com', 'Delhi'),
(103, 'Angel Sharmila', 'angel@example.com', 'Chennai'),
(104, 'Divya Suresh', 'divya@example.com', 'Hyderabad'),
(105, 'Rahul Verma', 'rahul@example.com', 'Bangalore');

INSERT INTO orders VALUES
(1001, 101, 1, '2023-02-10', 1),
(1002, 102, 3, '2023-03-15', 2),
(1003, 103, 2, '2022-12-05', 1),
(1004, 104, 5, '2023-05-20', 3),
(1005, 105, 1, '2023-06-01', 2),
(1006, 101, 5, '2023-07-11', 1),
(1007, 102, 3, '2023-07-12', 1);

-- PART 3: Write and Execute Queries
-- Basic Queries
-- 1. List all books with price above 500.
SELECT * 
FROM books
WHERE price > 500;

-- 2. Show all customers from the city of ‘Hyderabad’.
SELECT * 
FROM customers
WHERE city = 'Hyderabad';

-- 3. Find all orders placed after ‘2023-01-01’.
SELECT * 
FROM orders
WHERE order_date > '2023-01-01';

-- Joins & Aggregations
-- 4. Show customer names along with book titles they purchased.
SELECT c.name , b.title
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN books b
ON o.book_id = b.book_id;
-- 5. List each genre and total number of books sold in that genre.
SELECT b.genre, SUM(o.quantity) AS Books_sold_count
FROM books b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.genre;
-- 6. Find the total sales amount (price × quantity) for each book.
SELECT b.title,SUM(b.price * o.quantity) AS total_sales_amount
FROM books b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.title;

-- 7. Show the customer who placed the highest number of orders.
SELECT c.name, COUNT(o.customer_id) as Highest_number_of_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY Highest_number_of_orders DESC
LIMIT 1;

-- 8. Display average price of books by genre.
SELECT genre, AVG(price) AS average_price
FROM books
GROUP BY genre;

-- 9. List all books that have not been ordered.
SELECT * 
FROM books b
LEFT JOIN orders o
ON b.book_id = o.book_id
WHERE o.book_id IS NULL;

-- 10. Show the name of the customer who has spent the most in total.
SELECT c.name, SUM(b.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN books b ON o.book_id = b.book_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;

