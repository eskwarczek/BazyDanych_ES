--Przetwarzanie transakcyjne
--Wykorzystując SQL Server i bazę AdventureWorks rozwiąż poniższe zadania.
--1. Napisz zapytanie, które wykorzystuje transakcję (zaczyna ją), a następnie
--aktualizuje cenę produktu o ProductID równym 680 w tabeli Production.Product
--o 10% i następnie zatwierdza transakcję.
--2. Napisz zapytanie, które zaczyna transakcję, usuwa produkt o ProductID równym
--707 z tabeli Production. Product, ale następnie wycofuje transakcję.
--3. Napisz zapytanie, które zaczyna transakcję, dodaje nowy produkt do tabeli
--Production.Product, a następnie zatwierdza transakcję.
--4. Napisz zapytanie, które zaczyna transakcję i aktualizuje StandardCost wszystkich
--produktów w tabeli Production.Product o 10%, jeżeli suma wszystkich
--StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
--powinno wycofać transakcję.
--5. Napisz zapytanie SQL, które zaczyna transakcję i próbuje dodać nowy produkt do
--tabeli Production.Product. Jeśli ProductNumber już istnieje w tabeli, zapytanie
--powinno wycofać transakcję.
--6. Napisz zapytanie SQL, które zaczyna transakcję i aktualizuje wartość OrderQty
--dla każdego zamówienia w tabeli Sales.SalesOrderDetail. Jeżeli którykolwiek z
--zamówień ma OrderQty równą 0, zapytanie powinno wycofać transakcję.
--7. Napisz zapytanie SQL, które zaczyna transakcję i usuwa wszystkie produkty,
--których StandardCost jest wyższy niż średni koszt wszystkich produktów w tabeli
--Production.Product. Jeżeli liczba produktów do usunięcia przekracza 10,
--zapytanie powinno wycofać transakcję

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
	PRINT 'Produkt jest usunięty!';
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
--4 (z zajęć)
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
		--Jeśli suma nie przekracza 50 000, zatwierdź transakcję
		COMMIT;
		PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi:' + CAST(@TotalStandardCost AS NVARCHAR(50));
	END
	ELSE
	BEGIN
		--Jeśli suma przekracza 50 000, wycofaj transakcję
		ROLLBACK;
		PRINT 'Transakcja  wycofana. Suma StandardCost wynosi:' + CAST(@TotalStandardCost AS NVARCHAR(50));
	END
END TRY 
BEGIN CATCH
	--Jeśli wystąpi błąd, wycofaj transakcję i wyświetl komunikat o błędzie
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
    PRINT 'Transakcja wycofana. Produkt o tym numerze już istnieje!';
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

	
	IF EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
	BEGIN
		
		ROLLBACK TRANSACTION;
		PRINT 'Transakcja wycofana. Conajmniej jedno z zamówień ma OrderQty równe 0!';
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
DECLARE @IleDoUsunięcia INT = 0;

SELECT @SredniKoszt = AVG(StandardCost)
FROM Production.Product;

SELECT @IleDoUsunięcia = COUNT(*)
FROM Production.Product
WHERE StandardCost > @SredniKoszt;

IF @IleDoUsunięcia > 10
BEGIN
    
    ROLLBACK TRANSACTION;
    PRINT 'Transakcja wycofana. Liczba produktów do usunięcia przekracza 10!';
END
ELSE
BEGIN
    
	DELETE FROM Production.Product
    WHERE StandardCost > @SredniKoszt;
    
    COMMIT TRANSACTION;
    PRINT 'Transakcja zatwierdzona. Produkty usunięte!';
END






