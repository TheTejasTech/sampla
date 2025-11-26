-- First, drop the database if it exists (safely clears everything)
create database Instafile;
DROP DATABASE IF EXISTS Instafile;

-- Then create a fresh database
CREATE DATABASE Instafile;

-- Use the newly created database
USE Instafile;

-- Drop tables if they still exist (optional redundancy for safety)
DROP TABLE IF EXISTS LIKES;
DROP TABLE IF EXISTS POST;
DROP TABLE IF EXISTS USERR;

-- Create USERR table
CREATE TABLE USERR (
  UserID INT PRIMARY KEY,
  Email VARCHAR(255) UNIQUE,
  Password VARCHAR(12) UNIQUE,
  Username VARCHAR(50) UNIQUE
);

-- Create POST table
CREATE TABLE POST (
  PostID INT PRIMARY KEY,
  UserID INT,
  Captions TEXT,
  ImageID INT,
  FOREIGN KEY (UserID) REFERENCES USERR(UserID)
);

-- Create LIKES table
CREATE TABLE LIKES (
  LikeID INT UNIQUE,
  UserID INT,
  LikeDAt DATETIME,
  FOREIGN KEY (UserID) REFERENCES USERR(UserID)
);

-- Insert data into USERR
INSERT INTO USERR (UserID, Email, Password, Username)
VALUES 
  (1, 'john@gmail.com', 'password123', 'johUES'),
  (2, 'alice@example.com', 'alicepass12', 'alice123'),
  (3, 'bob@example.com', 'bobpass456', 'bobby_b'),
  (4, 'carol@example.com', 'carolpass789', 'carol_c'),
  (5, 'dave@example.com', 'davepass321', 'daveD');

-- Insert data into POST
INSERT INTO POST (PostID, UserID, Captions, ImageID)
VALUES 
  (1, 1, 'This is my first post!', 101),
  (2, 2, 'Check out this view!', 102),
  (3, 3, 'New shoes!', 103),
  (4, 4, 'Vacation time!', 104),
  (5, 5, 'Loving this weather!', 105);

-- Insert data into LIKES
INSERT INTO LIKES (LikeID, UserID, LikeDAt)
VALUES 
  (1, 1, '2025-07-14 15:30:00'),
  (2, 2, '2025-07-14 16:00:00'),
  (3, 3, '2025-07-14 16:05:00'),
  (4, 4, '2025-07-14 16:10:00'),
  (5, 5, '2025-07-14 16:15:00');

----------------------------------------------------------
-- DCL SECTION: MySQL User and Access Control
----------------------------------------------------------

-- Create users (if not exist to avoid error)
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' IDENTIFIED BY 'adminpass';
CREATE USER IF NOT EXISTS 'user_read_write'@'localhost' IDENTIFIED BY 'rwpass';
CREATE USER IF NOT EXISTS 'user_read_only'@'localhost' IDENTIFIED BY 'ropass';

-- Grant ALL privileges to admin user
GRANT ALL PRIVILEGES ON Instafile.* TO 'admin_user'@'localhost';

-- Grant SELECT and INSERT to read-write user
GRANT SELECT, INSERT ON Instafile.USERR TO 'user_read_write'@'localhost';
GRANT SELECT, INSERT ON Instafile.POST TO 'user_read_write'@'localhost';
GRANT SELECT, INSERT ON Instafile.LIKES TO 'user_read_write'@'localhost';

-- Grant only SELECT to read-only user
GRANT SELECT ON Instafile.USERR TO 'user_read_only'@'localhost';
GRANT SELECT ON Instafile.POST TO 'user_read_only'@'localhost';
GRANT SELECT ON Instafile.LIKES TO 'user_read_only'@'localhost';

-- Revoke INSERT privilege from read-write user on LIKES table
REVOKE INSERT ON Instafile.LIKES FROM 'user_read_write'@'localhost';

-- Revoke SELECT privileges from read-only user
REVOKE SELECT ON Instafile.USERR FROM 'user_read_only'@'localhost';
REVOKE SELECT ON Instafile.POST FROM 'user_read_only'@'localhost';
REVOKE SELECT ON Instafile.LIKES FROM 'user_read_only'@'localhost';

-- Apply all privilege changes
FLUSH PRIVILEGES;
-- View all users
SELECT * FROM USERR;

-- View all posts
SELECT * FROM POST;

-- View all likes
SELECT * FROM LIKES;
SHOW GRANTS FOR 'user_read_only'@'localhost';
SELECT * FROM information_schema.SCHEMA_PRIVILEGES;
SELECT * FROM information_schema.TABLE_PRIVILEGES;

-----------------------------------------------------------

