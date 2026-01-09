-- Create a new database for the project
CREATE DATABASE student_performance;
USE student_performance;
-- Table: students
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(50),
    class VARCHAR(10)
);

-- Table: subjects
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50)
);

-- Table: marks
CREATE TABLE marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks_obtained INT,
    exam_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Insert students
INSERT INTO students (student_name, class)
VALUES
('Aarav', '10A'),
('Diya', '10A'),
('Rohan', '10B'),
('Mira', '10B'),
('Karan', '10A');

-- Insert subjects
INSERT INTO subjects (subject_name)
VALUES
('Math'),
('Science'),
('English'),
('Social Studies'),
('Computer');

-- Insert marks
INSERT INTO marks (student_id, subject_id, marks_obtained, exam_date)
VALUES
(1, 1, 85, '2025-03-10'),
(1, 2, 78, '2025-03-10'),
(1, 3, 92, '2025-03-10'),
(1, 4, 81, '2025-03-10'),
(1, 5, 89, '2025-03-10'),

(2, 1, 95, '2025-03-10'),
(2, 2, 88, '2025-03-10'),
(2, 3, 90, '2025-03-10'),
(2, 4, 84, '2025-03-10'),
(2, 5, 91, '2025-03-10'),

(3, 1, 72, '2025-03-10'),
(3, 2, 69, '2025-03-10'),
(3, 3, 75, '2025-03-10'),
(3, 4, 70, '2025-03-10'),
(3, 5, 80, '2025-03-10'),

(4, 1, 90, '2025-03-10'),
(4, 2, 85, '2025-03-10'),
(4, 3, 88, '2025-03-10'),
(4, 4, 91, '2025-03-10'),
(4, 5, 94, '2025-03-10'),

(5, 1, 60, '2025-03-10'),
(5, 2, 72, '2025-03-10'),
(5, 3, 65, '2025-03-10'),
(5, 4, 70, '2025-03-10'),
(5, 5, 68, '2025-03-10');

-- 1. View all students
SELECT * FROM students;

-- 2. View all subjects
SELECT * FROM subjects;

-- 3. View all marks
SELECT * FROM marks;

-- 4. Query Marks (Student-wise Detailed Report)
SELECT 
    s.student_name,
    sub.subject_name,
    m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN subjects sub ON m.subject_id = sub.subject_id
ORDER BY s.student_name;

-- 5. Identify Top Performers (Overall Average)
SELECT 
    s.student_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY s.student_id
ORDER BY average_marks DESC;

-- 6. Subject-wise Performance Trend (Average Marks per Subject)

SELECT 
    sub.subject_name,
    ROUND(AVG(m.marks_obtained), 2) AS avg_marks
FROM marks m
JOIN subjects sub ON m.subject_id = sub.subject_id
GROUP BY sub.subject_id
ORDER BY avg_marks DESC;

-- 7. Find Top Performer per Subject
SELECT 
    sub.subject_name,
    s.student_name,
    m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN subjects sub ON m.subject_id = sub.subject_id
WHERE (sub.subject_id, m.marks_obtained) IN (
    SELECT subject_id, MAX(marks_obtained)
    FROM marks
    GROUP BY subject_id
)
ORDER BY sub.subject_name;

-- 8. Class-wise Average Marks
SELECT 
    s.class,
    ROUND(AVG(m.marks_obtained), 2) AS avg_marks
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY s.class;

-- 9. Find Students Below Average (Need Improvement)
SELECT 
    s.student_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY s.student_id
HAVING average_marks < (SELECT AVG(marks_obtained) FROM marks)
ORDER BY average_marks ASC;



