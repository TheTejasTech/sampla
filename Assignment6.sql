-- Create the Department database and switch to it
CREATE DATABASE IF NOT EXISTS Department;
USE Department;

-- Drop tables if they exist to avoid errors
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

-- Create department table
CREATE TABLE department (
    deptId INT PRIMARY KEY,
    deptName VARCHAR(50)
);

-- Insert data into department table
INSERT INTO department VALUES
(1, 'CS'),
(2, 'IT'),
(3, 'Mech'),
(4, 'Entc'),
(5, 'Civil');

-- Create employee table with foreign key reference to department
CREATE TABLE employee (
    empId INT PRIMARY KEY,
    empName VARCHAR(20),
    salary DECIMAL(10,2),
    deptId INT,
    FOREIGN KEY (deptId) REFERENCES department(deptId)
);

-- Insert data into employee table
INSERT INTO employee VALUES
(101, 'alex', 59000.00, 1),
(102, 'john', 86000.00, 2),
(103, 'polito', 72000.00, 3),
(104, 'lucrecia', 95000.00, 4),
(105, 'guzman', 65000.00, 5),
(106, 'stephen', 45000.00, 1),
(107, 'antony', 53000.00, 2),
(108, 'ava', 61000.00, 3),
(109, 'amee', 98000.00, 4),
(110, 'samuel', 67000.00, 5);

-- Create audit table to track salary changes
CREATE TABLE IF NOT EXISTS EmployeeSalaryAudit (
    auditId INT AUTO_INCREMENT PRIMARY KEY,
    empId INT,
    oldSalary DECIMAL(10,2),
    newSalary DECIMAL(10,2),
    changeDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Set delimiter for trigger creation
DELIMITER $$

-- Create row-level AFTER UPDATE trigger on employee table
CREATE TRIGGER trg_EmployeeSalaryChange
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO EmployeeSalaryAudit(empId, oldSalary, newSalary)
        VALUES (OLD.empId, OLD.salary, NEW.salary);
    END IF;
END$$

-- Reset delimiter back to semicolon
DELIMITER ;

CREATE OR REPLACE VIEW emp_view AS
SELECT empId, empName, salary, deptId
FROM employee;

