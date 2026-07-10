/*----------------------------------------------------------
Query 1
Find the Top 5 Customers by Total Sales
Concepts:
JOIN + GROUP BY + ORDER BY + LIMIT
----------------------------------------------------------*/

SELECT
    c.CustomerID,
    c.CustomerName,
    ROUND(SUM(o.Sales),2) AS TotalSales
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalSales DESC
LIMIT 5;



/*----------------------------------------------------------
Query 2
Find Customers Who Placed More Than 5 Orders
Concepts:
GROUP BY + HAVING
----------------------------------------------------------*/

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 5
ORDER BY TotalOrders DESC;



/*----------------------------------------------------------
Query 3
Find the Region with the Highest Average Order Profit
Concepts:
JOIN + GROUP BY
----------------------------------------------------------*/

SELECT
    c.Region,
    ROUND(AVG(o.Profit),2) AS AverageProfit
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.Region
ORDER BY AverageProfit DESC
LIMIT 1;



/*----------------------------------------------------------
Query 4
List Orders Having Sales Above Overall Average
Concept:
Subquery
----------------------------------------------------------*/

SELECT
    OrderID,
    CustomerID,
    Sales
FROM Orders
WHERE Sales >
(
    SELECT AVG(Sales)
    FROM Orders
)
ORDER BY Sales DESC;



/*----------------------------------------------------------
Query 5
Categorize Orders Using CASE WHEN
Concept:
CASE WHEN
----------------------------------------------------------*/

SELECT
    OrderID,
    Sales,

    CASE
        WHEN Sales > 500 THEN 'High Value'
        WHEN Sales BETWEEN 100 AND 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS OrderCategory

FROM Orders;



/*----------------------------------------------------------
Query 6
Find the Most Popular Category in Each Region
Concepts:
JOIN + GROUP BY + ROW_NUMBER()
----------------------------------------------------------*/

WITH CategoryRank AS
(
SELECT

    c.Region,
    o.Category,
    COUNT(*) AS TotalOrders,

    ROW_NUMBER() OVER
    (
        PARTITION BY c.Region
        ORDER BY COUNT(*) DESC
    ) AS RowNum

FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID

GROUP BY
c.Region,
o.Category
)

SELECT
    Region,
    Category,
    TotalOrders
FROM CategoryRank
WHERE RowNum = 1;



/*----------------------------------------------------------
Query 7
Find Customers Who Never Placed an Order
Concepts:
LEFT JOIN + IS NULL
----------------------------------------------------------*/

SELECT
    c.CustomerID,
    c.CustomerName
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;



/*----------------------------------------------------------
Query 8
Calculate Customer Profit and Rank Customers
Concept:
RANK()
----------------------------------------------------------*/

SELECT

    c.CustomerID,
    c.CustomerName,

    ROUND(SUM(o.Profit),2) AS TotalProfit,

    RANK() OVER
    (
        ORDER BY SUM(o.Profit) DESC
    ) AS ProfitRank

FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID

GROUP BY
c.CustomerID,
c.CustomerName;



/*----------------------------------------------------------
Query 9
Find the Month with Highest Total Sales
Concepts:
MONTHNAME + GROUP BY
----------------------------------------------------------*/

SELECT

    MONTHNAME(OrderDate) AS Month,

    ROUND(SUM(Sales),2) AS TotalSales

FROM Orders

GROUP BY
MONTH(OrderDate),
MONTHNAME(OrderDate)

ORDER BY TotalSales DESC

LIMIT 1;



/*----------------------------------------------------------
Query 10
Use CTE to Calculate Customer Profit
Display Customers Above Profit Threshold
Concept:
WITH (CTE)
----------------------------------------------------------*/

WITH CustomerProfit AS
(
SELECT

    c.CustomerID,
    c.CustomerName,

    SUM(o.Profit) AS TotalProfit

FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID

GROUP BY
c.CustomerID,
c.CustomerName
)

SELECT
    CustomerID,
    CustomerName,
    ROUND(TotalProfit,2) AS TotalProfit
FROM CustomerProfit
WHERE TotalProfit > 500
ORDER BY TotalProfit DESC;