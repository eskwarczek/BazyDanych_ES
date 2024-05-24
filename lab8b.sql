USE AdventureWorksLT2014
GO

WITH Revenues AS (SELECT c.CompanyName AS CompanyContact, h.TotalDue AS Revenue
  FROM SalesLT.Customer AS c
  INNER JOIN SalesLT.SalesOrderHeader AS h ON c.CustomerID = h.CustomerID
)

SELECT * FROM Revenues
ORDER BY CompanyContact;