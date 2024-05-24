USE AdventureWorks2014 
GO

WITH EmployeeInfo AS ( --inicjacja CTE
  SELECT e.BusinessEntityID, p.FirstName, p.LastName, pay.Rate
  FROM HumanResources.EmployeePayHistory AS pay
  INNER JOIN HumanResources.Employee AS e ON pay.BusinessEntityID = e.BusinessEntityID
  INNER JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
)
SELECT *
INTO TempEmployeeInfo
FROM EmployeeInfo;

SELECT * FROM TempEmployeeInfo;