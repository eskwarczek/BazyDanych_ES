CREATE DATABASE FirmaZamawiaj¹ca;
CREATE SCHEMA ksiegowoscfrimyzamawiaj¹cej;

CREATE TABLE ksiegowoscfrimyzamawiaj¹cej.zamowienia(
    id_produktu INT NOT NULL, 
	id_klienta INT NOT NULL,
    nazwa_produktu VARCHAR(50) NOT NULL, 
    nazwa_klienta VARCHAR(50) NOT NULL, 
	data_zamowienia DATE NOT NULL,
	cena_produktu DECIMAL(10,2) NOT NULL,
	iloœæ INT NOT NULL,
	VAT DECIMAL(10,2) NOT NULL,
	suma_brutto DECIMAL(10,2) NOT NULL,
	suma_netto DECIMAL(10,2) NOT NULL,
);
--Wypisz zale¿noœci funkcyjne:
-- id_produktu -> nazwa_produktu, cena_produktu, VAT
-- nazwa_produktu -> nazwa_klienta, cena_produktu, VAT, id_produktu
-- nazwa_klienta -> nazwa_produktu, data_zamowienia, cena_produktu, VAT, id_produktu, iloœæ 
-- data_zamowienia -> nazwa_klienta, nazwa_produktu, data_zamowienia, cena_produktu, VAT, id_produktu, iloœæ
-- suma_brutto -> suma_netto, VAT
--Wypisz wszystkie klucze kandyduj¹ce:
-- id_produktu
-- id_klienta
-- nazwa_produktu
-- nazwa_klienta
-- data_zamowienia
-- Dla tabeli pomieszczenia(id_pomieszczenia, numer_pomieszczenia, id_budynku, 
--powierzchnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy) okreœl wszystkie 
--zale¿noœci funkcyjne oraz klucze kandyduj¹ce.

CREATE TABLE ksiegowoscfrimyzamawiaj¹cej.pomieszczenia(
    id_pomieszczenia INT NOT NULL PRIMARY KEY, 
	numer_pomieszczenia INT NOT NULL,
	id_budynku INT NOT NULL,
	powierzchnia DECIMAL(10,2) NOT NULL,
	liczba_okien INT NOT NULL,
	liczba_drzwi INT NOT NULL,
    ulica VARCHAR(50) NOT NULL, 
	miasto VARCHAR(50) NOT NULL, 
    kod_pocztowy VARCHAR(50) NOT NULL, 
);

ALTER TABLE ksiegowoscfrimyzamawiaj¹cej.pomieszczenia
ADD kod_pocztowy1 VARCHAR(20);

UPDATE ksiegowoscfrimyzamawiaj¹cej.pomieszczenia
SET kod_pocztowy1 = CONCAT(SUBSTRING(kod_pocztowy, 1, 2), '-', SUBSTRING(kod_pocztowy, 3, 3)); 

ALTER TABLE ksiegowoscfrimyzamawiaj¹cej.pomieszczenia
DROP COLUMN kod_pocztowy;

EXEC sp_rename 'ksiegowoscfrimyzamawiaj¹cej.pomieszczenia.kod_pocztowy1', 'kod_pocztowy', 'COLUMN';

--okreœl wszystkie zale¿noœci funkcyjne
--id_pomieszczenia -> numer_pomieszczenia,id_budynku,powierzchnia,liczba_okien,liczba_drzwi,ulica,miasto,kod_pocztowy
--kod_pocztowy -> miasto
--okreœl wszystkie klucze kandyduj¹ce
--numer_pomieszczenia
--id_budynku
--powierzchnia

