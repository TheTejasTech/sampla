-- Step 1: Create Database and Table
CREATE DATABASE IF NOT EXISTS PayrollDB;
USE PayrollDB;

-- Always recreate Employee table so script is safe to re-run
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,
    department VARCHAR(30),
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2) DEFAULT 0
);

-- Step 2: Insert Sample Data
INSERT INTO Employee (emp_name, department, salary, bonus) VALUES
('Rahul Sharma', 'IT', 50000, 5000),
('Sneha Patil', 'HR', 40000, 3000),
('Amit Deshmukh', 'Finance', 60000, 6000),
('Priya Nair', 'IT', 55000, 4000);

-- -------------------------------------------------------------
-- Step 3: Create Stored Procedure to Update Bonus
-- -------------------------------------------------------------
DROP PROCEDURE IF EXISTS UpdateBonus;

DELIMITER $$
CREATE PROCEDURE UpdateBonus(
    IN dept_name VARCHAR(30),
    IN percent_increase DECIMAL(5,2)
)
BEGIN
    UPDATE Employee
    SET bonus = bonus + (salary * percent_increase / 100)
    WHERE department = dept_name
      AND emp_id > 0;   -- prevents safe update error
END $$
DELIMITER ;

-- Step 4: Test Procedure
SELECT * FROM Employee;
CALL UpdateBonus('IT', 10);
SELECT * FROM Employee;

-- -------------------------------------------------------------
-- Step 5: Create Stored Function for Annual Salary
-- -------------------------------------------------------------
DROP FUNCTION IF EXISTS AnnualSalary;

DELIMITER $$
CREATE FUNCTION AnnualSalary(empId INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE annual DECIMAL(12,2);

    SELECT (salary * 12 + bonus) INTO annual
    FROM Employee
    WHERE emp_id = empId;

    RETURN annual;
END $$
DELIMITER ;

-- Step 6: Test Function
SELECT AnnualSalary(1) AS Annual_Salary;

SELECT emp_id, emp_name, AnnualSalary(emp_id) AS Annual_Salary
FROM Employee;
-- Step 1: Create Database and Table
CREATE DATABASE IF NOT EXISTS PayrollDB;
USE PayrollDB;

-- Always recreate Employee table so script is safe to re-run
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,
    department VARCHAR(30),
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2) DEFAULT 0
);

-- Step 2: Insert Sample Data
INSERT INTO Employee (emp_name, department, salary, bonus) VALUES
('Rahul Sharma', 'IT', 50000, 5000),
('Sneha Patil', 'HR', 40000, 3000),
('Amit Deshmukh', 'Finance', 60000, 6000),
('Priya Nair', 'IT', 55000, 4000);

-- -------------------------------------------------------------
-- Step 3: Create Stored Procedure to Update Bonus
-- -------------------------------------------------------------
DROP PROCEDURE IF EXISTS UpdateBonus;

DELIMITER $$
CREATE PROCEDURE UpdateBonus(
    IN dept_name VARCHAR(30),
    IN percent_increase DECIMAL(5,2)
)
BEGIN
    UPDATE Employee
    SET bonus = bonus + (salary * percent_increase / 100)
    WHERE department = dept_name
      AND emp_id > 0;   -- prevents safe update error
END $$
DELIMITER ;

-- Step 4: Test Procedure
SELECT * FROM Employee;
CALL UpdateBonus('IT', 10);
SELECT * FROM Employee;

-- -------------------------------------------------------------
-- Step 5: Create Stored Function for Annual Salary
-- -------------------------------------------------------------
DROP FUNCTION IF EXISTS AnnualSalary;

DELIMITER $$
CREATE FUNCTION AnnualSalary(empId INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE annual DECIMAL(12,2);

    SELECT (salary * 12 + bonus) INTO annual
    FROM Employee
    WHERE emp_id = empId;

    RETURN annual;
END $$
DELIMITER ;

-- Step 6: Test Function
SELECT AnnualSalary(1) AS Annual_Salary;

SELECT emp_id, emp_name, AnnualSalary(emp_id) AS Annual_Salary
FROM Employee;
