CREATE DATABASE Firma;

USE Firma;

CREATE SCHEMA rozliczenia;

CREATE TABLE rozliczenia.pracownicy (
    id_pracownika INTEGER NOT NULL PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL,
    telefon VARCHAR(15) NOT NULL
);

CREATE TABLE rozliczenia.godziny (
    id_godziny INT NOT NULL PRIMARY KEY,
    data DATE NOT NULL,
    liczba_godzin INT NOT NULL, 
    id_pracownika INT NOT NULL,
    FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)
);

CREATE TABLE rozliczenia.premie (
    id_premii INT NOT NULL PRIMARY KEY,
    rodzaj VARCHAR(50) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL
);

CREATE TABLE rozliczenia.pensje (
    id_pensji INT NOT NULL PRIMARY KEY,
    stanowisko VARCHAR(50) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL,
    id_premii INT NOT NULL,
    FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii)
);


USE Firma;

-- Wype³nienie tabeli "pracownicy" 10 rekordami
INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon) VALUES
(1, 'Anna', 'Kowalska', 'ul. Kwiatowa 1, 00-001 Warszawa', '123456789'),
(2, 'Jan', 'Nowak', 'ul. S³oneczna 2, 00-002 Warszawa', '987654321'),
(3, 'Katarzyna', 'Wiœniewska', 'ul. Leœna 3, 00-003 Warszawa', '111222333'),
(4, 'Piotr', 'Kaczor', 'ul. Polna 4, 00-004 Warszawa', '444555666'),
(5, 'Magdalena', 'Lis', 'ul. Zielona 5, 00-005 Warszawa', '777888999'),
(6, 'Adam', 'Nowicki', 'ul. Morska 6, 00-006 Warszawa', '222333444'),
(7, 'Aleksandra', 'Kowalczyk', 'ul. Ogrodowa 7, 00-007 Warszawa', '555666777'),
(8, 'Marek', 'Wójcik', 'ul. Polna 8, 00-008 Warszawa', '888999000'),
(9, 'Karolina', 'D¹browska', 'ul. Szkolna 9, 00-009 Warszawa', '333444555'),
(10, 'Tomasz', 'Kowal', 'ul. Ró¿ana 10, 00-010 Warszawa', '666777888');

-- Wype³nienie tabeli "godziny" 10 rekordami
INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika) VALUES
(1, '2024-04-01', 8, 1),
(2, '2024-04-02', 7, 2),
(3, '2024-04-03', 6, 3),
(4, '2024-04-04', 8, 4),
(5, '2024-04-05', 9, 5),
(6, '2024-04-06', 8, 6),
(7, '2024-04-07', 7, 7),
(8, '2024-04-08', 8, 8),
(9, '2024-04-09', 6, 9),
(10, '2024-04-10', 8, 10);

-- Wype³nienie tabeli "premie" 10 rekordami
INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota) VALUES
(1, 'Premia miesiêczna', 500),
(2, 'Premia za wyniki', 300),
(3, 'Premia za sta¿', 200),
(4, 'Premia za efektywnoœæ', 400),
(5, 'Premia dodatkowa', 600),
(6, 'Premia motywacyjna', 700),
(7, 'Premia specjalna', 1000),
(8, 'Premia za nadgodziny', 800),
(9, 'Premia uznaniowa', 900),
(10, 'Premia jubileuszowa', 1200);

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

SELECT 
    id_godziny,
    data,
    DATEPART(dw, data) AS dzien_tygodnia,
    DATENAME(dw, data) AS nazwa_dnia_tygodnia,
    DATEPART(month, data) AS numer_miesiaca,
    DATENAME(month, data) AS nazwa_miesiaca
FROM rozliczenia.godziny;

-- Zmiana nazwy atrybutu na "kwota_brutto" i dodanie nowego atrybutu "kwota_netto"
ALTER TABLE rozliczenia.pensje
    CHANGE kwota KwotaBrutto DECIMAL(10,2),
    ADD KwotaNetto DECIMAL(10,2);

-- Aktualizacja wartoœci w tabeli, obliczaj¹c kwotê netto
UPDATE rozliczenia.pensje SET KwotaNetto = KwotaBrutto * 0.85; -- Za³o¿enie, ¿e podatek wynosi 15%

-- Wyœwietlenie zmienionych danych
SELECT * FROM rozliczenia.pensje;
