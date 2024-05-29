--Przetwarzanie transakcyjne
--Wykorzystuj�c SQL Server i baz� AdventureWorks rozwi�� poni�sze zadania.
--1. Napisz zapytanie, kt�re wykorzystuje transakcj� (zaczyna j�), a nast�pnie
--aktualizuje cen� produktu o ProductID r�wnym 680 w tabeli Production.Product
--o 10% i nast�pnie zatwierdza transakcj�.
--2. Napisz zapytanie, kt�re zaczyna transakcj�, usuwa produkt o ProductID r�wnym
--707 z tabeli Production. Product, ale nast�pnie wycofuje transakcj�.
--3. Napisz zapytanie, kt�re zaczyna transakcj�, dodaje nowy produkt do tabeli
--Production.Product, a nast�pnie zatwierdza transakcj�.
--4. Napisz zapytanie, kt�re zaczyna transakcj� i aktualizuje StandardCost wszystkich
--produkt�w w tabeli Production.Product o 10%, je�eli suma wszystkich
--StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
--powinno wycofa� transakcj�.
--5. Napisz zapytanie SQL, kt�re zaczyna transakcj� i pr�buje doda� nowy produkt do
--tabeli Production.Product. Je�li ProductNumber ju� istnieje w tabeli, zapytanie
--powinno wycofa� transakcj�.
--6. Napisz zapytanie SQL, kt�re zaczyna transakcj� i aktualizuje warto�� OrderQty
--dla ka�dego zam�wienia w tabeli Sales.SalesOrderDetail. Je�eli kt�rykolwiek z
--zam�wie� ma OrderQty r�wn� 0, zapytanie powinno wycofa� transakcj�.
--7. Napisz zapytanie SQL, kt�re zaczyna transakcj� i usuwa wszystkie produkty,
--kt�rych StandardCost jest wy�szy ni� �redni koszt wszystkich produkt�w w tabeli
--Production.Product. Je�eli liczba produkt�w do usuni�cia przekracza 10,
--zapytanie powinno wycofa� transakcj�

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
	PRINT 'Produkt jest usuni�ty!';
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
--4 (z zaj��)
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
		--Je�li suma nie przekracza 50 000, zatwierd� transakcj�
		COMMIT;
		PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi:' + CAST(@TotalStandardCost AS NVARCHAR(50));
	END
	ELSE
	BEGIN
		--Je�li suma przekracza 50 000, wycofaj transakcj�
		ROLLBACK;
		PRINT 'Transakcja  wycofana. Suma StandardCost wynosi:' + CAST(@TotalStandardCost AS NVARCHAR(50));
	END
END TRY 
BEGIN CATCH
	--Je�li wyst�pi b��d, wycofaj transakcj� i wy�wietl komunikat o b��dzie
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
    PRINT 'Transakcja wycofana. Produkt o tym numerze ju� istnieje!';
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
		PRINT 'Transakcja wycofana. Conajmniej jedno z zam�wie� ma OrderQty r�wne 0!';
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
DECLARE @IleDoUsuni�cia INT = 0;

SELECT @SredniKoszt = AVG(StandardCost)
FROM Production.Product;

SELECT @IleDoUsuni�cia = COUNT(*)
FROM Production.Product
WHERE StandardCost > @SredniKoszt;

IF @IleDoUsuni�cia > 10
BEGIN
    
    ROLLBACK TRANSACTION;
    PRINT 'Transakcja wycofana. Liczba produkt�w do usuni�cia przekracza 10!';
END
ELSE
BEGIN
    
	DELETE FROM Production.Product
    WHERE StandardCost > @SredniKoszt;
    
    COMMIT TRANSACTION;
    PRINT 'Transakcja zatwierdzona. Produkty usuni�te!';
END






