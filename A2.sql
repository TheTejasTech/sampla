-- Create Database (Safe Re-run)
CREATE DATABASE IF NOT EXISTS ass2;
USE ass2;

-- -----------------------------------------------
-- Create Student Table
-- -----------------------------------------------
DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Course VARCHAR(50),
    City VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15)
);

-- -----------------------------------------------
-- Insert Records
-- -----------------------------------------------
INSERT INTO Student VALUES
(1, 'Prateek Khese', 'Computer Science', 'Pune', 'prateek@gmail.com', '9876543210'),
(2, 'Rohan Patil', 'Information Technology', 'Mumbai', 'rohanp@gmail.com', '9123456789'),
(3, 'Sneha More', 'Electronics', 'Pune', 'sneha.more@gmail.com', '7896541230'),
(4, 'Amit Kulkarni', 'Mechanical', 'Nashik', 'amitk@gmail.com', '8529637410'),
(5, 'Pratiksha Shinde', 'Computer Science', 'Solapur', 'pratiksha@gmail.com', '9632587410');

-- -----------------------------------------------
-- Pattern Matching & Search Queries (DML)
-- -----------------------------------------------

SELECT '1. Name contains Pr' AS '';
SELECT * FROM Student WHERE Name LIKE '%Pr%';

SELECT '2. City starts with P' AS '';
SELECT * FROM Student WHERE City LIKE 'P%';

SELECT '3. Email ends with gmail.com' AS '';
SELECT * FROM Student WHERE Email LIKE '%gmail.com';

SELECT '4. Course contains Computer' AS '';
SELECT * FROM Student WHERE Course LIKE '%Computer%';

SELECT '5. Phone contains 963' AS '';
SELECT * FROM Student WHERE Phone LIKE '%963%';

SELECT '6. Names with 5 letters' AS '';
SELECT * FROM Student WHERE Name LIKE '_____';

SELECT '7. Name starts with S and ends with e' AS '';
SELECT * FROM Student WHERE Name LIKE 'S%e';

SELECT '8. Name contains space' AS '';
SELECT * FROM Student WHERE Name LIKE '% %';

SELECT '9. Search phrase ne in name (INSTR)' AS '';
SELECT * FROM Student WHERE INSTR(Name, 'ne') > 0;

SELECT '10. Name starting with P/S (REGEXP)' AS '';
SELECT * FROM Student WHERE Name REGEXP '^[PS]';
