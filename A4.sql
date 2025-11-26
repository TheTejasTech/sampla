-- --------------------------------------
-- Create Database (safe re-run)
-- --------------------------------------
CREATE DATABASE IF NOT EXISTS ass4;
USE ass4;

-- --------------------------------------
-- Create Employee Table
-- --------------------------------------
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    City VARCHAR(50)
);

-- --------------------------------------
-- Insert Records
-- --------------------------------------
INSERT INTO Employee VALUES
(1, 'Prateek', 'IT', 50000, 'Pune'),
(2, 'Rohan', 'HR', 45000, 'Mumbai'),
(3, 'Sneha', 'IT', 60000, 'Pune'),
(4, 'Amit', 'Finance', 30000, 'Nashik'),
(5, 'Sheetal', 'HR', 45000, 'Pune'),
(6, 'Rahul', 'IT', 55000, 'Mumbai'),
(7, 'Neha', 'Finance', 30000, 'Solapur');

-- --------------------------------------
-- 1. Employees working in Pune or Mumbai
-- --------------------------------------
SELECT 'Employees in Pune or Mumbai:' AS '';
SELECT * FROM Employee WHERE City IN ('Pune', 'Mumbai');

-- --------------------------------------
-- 2. Employees NOT in HR or Finance
-- --------------------------------------
SELECT 'Employees NOT from HR or Finance:' AS '';
SELECT * FROM Employee WHERE Department NOT IN ('HR', 'Finance');

-- --------------------------------------
-- 3. Salary < SOME salaries in HR
-- --------------------------------------
SELECT 'Salary less than SOME HR salaries:' AS '';
SELECT * FROM Employee
WHERE Salary < SOME (SELECT Salary FROM Employee WHERE Department = 'HR');

-- --------------------------------------
-- 4. Salary >= SOME salaries in IT
-- --------------------------------------
SELECT 'Salary >= SOME IT salaries:' AS '';
SELECT * FROM Employee
WHERE Salary >= SOME (SELECT Salary FROM Employee WHERE Department = 'IT');

-- --------------------------------------
-- 5. Salary < ALL salaries in IT
-- --------------------------------------
SELECT 'Salary less than ALL IT salaries:' AS '';
SELECT * FROM Employee
WHERE Salary < ALL (SELECT Salary FROM Employee WHERE Department = 'IT');

-- --------------------------------------
-- 6. Salaries that are UNIQUE
-- --------------------------------------
SELECT 'Unique Salaries:' AS '';
SELECT Salary FROM Employee
GROUP BY Salary
HAVING COUNT(*) = 1;

-- --------------------------------------
-- 7. Salaries that are NOT UNIQUE
-- --------------------------------------
SELECT 'Repeated Salaries:' AS '';
SELECT Salary FROM Employee
GROUP BY Salary
HAVING COUNT(*) > 1;
