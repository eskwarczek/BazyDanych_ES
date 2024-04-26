CREATE DATABASE FirmaZamawiaj�ca;
CREATE SCHEMA ksiegowoscfrimyzamawiaj�cej;

CREATE TABLE ksiegowoscfrimyzamawiaj�cej.zamowienia(
    id_produktu INT NOT NULL, 
	id_klienta INT NOT NULL,
    nazwa_produktu VARCHAR(50) NOT NULL, 
    nazwa_klienta VARCHAR(50) NOT NULL, 
	data_zamowienia DATE NOT NULL,
	cena_produktu DECIMAL(10,2) NOT NULL,
	ilo�� INT NOT NULL,
	VAT DECIMAL(10,2) NOT NULL,
	suma_brutto DECIMAL(10,2) NOT NULL,
	suma_netto DECIMAL(10,2) NOT NULL,
);
--Wypisz zale�no�ci funkcyjne:
-- id_produktu -> nazwa_produktu, cena_produktu, VAT
-- nazwa_produktu -> nazwa_klienta, cena_produktu, VAT, id_produktu
-- nazwa_klienta -> nazwa_produktu, data_zamowienia, cena_produktu, VAT, id_produktu, ilo�� 
-- data_zamowienia -> nazwa_klienta, nazwa_produktu, data_zamowienia, cena_produktu, VAT, id_produktu, ilo��
-- suma_brutto -> suma_netto, VAT
--Wypisz wszystkie klucze kandyduj�ce:
-- id_produktu
-- id_klienta
-- nazwa_produktu
-- nazwa_klienta
-- data_zamowienia
-- Dla tabeli pomieszczenia(id_pomieszczenia, numer_pomieszczenia, id_budynku, 
--powierzchnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy) okre�l wszystkie 
--zale�no�ci funkcyjne oraz klucze kandyduj�ce.

CREATE TABLE ksiegowoscfrimyzamawiaj�cej.pomieszczenia(
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

ALTER TABLE ksiegowoscfrimyzamawiaj�cej.pomieszczenia
ADD kod_pocztowy1 VARCHAR(20);

UPDATE ksiegowoscfrimyzamawiaj�cej.pomieszczenia
SET kod_pocztowy1 = CONCAT(SUBSTRING(kod_pocztowy, 1, 2), '-', SUBSTRING(kod_pocztowy, 3, 3)); 

ALTER TABLE ksiegowoscfrimyzamawiaj�cej.pomieszczenia
DROP COLUMN kod_pocztowy;

EXEC sp_rename 'ksiegowoscfrimyzamawiaj�cej.pomieszczenia.kod_pocztowy1', 'kod_pocztowy', 'COLUMN';

--okre�l wszystkie zale�no�ci funkcyjne
--id_pomieszczenia -> numer_pomieszczenia,id_budynku,powierzchnia,liczba_okien,liczba_drzwi,ulica,miasto,kod_pocztowy
--kod_pocztowy -> miasto
--okre�l wszystkie klucze kandyduj�ce
--numer_pomieszczenia
--id_budynku
--powierzchnia

