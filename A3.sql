-- ---------------------------------------------
-- Create Database (Safe Re-run)
-- ---------------------------------------------
CREATE DATABASE IF NOT EXISTS ass3;
USE ass3;

-- ---------------------------------------------
-- Create Sales Table
-- ---------------------------------------------
DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT,
    Price INT,
    City VARCHAR(50)
);

-- ---------------------------------------------
-- Insert Sample Data
-- ---------------------------------------------
INSERT INTO Sales VALUES
(1, 'Prateek', 'TV', 50, 14999, 'Pune'),
(2, 'Sneha', 'Mixer', 20, 6999, 'Mumbai'),
(3, 'Neha', 'Headphone', 15, 999, 'Nashik'),
(4, 'Amit', 'Watch', 13, 699, 'Pune'),
(5, 'Sumit', 'Oven', 14, 15999, 'Pune'),
(6, 'Rohan', 'Mobile', 25, 16000, 'Mumbai'),
(7, 'Meera', 'Laptop', 15, 52000, 'Delhi');

-- ---------------------------------------------
-- Aggregate Function Queries
-- ---------------------------------------------
SELECT COUNT(*) AS TotalSales FROM Sales;
SELECT SUM(Quantity) AS TotalQuantity FROM Sales;
SELECT AVG(Price) AS AveragePrice FROM Sales;
SELECT MAX(Price) AS HighestPrice FROM Sales;
SELECT MIN(Price) AS LowestPrice FROM Sales;

-- ---------------------------------------------
-- GROUP BY Queries
-- ---------------------------------------------
SELECT City, COUNT(*) AS Orders
FROM Sales
GROUP BY City;

SELECT Product, SUM(Price) AS TotalRevenue
FROM Sales
GROUP BY Product;

-- ---------------------------------------------
-- HAVING Clause
-- ---------------------------------------------
SELECT Product, SUM(Price) AS TotalRevenue
FROM Sales
GROUP BY Product
HAVING SUM(Price) > 50000;

SELECT City, COUNT(*) AS Orders
FROM Sales
GROUP BY City
HAVING COUNT(*) > 2;

-- ---------------------------------------------
-- Nested Query (Subquery)
-- ---------------------------------------------
SELECT * FROM Sales
WHERE Price > (SELECT AVG(Price) FROM Sales);

