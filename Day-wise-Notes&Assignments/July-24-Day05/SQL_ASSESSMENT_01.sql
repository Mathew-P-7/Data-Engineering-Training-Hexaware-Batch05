-- SQL Assignment - Personal Fitness Tracker

CREATE DATABASE fitnessdb;
USE fitnessdb;

-- Exercises
CREATE TABLE Exercises(
exercise_id INT PRIMARY KEY,
exercise_name VARCHAR(50),
category VARCHAR(30),
calories_burn_per_min DECIMAL(5,2)
);

-- WorkoutLog
CREATE TABLE WorkoutLog(
log_id INT PRIMARY KEY,
exercise_id INT,
date DATE,
duration_min INT  ,
mood VARCHAR(50),
FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
);

INSERT INTO Exercises VALUES
(1, 'Running', 'Cardio', 10.5),
(2, 'Swimming', 'Cardio', 8.7),
(3, 'Weight Lifting', 'Strength', 5.2),
(4, 'Yoga', 'Flexibility', 3.8),
(5, 'Cycling', 'Cardio', 7.9),
(6, 'Push-ups', 'Strength', 6.1),
(7, 'Pilates', 'Flexibility', 4.3);

INSERT INTO WorkoutLog  VALUES
(1, 1, '2025-03-05', 30, 'Energized'),
(2, 1, '2025-03-12', 45, 'Normal'),
(3, 1, '2025-02-20', 25, 'Tired'),
(4, 2, '2025-03-08', 40, 'Normal'),
(5, 2, '2025-03-15', 35, 'Tired'),
(6, 3, '2025-03-10', 50, 'Tired'),
(7, 3, '2025-03-17', 45, 'Normal'),
(8, 4, '2025-03-01', 60, 'Energized'),
(9, 4, '2025-03-22', 45, 'Normal'),
(10, 5, '2025-03-07', 30, 'Normal'),
(11, 5, '2025-03-14', 50, 'Energized'),
(12, 6, '2025-03-03', 20, 'Tired'),
(13, 6, '2025-03-19', 25, 'Normal'),
(14, 7, '2025-02-28', 40, 'Normal'),
(15, 7, '2025-03-21', 35, 'Energized'),
(16, 1, '2024-02-10', 30, 'Normal'),
(17, 3, '2024-02-15', 40, 'Tired'),
(18, 2, '2025-03-25', 50, 'Energized'),        
(19, 4, '2025-03-28', 30, 'Tired'),           
(20, 5, '2025-03-30', 60, 'Normal'); 

-- Basic Queries
-- 1. Show all exercises under the "Cardio" category.
SELECT * FROM Exercises WHERE category = "Cardio";

-- 2. Show workouts done in the month of March 2025.
SELECT * FROM WorkoutLog WHERE date BETWEEN "2025-03-01" AND "2025-03-31" ORDER BY date;

-- Calculations
-- 3. Calculate total calories burned per workout (duration × calories_burn_per_min).
SELECT e.exercise_name, SUM(w.duration_min*e.calories_burn_per_min) AS total_calories_burned
FROM WorkoutLog w 
JOIN Exercises e
ON w.exercise_id = e.exercise_id
GROUP BY e.exercise_name;

-- 4. Calculate average workout duration per category.

SELECT e.category, AVG(w.duration_min) AS Average_Workout_duration_minutes
FROM WorkoutLog w 
JOIN Exercises e
ON w.exercise_id = e.exercise_id
GROUP BY e.category;

-- JOIN + Aggregation
-- 5. List exercise name, date, duration, and calories burned using a join.
SELECT e.exercise_name, w.date, w.duration_min AS duration, e.calories_burn_per_min
FROM WorkoutLog w 
JOIN Exercises e
ON w.exercise_id = e.exercise_id;

-- 6. Show total calories burned per day.
SELECT w.date, sum(w.duration_min*e.calories_burn_per_min) AS Total_calories_per_day
FROM WorkoutLog w 
JOIN Exercises e
ON w.exercise_id = e.exercise_id
GROUP BY w.date
ORDER BY w.date;

-- Subqueries
-- 7. Find the exercise that burned the most calories in total.
SELECT exercise_name, total_calories_burned
FROM (
SELECT e.exercise_name, SUM(w.duration_min*e.calories_burn_per_min) AS total_calories_burned
FROM WorkoutLog w 
JOIN Exercises e
ON w.exercise_id = e.exercise_id
GROUP BY e.exercise_name
) AS subquery
ORDER BY total_calories_burned DESC
LIMIT 1;

-- 8. List exercises never logged in the workout log.

-- since every exercise logged in workout log, we can insert few mor data.alter
INSERT INTO Exercises (exercise_id, exercise_name, category, calories_burn_per_min) VALUES
(8, 'Jump Rope', 'Cardio', 9.2),
(9, 'Squats', 'Strength', 6.5),
(10, 'Stretching', 'Flexibility', 2.8);

SELECT e.exercise_name
FROM Exercises e
WHERE e.exercise_id NOT IN(
SELECT DISTINCT w.exercise_id
FROM WorkoutLog w
WHERE w.exercise_id IS NOT NULL
);

-- Conditional + Text Filters
-- 9. Show workouts where mood was “Tired” and duration > 30 mins.
SELECT w.log_id, e.exercise_name, w.date, w.duration_min, w.mood
FROM WorkoutLog w
Join Exercises e
ON w.exercise_id = e.exercise_id
WHERE w.mood = "Tired" and w.duration_min > 30;

-- 10. Update a workout log to correct a wrongly entered mood.
UPDATE WorkoutLog SET mood = "Energized" WHERE log_id = 10;

-- Update & Delete
-- 11. Update the calories per minute for “Running”.
UPDATE Exercises SET calories_burn_per_min = 9.5 WHERE exercise_name = "Running";

-- 12. Delete all logs from February 2024.
DELETE FROM Workoutlog WHERE date BETWEEN "2024-02-01" AND "2024-02-29";

