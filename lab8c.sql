USE AdventureWorksLT2014 
GO

WITH Sprzedaz AS (
  SELECT pc.Name AS Category, od.UnitPrice AS SalesValue
  FROM SalesLT.ProductCategory AS pc
  INNER JOIN SalesLT.Product AS p ON p.ProductCategoryID = pc.ProductCategoryID
  INNER JOIN SalesLT.SalesOrderDetail AS od ON p.ProductID = od.ProductID
)

SELECT Category, SUM(SalesValue) AS SalesValue
FROM Sprzedaz
GROUP BY Category
ORDER BY Category;