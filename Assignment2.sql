CREATE DATABASE Instafile;
drop DATABASE Instafile;
-- Use the newly created database
USE Instafile;

DROP TABLE IF EXISTS LIKES;
DROP TABLE IF EXISTS POST;
DROP TABLE IF EXISTS USERR;

CREATE TABLE USERR (
  UserID INT,
  Email VARCHAR(19),
  Password VARCHAR(12) UNIQUE,
  Username VARCHAR(13)
);  

CREATE TABLE POST (
  PostID INT ,
  UserID INT,
  Captions TEXT,
  ImageID INT
);

CREATE TABLE LIKES (
  LikeID INT,  
  UserID INT,
  LikeDAt DATETIME
); 

-- Insert data
INSERT INTO USERR (UserID, Email, Password, Username)
VALUES (1, 'john@gmail.com', 'password123', 'johUES'),
       (2, 'alice@example.com', 'alicepass12', 'alice123'),
       (3, 'bob@example.com', 'bobpass456', 'bobby_b'),
       (4, 'carol@example.com', 'carolpass789', 'carol_c'),
       (5, 'dave@example.com', 'davepass321', 'daveD');

INSERT INTO POST (PostID, UserID, Captions, ImageID)
VALUES (1, 1, 'This is my first post!', 101),
       (2, 2, 'Check out this view!', 102),
       (3, 3, 'New shoes!', 103),
       (4, 4, 'Vacation time!', 104),
       (5, 5, 'Loving this weather!', 105);

INSERT INTO LIKES (LikeID, UserID, LikeDAt)
VALUES (1, 1, '2025-07-14 15:30:00'),
       (2, 2, '2025-07-14 16:00:00'),
       (3, 3, '2025-07-14 16:05:00'),
       (4, 4, '2025-07-14 16:10:00'),
       (5, 5, '2025-07-14 16:15:00');
       
SELECT * FROM USERR
WHERE Email LIKE '%john%';
