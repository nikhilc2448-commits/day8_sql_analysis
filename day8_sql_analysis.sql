CREATE DATABASE retail_db;

USE retail_db;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE,
    FOREIGN KEY(CustomerID)
    REFERENCES Customers(CustomerID)
);


INSERT INTO Customers VALUES
(1,'Alice','Bangalore'),
(2,'Bob','Mysore'),
(3,'Charlie','Hubli'),
(4,'David','Belgaum'),
(5,'Eva','Mangalore');


INSERT INTO Sales VALUES
(101,1,'Laptop','Electronics',2,50000,'2025-01-10'),
(102,2,'Phone','Electronics',1,30000,'2025-01-15'),
(103,1,'Chair','Furniture',4,2500,'2025-02-01'),
(104,3,'Table','Furniture',2,7000,'2025-02-05'),
(105,4,'Headphones','Electronics',3,2000,'2025-02-10'),
(106,5,'Keyboard','Electronics',5,1500,'2025-03-01'),
(107,2,'Monitor','Electronics',2,12000,'2025-03-15'),
(108,3,'Sofa','Furniture',1,25000,'2025-03-18'),
(109,4,'Mouse','Electronics',6,800,'2025-04-01'),
(110,5,'Cupboard','Furniture',1,18000,'2025-04-10');

SELECT *
FROM Sales;

SELECT *
FROM Sales
ORDER BY Price DESC;

SELECT *
FROM Sales
ORDER BY Price DESC
LIMIT 5;

SELECT
Category,
SUM(Quantity*Price) AS TotalSales
FROM Sales
GROUP BY Category;

SELECT
AVG(Price) AS AveragePrice
FROM Sales;

SELECT
CustomerID,
SUM(Quantity*Price) AS TotalSpent
FROM Sales
GROUP BY CustomerID
HAVING TotalSpent>20000;

SELECT
Customers.CustomerName,
Sales.Product,
Sales.Price
FROM Customers
INNER JOIN Sales
ON Customers.CustomerID=Sales.CustomerID;

SELECT
Product,
Price,

CASE
WHEN Price>=30000 THEN 'Premium'
WHEN Price>=10000 THEN 'Medium'
ELSE 'Budget'
END AS ProductCategory

FROM Sales;

SELECT *
FROM Sales
WHERE Price>(
SELECT AVG(Price)
FROM Sales
);

SELECT Product,Price
FROM Sales
WHERE Price>5000;

SELECT *
FROM Sales
ORDER BY Quantity DESC;

SELECT COUNT(*) AS TotalOrders
FROM Sales;

SELECT SUM(Quantity*Price)
FROM Sales;

SELECT Category,
AVG(Price)
FROM Sales
GROUP BY Category;

SELECT
CustomerName,
Product
FROM Customers
JOIN Sales
ON Customers.CustomerID=Sales.CustomerID;

SELECT
Category,
SUM(Quantity)
FROM Sales
GROUP BY Category
HAVING SUM(Quantity)>5;

SELECT *
FROM Sales
WHERE Quantity>(
SELECT AVG(Quantity)
FROM Sales
);

-- --------------------------------
-- Insights
-- --------------------------------

-- 1. Electronics generated the highest total sales.
-- 2. Alice is one of the highest spending customers.
-- 3. Premium products contribute most revenue.
-- 4. Furniture has fewer sales but higher average prices.
-- 5. Several products are priced above the average, indicating premium offerings.