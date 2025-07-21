-- ASSIGNMENT - 04
-- SECTION 1: Database Design
CREATE DATABASE assignment4;
USE assignment4;

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT,
    rental_rate DECIMAL(5,2) 
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) ,
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE rentals (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    movie_id INT,
    rental_date DATE ,
    return_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

-- SECTION 2: Data Insertion
-- Insert movies
INSERT INTO movies VALUES
(1, 'Bahubali', 'Drama', 1994, 2.99),
(2, 'Interstellar', 'Sci-Fi', 2010, 4.95),
(3, 'The Dark Knight', 'Action', 2008, 3.49),
(4, 'Psycho', 'Thriller', 2019, 3.99),
(5, 'Everything Everywhere All at Once', 'Sci-Fi', 2022, 4.49),
(6, 'RRR', 'Action', 2022, 3.99);

-- Insert customers
INSERT INTO customers VALUES
(101, 'Amit Sharma', 'amit.sharma@email.com', 'Mumbai'),
(102, 'Priya Patel', 'priya.patel@email.com', 'Bangalore'),
(103, 'Rahul Verma', 'rahul.verma@email.com', 'Delhi'),
(104, 'Neha Gupta', 'neha.gupta@email.com', 'Bangalore'),
(105, 'Sanjay Singh', 'sanjay.singh@email.com', 'Chennai'),
(106, 'Ananya Das', 'ananya.das@email.com', 'Kolkata');

-- Insert rentals
INSERT INTO rentals  VALUES
(1001, 101, 1, '2023-01-15', '2023-01-20'),
(1002, 101, 2, '2023-02-10', '2023-02-15'),
(1003, 102, 3, '2023-03-05', '2023-03-10'),
(1004, 103, 4, '2023-03-12', '2023-03-18'),
(1005, 104, 5, '2023-04-01', '2023-04-07'),
(1006, 105, 6, '2023-04-15', NULL),
(1007, 101, 3, '2023-05-10', '2023-05-15'),
(1008, 102, 5, '2023-06-20', NULL),
(1009, 103, 2, '2023-06-25', '2023-07-01'),
(1010, 104, 2, '2023-07-10', NULL);

-- SECTION 3: Query Execution
-- Basic Quries:
-- 1. Retrieve all movies rented by a customer named 'Amit Sharma'.
SELECT m.movie_id, m.title, m.genre
FROM movies m
JOIN rentals r
ON m.movie_id = r.movie_id
JOIN customers c
ON r.customer_id = c.customer_id
WHERE c.name = 'Amit Sharma';

-- 2. Show the details of customers from 'Bangalore'.
SELECT *
FROM customers
WHERE city = 'Bangalore';

-- 3. List all movies released after the year 2020.
SELECT * 
FROM movies
WHERE release_year > 2020;

-- Aggregate Queries
-- 4. Count how many movies each customer has rented.
SELECT c.customer_id, c.name, COUNT(r.movie_id) AS Movies_rented
FROM customers c
JOIN rentals r
ON c.customer_id = r.customer_id
LEFT JOIN movies m
ON r.movie_id = m.movie_id
GROUP BY c.customer_id;  

-- 5. Find the most rented movie title.
SELECT m.title, COUNT(r.rental_id) AS Rental_Count
FROM movies m
JOIN rentals r
ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY Rental_Count DESC
LIMIT 1;

-- 6. Calculate total revenue earned from all rentals.
SELECT SUM(m.rental_rate) AS Total_Revenue
FROM rentals r
JOIN movies m 
ON r.movie_id = m.movie_id
WHERE r.return_date IS NOT NULL;

-- Advanced Queries
-- 7. List all customers who have never rented a movie.
SELECT *
FROM customers c
LEFT JOIN rentals r
ON c.customer_id = r.customer_id
WHERE r.rental_id IS NULL;


-- 8. Show each genre and the total revenue from that genre.
SELECT m.genre, SUM(m.rental_rate) AS Genre_revenue
FROM movies m
JOIN rentals r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY genre_revenue DESC;

-- 9. Find the customer who spent the most money on rentals.
SELECT c.name, SUM(m.rental_rate) AS total_spent
FROM customers c
JOIN rentals r ON c.customer_id = r.customer_id
JOIN movies m ON r.movie_id = m.movie_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;

-- 10. Display movie titles that were rented and not yet returned ( return_date IS NULL ).
SELECT m.title, r.rental_date
FROM movies m
JOIN rentals r
ON m.movie_id = r.movie_id 
WHERE r.return_date IS NULL;



