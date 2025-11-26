-- ---------------------------------------------
-- 1. CREATE NEW DATABASE
-- ---------------------------------------------
CREATE DATABASE IF NOT EXISTS student_course_db;
USE student_course_db;

-- ---------------------------------------------
-- 2. DROP OLD TABLES (SAFE RE-RUN)
-- ---------------------------------------------
DROP TABLE IF EXISTS Audit;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;

-- ---------------------------------------------
-- 3. CREATE TABLES
-- ---------------------------------------------
CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50),
    credits INT
);

-- Audit table for trigger logs
CREATE TABLE Audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    action_type VARCHAR(20),
    table_name VARCHAR(20),
    old_data TEXT,
    new_data TEXT,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------
-- 4. DROP OLD TRIGGERS (IF ANY)
-- ---------------------------------------------
DROP TRIGGER IF EXISTS trg_student_insert;
DROP TRIGGER IF EXISTS trg_student_update;
DROP TRIGGER IF EXISTS trg_student_delete;
DROP TRIGGER IF EXISTS trg_course_insert_stmt;

-- ---------------------------------------------
-- 5. ROW-LEVEL TRIGGERS
-- ---------------------------------------------
DELIMITER $$

-- 5.1 INSERT TRIGGER
CREATE TRIGGER trg_student_insert
AFTER INSERT ON Student
FOR EACH ROW
BEGIN
    INSERT INTO Audit(action_type, table_name, new_data)
    VALUES (
        'INSERT',
        'Student',
        CONCAT('ID=', NEW.student_id,
               ', Name=', NEW.name,
               ', Dept=', NEW.department)
    );
END$$

-- 5.2 UPDATE TRIGGER
CREATE TRIGGER trg_student_update
AFTER UPDATE ON Student
FOR EACH ROW
BEGIN
    INSERT INTO Audit(action_type, table_name, old_data, new_data)
    VALUES (
        'UPDATE',
        'Student',
        CONCAT('Old ID=', OLD.student_id,
               ', Old Name=', OLD.name,
               ', Old Dept=', OLD.department),
        CONCAT('New ID=', NEW.student_id,
               ', New Name=', NEW.name,
               ', New Dept=', NEW.department)
    );
END$$

-- 5.3 DELETE TRIGGER
CREATE TRIGGER trg_student_delete
AFTER DELETE ON Student
FOR EACH ROW
BEGIN
    INSERT INTO Audit(action_type, table_name, old_data)
    VALUES (
        'DELETE',
        'Student',
        CONCAT('ID=', OLD.student_id,
               ', Name=', OLD.name,
               ', Dept=', OLD.department)
    );
END$$

-- ---------------------------------------------
-- 6. "STATEMENT-LIKE" TRIGGER FOR COURSE
-- ---------------------------------------------
CREATE TRIGGER trg_course_insert_stmt
AFTER INSERT ON Course
FOR EACH ROW
BEGIN
    INSERT INTO Audit(action_type, table_name, new_data)
    VALUES ('STATEMENT_INSERT', 'Course', 'Row inserted in Course');
END$$

DELIMITER ;

-- ---------------------------------------------
-- 7. INSERT SAMPLE STUDENT DATA (FIRES STUDENT INSERT TRIGGER)
-- ---------------------------------------------
INSERT INTO Student(name, department) VALUES
('Aditya', 'IT'),
('Rohan', 'Computer'),
('Sneha', 'AIML'),
('Pratiksha', 'ENTC'),
('Amit', 'Mechanical');

-- ---------------------------------------------
-- 8. TEST UPDATE TRIGGER
-- ---------------------------------------------
UPDATE Student
SET department = 'AI & DS'
WHERE student_id = 3;

UPDATE Student
SET name = 'Rohan Patil'
WHERE student_id = 2;

-- ---------------------------------------------
-- 9. TEST DELETE TRIGGER
-- ---------------------------------------------
DELETE FROM Student WHERE student_id = 5;
DELETE FROM Student WHERE student_id = 4;

-- ---------------------------------------------
-- 10. INSERT COURSE DATA (FIRES COURSE TRIGGER)
-- ---------------------------------------------
INSERT INTO Course(course_name, credits) VALUES
('DBMS', 4),
('Operating Systems', 3),
('Computer Networks', 4),
('Machine Learning', 3),
('Java Programming', 4);

-- ---------------------------------------------
-- 11. VIEW AUDIT LOGS
-- ---------------------------------------------
SELECT * FROM Audit;
