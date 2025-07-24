CREATE DATABASE CourseTracker;
USE CourseTracker;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    course_id INT FOREIGN KEY REFERENCES Courses(course_id),
    enrollment_date DATE
);

CREATE TABLE Progress (
    progress_id INT PRIMARY KEY,
    enrollment_id INT FOREIGN KEY REFERENCES Enrollments(enrollment_id),
    completion_percentage FLOAT CHECK (completion_percentage BETWEEN 0 AND 100),
    last_updated DATE
);


-- Insert into Students
INSERT INTO Students (student_id, name, email, join_date)
VALUES 
(1, 'Alice Smith', 'alice@example.com', '2025-05-01'),
(2, 'Bob Johnson', 'bob@example.com', '2025-05-03'),
(3, 'Charlie Lee', 'charlie@example.com', '2025-05-05'),
(4, 'Diana King', 'diana@example.com', '2025-05-07'),
(5, 'Ethan White', 'ethan@example.com', '2025-05-09'),
(6, 'Fiona Black', 'fiona@example.com', '2025-05-11');



-- Insert into Courses
INSERT INTO Courses (course_id, course_name, category)
VALUES 
(101, 'Python Basics', 'Programming'),
(102, 'Data Analysis with Pandas', 'Data Science'),
(103, 'SQL for Beginners', 'Database'),
(104, 'Web Development', 'Programming'),
(105, 'Machine Learning Intro', 'AI'),
(106, 'Excel for Business', 'Productivity');

-- Insert into Enrollments
INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES 
(1001, 1, 101, '2025-05-10'),
(1002, 1, 102, '2025-05-12'),
(1003, 2, 103, '2025-05-14'),
(1004, 3, 104, '2025-05-16'),
(1005, 4, 105, '2025-05-18'),
(1006, 5, 106, '2025-05-20');

-- Insert into Progress
INSERT INTO Progress (progress_id, enrollment_id, completion_percentage, last_updated)
VALUES 
(501, 1001, 85.0, '2025-06-01'),
(502, 1002, 60.0, '2025-06-01'),
(503, 1003, 100.0, '2025-06-01'),
(504, 1004, 40.0, '2025-06-01'),
(505, 1005, 20.0, '2025-06-01'),
(506, 1006, 75.0, '2025-06-01');


INSERT INTO Students (student_id, name, email, join_date)
VALUES (7, 'George Hill', 'george@example.com', '2025-06-01');

--View all students

SELECT * FROM Students;

--Get all enrollments with course and student names

SELECT e.enrollment_id, s.name AS student, c.course_name, e.enrollment_date
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;


-- View progress details for a student
SELECT s.name, c.course_name, p.completion_percentage
FROM Progress p
JOIN Enrollments e ON p.enrollment_id = e.enrollment_id
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.student_id = 1;


--Update student email
UPDATE Students
SET email = 'alice.new@example.com'
WHERE student_id = 1;


--Update course completion percentage
UPDATE Progress
SET completion_percentage = 95, last_updated = GETDATE()
WHERE progress_id = 501;


-- Delete a student
DELETE FROM Students
WHERE student_id = 6;

--Stored Procedure: GetStudentCompletion

CREATE PROCEDURE GetStudentCompletion
    @student_id INT
AS
BEGIN
    SELECT 
        s.name AS student_name,
        c.course_name,
        p.completion_percentage
    FROM Students s
    JOIN Enrollments e ON s.student_id = e.student_id
    JOIN Courses c ON e.course_id = c.course_id
    JOIN Progress p ON e.enrollment_id = p.enrollment_id
    WHERE s.student_id = @student_id;
END;

EXEC GetStudentCompletion @student_id = 1;

