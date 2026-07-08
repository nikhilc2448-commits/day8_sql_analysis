-- Day 8 - SQL for Data Analysis

-- Create Database

CREATE DATABASE RetailDB;
USE RetailDB;

-- Create Tables


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- Insert Sample Data


INSERT INTO Customers VALUES
(1,'Ravi','Bangalore'),
(2,'Sneha','Mysore'),
(3,'Amit','Delhi'),
(4,'Priya','Mumbai'),
(5,'Rahul','Pune'),
(6,'Neha','Hyderabad'),
(7,'Kiran','Chennai'),
(8,'Anjali','Kolkata'),
(9,'Arjun','Goa'),
(10,'Meena','Bangalore');

INSERT INTO Orders VALUES
(101,1,'Laptop','Electronics',1,65000,'2026-01-10'),
(102,2,'Mobile','Electronics',2,25000,'2026-01-15'),
(103,3,'Chair','Furniture',4,3000,'2026-02-01'),
(104,4,'Table','Furniture',2,8000,'2026-02-10'),
(105,5,'Headphones','Electronics',3,2000,'2026-02-15'),
(106,1,'Monitor','Electronics',2,12000,'2026-03-01'),
(107,6,'Keyboard','Accessories',5,1500,'2026-03-05'),
(108,7,'Mouse','Accessories',6,800,'2026-03-08'),
(109,8,'Printer','Electronics',1,15000,'2026-03-12'),
(110,9,'Sofa','Furniture',1,35000,'2026-03-15'),
(111,10,'Speaker','Electronics',2,4500,'2026-03-20'),
(112,5,'Smart Watch','Electronics',1,12000,'2026-03-22');


-- Main Task Queries


-- Query 1: Display all customers
SELECT * FROM Customers;

-- Query 2: Find customers from Bangalore
SELECT CustomerName, City
FROM Customers
WHERE City = 'Bangalore';

-- Query 3: Show top 5 highest priced orders
SELECT *
FROM Orders
ORDER BY Price DESC
LIMIT 5;

-- Query 4: Find category-wise total sales
SELECT
    Category,
    SUM(Price * Quantity) AS TotalSales
FROM Orders
GROUP BY Category;

-- Query 5: Show categories with total sales greater than 30000
SELECT
    Category,
    SUM(Price * Quantity) AS TotalSales
FROM Orders
GROUP BY Category
HAVING SUM(Price * Quantity) > 30000;

-- Query 6: Find total purchase made by each customer
SELECT
    c.CustomerName,
    SUM(o.Price * o.Quantity) AS TotalPurchase
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalPurchase DESC;

-- Query 7: Show monthly sales
SELECT
    MONTH(OrderDate) AS Month,
    SUM(Price * Quantity) AS MonthlySales
FROM Orders
GROUP BY MONTH(OrderDate);

-- Query 8: Categorize products using CASE
SELECT
    Product,
    Price,
    CASE
        WHEN Price >= 30000 THEN 'Premium'
        WHEN Price >= 10000 THEN 'Standard'
        ELSE 'Budget'
    END AS ProductCategory
FROM Orders;

-- Query 9: Find orders above average price
SELECT *
FROM Orders
WHERE Price >
(
    SELECT AVG(Price)
    FROM Orders
);

-- Query 10: Display customer and order details
SELECT
    c.CustomerName,
    c.City,
    o.Product,
    o.Category,
    o.Quantity,
    o.Price
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;


-- Supporting Exercises


-- Exercise 1: Select specific columns with WHERE
SELECT CustomerName, City
FROM Customers
WHERE City = 'Bangalore';

-- Exercise 2: Sort results and limit to top 5
SELECT Product, Price
FROM Orders
ORDER BY Price DESC
LIMIT 5;

-- Exercise 3: COUNT, SUM and AVG with GROUP BY
SELECT
    Category,
    COUNT(*) AS TotalOrders,
    SUM(Price * Quantity) AS TotalSales,
    AVG(Price) AS AveragePrice
FROM Orders
GROUP BY Category;

-- Exercise 4: INNER JOIN
SELECT
    c.CustomerName,
    o.Product,
    o.Price
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- LEFT JOIN
SELECT
    c.CustomerName,
    o.Product,
    o.Price
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- RIGHT JOIN
SELECT
    c.CustomerName,
    o.Product,
    o.Price
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- Exercise 5: HAVING clause
SELECT
    Category,
    SUM(Price * Quantity) AS TotalSales
FROM Orders
GROUP BY Category
HAVING SUM(Price * Quantity) > 30000;

-- Exercise 6: Subquery
SELECT *
FROM Orders
WHERE Price >
(
    SELECT AVG(Price)
    FROM Orders
);


-- Additional Practice


-- AND operator
SELECT *
FROM Orders
WHERE Category = 'Electronics'
AND Price > 10000;

-- OR operator
SELECT *
FROM Customers
WHERE City = 'Delhi'
OR City = 'Mumbai';

-- IN operator
SELECT *
FROM Customers
WHERE City IN ('Bangalore','Pune','Goa');

-- BETWEEN operator
SELECT *
FROM Orders
WHERE Price BETWEEN 5000 AND 30000;

-- LIKE operator
SELECT *
FROM Customers
WHERE CustomerName LIKE 'R%';

-- MIN and MAX
SELECT
    MIN(Price) AS LowestPrice,
    MAX(Price) AS HighestPrice
FROM Orders;

-- Alias example
SELECT
    c.CustomerName AS Customer,
    o.Product AS ProductName,
    o.Price AS Amount
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- INSIGHTS SUMMARY

-- 1. Electronics category generated the highest total sales.
-- 2. Ravi is the top customer based on total purchase amount.
-- 3. March recorded the highest monthly sales.
-- 4. Premium products contributed the highest revenue.
-- 5. Categories with higher sales can be prioritized for future promotions.
