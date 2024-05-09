USE AdventureWorks2014;

-- Funkcja do obliczania ci�gu Fibonacciego:
CREATE FUNCTION Fibonacci(@n INT)
RETURNS INT
AS
BEGIN
    DECLARE @wynik INT = 0, @a INT = 1, @b INT = 1, @i INT = 1
    WHILE @i < @n
    BEGIN
        SELECT @wynik = @a, @a = @b, @i = @i + 1, @b = @a + @wynik;
    END
    RETURN @wynik;
END
GO
-- Procedura wypisuj�ca ci�g Fibonacciego do konsoli, wywo�uj�c funkcje Fibonacci:
CREATE PROCEDURE PrintFibonacci1 @n INT
AS
BEGIN
    DECLARE @i INT = 1;
    PRINT 'Ci�g Fibonacciego dla liczby n r�wnej ' + CAST(@n AS VARCHAR(10)) + ':';
    WHILE @i <= @n
    BEGIN
        DECLARE @fibonacci INT;
        SET @fibonacci = dbo.Fibonacci(@i);
        PRINT CAST(@fibonacci AS VARCHAR(20));
        SET @i = @i + 1;
    END
END
GO
--Wywo�anie procedury dla konkretnego n: 
EXEC dbo.PrintFibonacci1 @n = 10;

-------------------------------------------------------------------------------------------------
--DROP TRIGGER TriggerNAZWISKO;
CREATE TRIGGER Trigger1
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE P
	SET P.LastName = UPPER(t.LastName) 
	FROM Person.Person P
	INNER JOIN temp t --tabela tymczasowa
	ON P.BusinessEntityID = t.BusinessEntityID;
END;

SELECT * FROM Person.Person;

UPDATE Person.Person
SET LastName = 'Goldberg'
WHERE BusinessEntityID = 6;
---------------------------------------------------------------------------------------------------------------------------

SELECT * FROM Sales.SalesTaxRate;

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    DECLARE @oldTaxRate DECIMAL(10, 2)
    DECLARE @newTaxRate DECIMAL(10, 2)

    SELECT @oldTaxRate = d.TaxRate, @newTaxRate = i.TaxRate
    FROM inserted i
    INNER JOIN deleted d ON i.SalesTaxRateID = d.SalesTaxRateID

    IF ABS(@newTaxRate - @oldTaxRate) / NULLIF(@oldTaxRate, 0) > 0.3 --Funkcja ABS s�u�y do uzyskania warto�ci bezwzgl�dnej z r�nicy, 
	--a funkcja NULLIF zapobiega dzieleniu przez zero
    BEGIN
        PRINT 'Zmiana warto�ci w polu TaxRate jest wi�ksza ni� 30%!';
    END
END;

UPDATE Sales.SalesTaxRate
SET TaxRate = TaxRate * 1.31 
WHERE SalesTaxRateID = 1;