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
  UserID INT unique,
  Captions TEXT,
  ImageID INT,
  FOREIGN KEY (UserID) REFERENCES USERR(UserID)
);
drop table POST;
drop table LIKES;
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
-- Adding extra likes for some users
INSERT INTO LIKES (LikeID, UserID, LikeDAt) VALUES
  (6, 1, '2025-07-15 10:00:00'),
  (7, 1, '2025-07-15 12:00:00'),
  (8, 2, '2025-07-15 11:00:00'),
  (9, 3, '2025-07-15 13:00:00'),
  (10, 3, '2025-07-15 14:00:00'),
  (11, 3, '2025-07-15 15:00:00');

select U.Password, U.Username , U.Email from USERR U right join LIKES l ON  U.Password = l.Password;

SELECT U.Username, COUNT(P.PostID) AS TotalPosts
FROM USERR U
JOIN POST P ON U.UserID = P.UserID
GROUP BY U.Username;

SELECT U.Username, COUNT(P.PostID) AS TotalPosts
FROM USERR U
JOIN POST P ON U.UserID = P.UserID
GROUP BY U.Username
HAVING COUNT(P.PostID) > 1;

SELECT U.Username, COUNT(L.LikeID) AS LikesGiven
FROM USERR U
JOIN LIKES L ON U.UserID = L.UserID
GROUP BY U.Username;

SELECT U.Username, COUNT(L.LikeID) AS TotalLikes
FROM USERR U
JOIN LIKES L ON U.UserID = L.UserID
GROUP BY U.UserID, U.Username
HAVING COUNT(L.LikeID) > (
    SELECT AVG(LikeCount)
    FROM (
        SELECT UserID, COUNT(LikeID) AS LikeCount
        FROM LIKES
        GROUP BY UserID
    ) AS AvgLikes
);

SELECT U.Username, COUNT(P.PostID) AS TotalPosts
FROM USERR U
JOIN POST P ON U.UserID = P.UserID
GROUP BY U.UserID, U.Username
HAVING COUNT(P.PostID) = (
    SELECT MAX(PostCount)
    FROM (
        SELECT UserID, COUNT(PostID) AS PostCount
        FROM POST
        GROUP BY UserID
    ) AS PostCounts
);
