--Przetwarzanie transakcyjne
--Wykorzystuj¹c SQL Server i bazê AdventureWorks rozwi¹¿ poni¿sze zadania.
--1. Napisz zapytanie, które wykorzystuje transakcjê (zaczyna j¹), a nastêpnie
--aktualizuje cenê produktu o ProductID równym 680 w tabeli Production.Product
--o 10% i nastêpnie zatwierdza transakcjê.
--2. Napisz zapytanie, które zaczyna transakcjê, usuwa produkt o ProductID równym
--707 z tabeli Production. Product, ale nastêpnie wycofuje transakcjê.
--3. Napisz zapytanie, które zaczyna transakcjê, dodaje nowy produkt do tabeli
--Production.Product, a nastêpnie zatwierdza transakcjê.
--4. Napisz zapytanie, które zaczyna transakcjê i aktualizuje StandardCost wszystkich
--produktów w tabeli Production.Product o 10%, je¿eli suma wszystkich
--StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
--powinno wycofaæ transakcjê.
--5. Napisz zapytanie SQL, które zaczyna transakcjê i próbuje dodaæ nowy produkt do
--tabeli Production.Product. Jeœli ProductNumber ju¿ istnieje w tabeli, zapytanie
--powinno wycofaæ transakcjê.
--6. Napisz zapytanie SQL, które zaczyna transakcjê i aktualizuje wartoœæ OrderQty
--dla ka¿dego zamówienia w tabeli Sales.SalesOrderDetail. Je¿eli którykolwiek z
--zamówieñ ma OrderQty równ¹ 0, zapytanie powinno wycofaæ transakcjê.
--7. Napisz zapytanie SQL, które zaczyna transakcjê i usuwa wszystkie produkty,
--których StandardCost jest wy¿szy ni¿ œredni koszt wszystkich produktów w tabeli
--Production.Product. Je¿eli liczba produktów do usuniêcia przekracza 10,
--zapytanie powinno wycofaæ transakcjê

USE AdventureWorks2014
GO

--1.
BEGIN TRANSACTION;

UPDATE Production.Product
SET ListPrice = ListPrice * 1.10
WHERE ProductID = 680;

COMMIT TRANSACTION; 

SELECT * FROM Production.Product;

--2
--BEGIN TRANSACTION;

--DELETE FROM Production.Product
--WHERE ProductID = 707;

--ROLLBACK TRANSACTION;

BEGIN TRANSACTION;

BEGIN TRY
DELETE FROM Production.Product
WHERE ProductID = 707;
	PRINT 'Produkt jest usuniêty!';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transakcja wycofana!';
END CATCH;

--3
BEGIN TRANSACTION;

INSERT INTO Production.Product
    (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, SellStartDate)
VALUES
    ('BottleOfWater', 'AR-8001', 1, 1, 'BLUE', 100, 50, 20.00, 25.00, NULL, NULL, NULL, NULL, 1, '2011-05-31 00:00:00.000');

COMMIT TRANSACTION;
--4 (z zajêæ)
BEGIN TRANSACTION
BEGIN TRY
	--Aktualizacja StandardCost o 10%
	UPDATE Production.Product
	SET StandardCost = StandardCost * 1.10;

	--Sprawdzanie, czy suma StandardCost po aktualizacji nie przekracza 50 000
	DECLARE @TotalStandardCost MONEY;
	SELECT @TotalStandardCost = SUM(StandardCost) FROM Production.Product;

	IF @TotalStandardCost <= 50000
	BEGIN
		--Jeœli suma nie przekracza 50 000, zatwierdŸ transakcjê
		COMMIT;
		PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi:' + CAST(@TotalStandardCost AS NVARCHAR(50));
	END
	ELSE
	BEGIN
		--Jeœli suma przekracza 50 000, wycofaj transakcjê
		ROLLBACK;
		PRINT 'Transakcja  wycofana. Suma StandardCost wynosi:' + CAST(@TotalStandardCost AS NVARCHAR(50));
	END
END TRY 
BEGIN CATCH
	--Jeœli wyst¹pi b³¹d, wycofaj transakcjê i wyœwietl komunikat o b³êdzie
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

--5
BEGIN TRANSACTION;

DECLARE @ProductNumber NVARCHAR(25) = 'AR-8001';
DECLARE @ProduktIstnieje INT = 0;

SELECT @ProduktIstnieje = COUNT(*) FROM Production.Product WHERE ProductNumber = @ProductNumber;

IF @ProduktIstnieje >= 1
BEGIN
    
    ROLLBACK TRANSACTION;
    PRINT 'Transakcja wycofana. Produkt o tym numerze ju¿ istnieje!';
END
ELSE
BEGIN
    
	INSERT INTO Production.Product
    (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, SellStartDate)
VALUES
    ('BottleOfWater', 'AR-8001', 1, 1, 'BLUE', 100, 50, 20.00, 25.00, NULL, NULL, NULL, NULL, 1, '2011-05-31 00:00:00.000');
    
    COMMIT TRANSACTION;
    PRINT 'Transakcja zatwierdzona. Nowy produkt jest dodany!';
END
--6
--SELECT * FROM Sales.SalesOrderDetail;

BEGIN TRANSACTION;

BEGIN TRY
	-- Aktualizacja OrderQty 
	UPDATE Sales.SalesOrderDetail
	SET OrderQty = OrderQty * 1.10;

	
	IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
	BEGIN
		
		ROLLBACK TRANSACTION;
		PRINT 'Transakcja wycofana. Conajmniej jedno z zamówieñ ma OrderQty równe 0!';
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION;
		PRINT 'Transakcja zatwierdzona. OrderQty zaktualizowane!';
	END
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;


--7
BEGIN TRANSACTION

DECLARE @SredniKoszt DECIMAL(10, 2);
DECLARE @IleDoUsuniêcia INT = 0;

SELECT @SredniKoszt = AVG(StandardCost)
FROM Production.Product;

SELECT @IleDoUsuniêcia = COUNT(*)
FROM Production.Product
WHERE StandardCost > @SredniKoszt;

IF @IleDoUsuniêcia > 10
BEGIN
    
    ROLLBACK TRANSACTION;
    PRINT 'Transakcja wycofana. Liczba produktów do usuniêcia przekracza 10!';
END
ELSE
BEGIN
    
	DELETE FROM Production.Product
    WHERE StandardCost > @SredniKoszt;
    
    COMMIT TRANSACTION;
    PRINT 'Transakcja zatwierdzona. Produkty usuniête!';
END






