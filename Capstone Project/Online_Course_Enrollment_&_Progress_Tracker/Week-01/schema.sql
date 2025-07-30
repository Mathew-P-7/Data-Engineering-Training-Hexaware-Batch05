CREATE DATABASE CourseTracker;
USE CourseTracker;

-- Table Creation
-- students
CREATE TABLE students(
student_id INT AUTO_INCREMENT  PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100) UNIQUE
) AUTO_INCREMENT = 101;

-- courses
CREATE TABLE courses(
course_id INT AUTO_INCREMENT PRIMARY KEY,
course_name VARCHAR(100),
instructor VARCHAR(100),
enrollment_count INT DEFAULT 0
) AUTO_INCREMENT = 201; 

-- enrollments
CREATE TABLE enrollments(
enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
course_id INT,
enrollment_date DATE,
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
) AUTO_INCREMENT = 301;

-- progress
CREATE TABLE progress(
progress_id INT AUTO_INCREMENT  PRIMARY KEY,
student_id INT,
course_id INT,
completion_percentage FLOAT CHECK (completion_percentage BETWEEN 0 AND 100),
last_updated DATE,
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
) AUTO_INCREMENT = 401;

-- I created Indexex for better performance.
CREATE INDEX idx_student ON enrollments(student_id);
CREATE INDEX idx_course ON enrollments(course_id);


-- Data Insertion
INSERT INTO students (name, email) VALUES
('Alice Thomas', 'alice@example.com'),
('Brian Scott', 'brian@example.com'),
('Clara James', 'clara@example.com'),
('Dinesh Kumar', 'dinesh@example.com');

INSERT INTO courses (course_name, instructor) VALUES
('Python Basics', 'Dr. Jay'),
('Data Analysis with Pandas', 'Dr. Meera'),
('SQL for Beginners', 'Prof. Arjun'),
('Machine Learning Intro', 'Dr. Tanvi');

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(101, 201, '2025-07-01'),  
(101, 202, '2025-07-02'),  
(102, 201, '2025-07-03'),  
(103, 203, '2025-07-04'),  
(104, 204, '2025-07-05'); 

INSERT INTO progress (student_id, course_id, completion_percentage, last_updated) VALUES
(101, 201, 85, '2025-07-15'), 
(101, 202, 40, '2025-07-16'),  
(102, 201, 60, '2025-07-14'),  
(103, 203, 10, '2025-07-18'),  
(104, 204, 100, '2025-07-17');