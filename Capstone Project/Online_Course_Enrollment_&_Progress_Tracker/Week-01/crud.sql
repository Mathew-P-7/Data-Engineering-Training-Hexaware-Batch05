-- CRUD Operations

-- Student Insertion
INSERT INTO students(name, email)
VALUES('Mathew Peter', 'alice@gmail.com');

-- Course Insertion
INSERT INTO courses(course_name, instructor) 
VALUES('Data Engineering', 'Abdhulla Khan');

-- Enrolling student into course
INSERT INTO enrollments( student_id, course_id, enrollment_date)
VALUES(101,201, '2025-05-10');

-- Tracking progress
INSERT INTO progress(student_id, course_id, completion_percentage, last_updated )
VALUES(101,201,50,'2025-06-13');

-- Updating progress
UPDATE progress
SET completion_percentage = 85, last_updated = '2025-08-10'
WHERE student_id = 101 AND course_id = 201;

-- Deleting an enrollment
DELETE FROM enrollments
WHERE enrollment_id = 301;