-- Create Tables
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    hod VARCHAR(50)
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

---------------------------------------------------------------
-- Create Simple View (Updatable View)
---------------------------------------------------------------
CREATE VIEW student_contact_view AS
SELECT student_id, name, email
FROM Student;

SELECT * FROM student_contact_view;

-- Update Using View (updates base table)
UPDATE student_contact_view
SET email = 'newmail@example.com'
WHERE student_id = 101;

---------------------------------------------------------------
-- Create View With JOIN
---------------------------------------------------------------
CREATE VIEW student_department_view AS
SELECT S.student_id, S.name, D.dept_name
FROM Student S
JOIN Department D ON S.department_id = D.department_id;

---------------------------------------------------------------
-- Create Restricted View (With CHECK OPTION)
---------------------------------------------------------------
CREATE VIEW cs_students_view AS
SELECT * FROM Student
WHERE department_id = 1
WITH CHECK OPTION;

-- Allowed Update (inside filter condition)
UPDATE cs_students_view
SET name = 'Aditya'
WHERE student_id = 101;

-- Not Allowed Update (violates WITH CHECK OPTION rule)
UPDATE cs_students_view
SET department_id = 2
WHERE student_id = 101;

---------------------------------------------------------------
-- Multi-table Join View (Non-updatable)
---------------------------------------------------------------
CREATE VIEW dept_course_view AS
SELECT D.department_id, D.dept_name, C.course_name, C.credits
FROM Department D
JOIN Course C USING(department_id);

SELECT * FROM dept_course_view;

-- Not allowed to update (non-updatable, multi-table view)
UPDATE dept_course_view
SET credits = 5
WHERE course_name = 'DBMS';

---------------------------------------------------------------
-- Create Aggregate View (Not Updatable)
---------------------------------------------------------------
CREATE VIEW dept_student_count AS
SELECT department_id, COUNT(*) AS total_students
FROM Student
GROUP BY department_id;

-- Not allowed
UPDATE dept_student_count
SET total_students = 10
WHERE department_id = 2;

-- Drop view
DROP VIEW student_contact_view;
