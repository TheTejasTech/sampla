-- Create Database
CREATE DATABASE IF NOT EXISTS Library;
USE Library;

-- -------------------------------------------
-- Create Tables
-- -------------------------------------------
DROP TABLE IF EXISTS Issue;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Member;

-- Create Member Table
CREATE TABLE Member (
   MemberID INT PRIMARY KEY,
   Name VARCHAR(50),
   Phone VARCHAR(15),
   Email VARCHAR(50)
);

-- Create Book Table
CREATE TABLE Book (
   BookID INT PRIMARY KEY,
   Title VARCHAR(100),
   Author VARCHAR(50),
   Quantity INT
);

-- Create Issue Table (Relationship Table)
CREATE TABLE Issue (
   IssueID INT PRIMARY KEY,
   MemberID INT,
   BookID INT,
   IssueDate DATE,
   ReturnDate DATE,
   FOREIGN KEY(MemberID) REFERENCES Member(MemberID),
   FOREIGN KEY(BookID) REFERENCES Book(BookID)
);

-- -------------------------------------------
-- Insert Sample Records (DML)
-- -------------------------------------------
INSERT INTO Member VALUES (1, 'Prateek', '9876543210', 'prateek@mail.com');
INSERT INTO Book VALUES (101, 'DBMS Concepts', 'Korth', 5);
INSERT INTO Issue VALUES (5001, 1, 101, '2025-11-20', '2025-11-30');

-- -------------------------------------------
-- DCL Commands (User Permissions)
-- -------------------------------------------

-- Create User
DROP USER IF EXISTS 'librarian';
CREATE USER 'librarian' IDENTIFIED BY 'lib@123';

-- Grant Permissions
GRANT SELECT, INSERT, UPDATE ON Library.* TO 'librarian';

-- Revoke Permission
REVOKE UPDATE ON Library.* FROM 'librarian';
