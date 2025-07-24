-- SQL Assignment - Travel Planner
CREATE DATABASE traveldb;
USE traveldb;

-- Destinations
CREATE TABLE Destinations(
destination_id INT PRIMARY KEY,
city VARCHAR(50),
country VARCHAR(50),
category VARCHAR(40),
avg_cost_per_day DECIMAL(10,2)
);

-- Trips
CREATE TABLE Trips(
trip_id INT PRIMARY KEY,
destination_id INT,
traveler_name VARCHAR(100),
start_date DATE,
end_date DATE,
budget INT,
FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);
-- Destinations table values insertion
INSERT INTO Destinations VALUES
(1, 'Goa', 'India', 'Beach', 2500.00),
(2, 'Agra', 'India', 'Historical', 1800.00),
(3, 'Paris', 'France', 'Historical', 4500.00),
(4, 'Nice', 'France', 'Beach', 3800.00),
(5, 'Tokyo', 'Japan', 'Adventure', 5200.00),
(6, 'Kyoto', 'Japan', 'Historical', 4800.00),
(7, 'Queenstown', 'New Zealand', 'Adventure', 4200.00),
(8, 'Queenstown', 'New Zealand', 'Nature', 3900.00),
(9, 'Jaipur', 'India', 'Historical', 2200.00),
(10, 'Bali', 'Indonesia', 'Beach', 2900.00);

-- Trips table values insertion
INSERT INTO Trips VALUES
(1, 1, 'John Snow', '2023-02-10', '2023-02-20', 25000.00),
(2, 2, 'Emma Watson', '2023-03-15', '2023-03-22', 15000.00),
(3, 3, 'Michael Brown', '2023-04-01', '2023-04-10', 45000.00),
(4, 4, 'Sarah Davis', '2023-05-12', '2023-05-19', 30000.00),
(5, 5, 'David Wilson', '2023-06-05', '2023-06-15', 55000.00),
(6, 6, 'Jessica Miller', '2023-07-20', '2023-08-05', 80000.00),
(7, 7, 'Robert Taylor', '2023-08-10', '2023-08-20', 45000.00),
(8, 8, 'Jennifer Anderson', '2023-09-01', '2023-09-11', 40000.00),
(9, 9, 'Thomas Martinez', '2022-12-15', '2022-12-25', 25000.00),
(10, 10, 'Lisa Robinson', '2022-11-10', '2022-11-20', 30000.00),
(11, 1, 'John Snow', '2023-10-05', '2023-10-15', 25000.00),
(12, 2, 'Emma Watson', '2023-11-10', '2023-11-20', 18000.00);

-- Query Tasks
-- Basic Queries
-- 1. Show all trips to destinations in “India”.
SELECT t.*, d.country
FROM Trips t
LEFT JOIN  Destinations d
ON t.destination_id = d.destination_id
WHERE d.country = "India"
ORDER BY t.trip_id;

-- 2. List all destinations with an average cost below 3000.
SELECT * 
FROM Destinations 
WHERE avg_cost_per_day < 3000;

-- Date & Duration
-- 3. Calculate the number of days for each trip.
SELECT trip_id, traveler_name, DATEDIFF(end_date, start_date) + 1 AS duration_days
FROM Trips
GROUP BY trip_id;

-- 4. List all trips that last more than 7 days.
SELECT trip_id, traveler_name, DATEDIFF(end_date, start_date) + 1 AS duration_days
FROM Trips
WHERE DATEDIFF(end_date, start_date) + 1 > 7;

-- JOIN + Aggregation
-- 5. List traveler name, destination city, and total trip cost (duration × avg_cost_per_day).
SELECT t.traveler_name, d.city, (DATEDIFF(end_date, start_date) + 1) * d.avg_cost_per_day AS total_trip_cost
FROM Trips t
JOIN destinations d
ON t.destination_id = d.destination_id ;

-- 6. Find the total number of trips per country.
SELECT d.country, COUNT(t.trip_id) AS total_no_of_trips
FROM Trips t
JOIN destinations d
ON t.destination_id = d.destination_id
GROUP BY d.country;

-- Grouping & Filtering
-- 7. Show average budget per country.
SELECT d.country, AVG(t.budget) AS avg_budget
FROM Trips t
JOIN destinations d
ON t.destination_id = d.destination_id
GROUP BY d.country;

-- 8. Find which traveler has taken the most trips.
-- we can use simple query to find the most trip count travelor, 
SELECT traveler_name, COUNT(trip_id) AS trip_count
FROM Trips
GROUP BY traveler_name
ORDER BY trip_count DESC
LIMIT 1; 

-- but, in my database i am having 2 travelors with most trip count,
-- so i am using a subquery method to filter the most trip count travelors.
SELECT t.traveler_name, COUNT(t.trip_id)
FROM Trips t
GROUP BY t.traveler_name
HAVING COUNT(t.trip_id) = (
SELECT COUNT(t1.trip_id) AS max_count
FROM Trips t1
GROUP BY t1.traveler_name
ORDER BY max_count DESC
LIMIT 1
);

-- Subqueries
-- 9. Show destinations that haven’t been visited yet.
-- Adding few unvisited destinations to the Destinations table
INSERT INTO Destinations VALUES
(11, 'Mahabalipuram', 'India', 'Historical', 1500.00),
(12, 'Hokkaido', 'Japan', 'Nature', 3500.00),
(13, 'Lyon', 'France', 'Historical', 3200.00);

SELECT d.destination_id, d.city, d.country
FROM Destinations d
LEFT JOIN Trips t
ON d.destination_id = t.destination_id
WHERE d.destination_id NOT IN (
SELECT destination_id 
FROM Trips
);

-- 10. Find the trip with the highest cost per day.
SELECT t.trip_id, t.traveler_name, d.city, d.avg_cost_per_day
FROM Trips t
JOIN Destinations d 
ON t.destination_id = d.destination_id
WHERE d.avg_cost_per_day = (
SELECT MAX(avg_cost_per_day)
FROM Destinations
);

-- Update & Delete
-- 11. Update the budget for a trip that was extended by 3 days.
UPDATE Trips t
JOIN Destinations d 
ON t.destination_id = d.destination_id
SET t.end_date = DATE_ADD(t.end_date, INTERVAL 3 DAY),
t.budget = t.budget + (3 * d.avg_cost_per_day)
WHERE t.trip_id = 1;

-- 12. Delete all trips that were completed before Jan 1, 2023.
DELETE FROM Trips WHERE end_date < "2023-01-01";