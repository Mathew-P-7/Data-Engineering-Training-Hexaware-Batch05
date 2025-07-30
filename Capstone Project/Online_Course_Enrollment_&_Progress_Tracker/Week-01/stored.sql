DELIMITER //

CREATE PROCEDURE GetStudentCompletion(IN studentId INT)
BEGIN
    SELECT 
        s.name AS student_name,
        c.course_name,
        p.completion_percentage
    FROM Students s
    JOIN Enrollments e ON s.student_id = e.student_id
    JOIN Courses c ON e.course_id = c.course_id
    JOIN Progress p ON s.student_id = p.student_id AND c.course_id = p.course_id
    WHERE s.student_id = studentId;
END //

DELIMITER ;


