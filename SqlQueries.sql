WITH all_orders as (
SELECT
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM Orders_2023

UNION ALL
SELECT
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM Orders_2024

UNION ALL
SELECT
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
FROM Orders_2025
)

SELECT 
a.OrderID,
a.CustomerID,
c.Region,
a.ProductID,
a.OrderDate,
DATEADD(WEEK,DATEDIFF(week,0,a.OrderDate),0) as Week_Date,
c.CustomerJoinDate,
a.Quantity,
a.Revenue,
CASE WHEN a.Revenue is null THEN p.Price * a.Quantity else a.Revenue END AS Cleaned_Revenue,
a.Revenue - a.COGS AS Profit,
a.COGS,
p.ProductName,
p.ProductCategory,
p.Base_Cost 
FROM all_orders a
LEFT JOIN customers c
ON a.CustomerID = c.CustomerID 
LEFT JOIN products p
ON p.ProductID = a.ProductID
WHERE a.CustomerID IS NOT NULL