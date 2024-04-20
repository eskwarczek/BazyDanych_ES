CREATE DATABASE Firma;
CREATE SCHEMA ksiegowosc;

--Tabela przechowuj�ca dane pracownik�w
CREATE TABLE ksiegowosc.pracownicy (
    id_pracownika INT NOT NULL PRIMARY KEY, --Identyfikator pracownika
    imie VARCHAR(50) NOT NULL, --Imi� pracownika
    nazwisko VARCHAR(50) NOT NULL, --Nazwisko pracownika
    adres VARCHAR(100) NOT NULL, --Adres pracownika
    telefon VARCHAR(15) NOT NULL--Telefon pracownika
);

CREATE TABLE ksiegowosc.godziny (
    id_godziny INT NOT NULL PRIMARY KEY, 
    data DATE NOT NULL,
    liczba_godzin INT NOT NULL, 
    id_pracownika INT NOT NULL,
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
);

CREATE TABLE ksiegowosc.premia (
    id_premii INT NOT NULL PRIMARY KEY,
    rodzaj VARCHAR(50) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL
);

CREATE TABLE ksiegowosc.pensja (
    id_pensji INT NOT NULL PRIMARY KEY,
    stanowisko VARCHAR(50) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL,
);

CREATE TABLE ksiegowosc.wynagrodzenie (
    id_wynagrodzenia INT NOT NULL PRIMARY KEY,
	data DATE NOT NULL,
	id_pracownika INT NOT NULL,
	id_godziny INT NOT NULL,
	id_pensji INT NOT NULL,
	id_premii INT NOT NULL,
	FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
	FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
	FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji),
	FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii),
);

INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES (1, 'Jan', 'Kowalski', 'ul. Kwiatowa 1, Warszawa', '1234567890'),
       (2, 'Anna', 'Nowak', 'ul. S�oneczna 2, Krak�w', '9876543210'),
       (3, 'Piotr', 'Wi�niewski', 'ul. G��wna 3, Gda�sk', '5678901234'),
       (4, 'Maria', 'D�browska', 'ul. Polna 4, Wroc�aw', '0123456789'),
       (5, 'Adam', 'Lewandowski', 'ul. Le�na 5, Pozna�', '5432109876'),
       (6, 'Ewa', 'W�jcik', 'ul. Morska 6, Szczecin', '6789012345'),
       (7, 'Krzysztof', 'Kami�ski', 'ul. Rzeczna 7, ��d�', '2109876543'),
       (8, 'Magdalena', 'Zieli�ska', 'ul. Wiejska 8, Lublin', '3456789012'),
       (9, 'Tomasz', 'Kowalczyk', 'ul. Parkowa 9, Katowice', '6789012345'),
       (10, 'Karolina', 'Szyma�ska', 'ul. Zamkowa 10, Gdynia', '4321098765');

INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota)
VALUES
    (1, 'Ksi�gowy', 5000),
    (2, 'Pracownik biurowy', 4000),
    (3, 'Kierownik', 6000),
    (4, 'Specjalista ds. finansowych', 5500),
    (5, 'Asystent', 2000),
    (6, 'Analityk finansowy', 6000),
    (7, 'Sekretarka', 3800),
    (8, 'Doradca podatkowy', 6500),
    (9, 'Auditor', 7000),
    (10, 'Sprzedawca', 4000);
 
INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
VALUES
    (1, 'Za wyniki', 1000),
    (2, 'Za sta� pracy', 800),
    (3, 'Za osi�gni�cia', 1200),
    (4, 'Za dodatkowe obowi�zki', 900),
    (5, 'Za innowacyjno��', 1100),
    (6, 'Za zaanga�owanie', 1300),
    (7, 'Za wyj�tkowe osi�gni�cia', 1500),
    (8, 'Za dodatkow� prac�', 1000),
    (9, 'Za lojalno��', 800),
    (10, 'Za wysok� wydajno��', 1200);


INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
    (1, '2024-04-01', 180, 1),
    (2, '2024-04-02', 150, 2),
    (3, '2024-04-03', 130, 3),
    (4, '2024-04-04', 200, 4),
    (5, '2024-04-05', 90, 5),
    (6, '2024-04-06', 180, 6),
    (7, '2024-04-07', 160, 7),
    (8, '2024-04-08', 110, 8),
    (9, '2024-04-09', 140, 9),
    (10, '2024-04-10', 100, 10);

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
    (1, '2024-04-01', 1, 1, 1, 1),
    (2, '2024-04-02', 2, 2, 2, 2),
    (3, '2024-04-03', 3, 3, 3, 3),
    (4, '2024-04-04', 4, 4, 4, 4),
    (5, '2024-04-05', 5, 5, 5, 5),
    (6, '2024-04-06', 6, 6, 6, 6),
    (7, '2024-04-07', 7, 7, 7, 7),
    (8, '2024-04-08', 8, 8, 8, 8),
    (9, '2024-04-09', 9, 9, 9, 9),
    (10, '2024-04-10', 10, 10, 10, 10);



--a Wy�wietl tylko id pracownika oraz jego nazwisko
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;
--b Wy�wietl id pracownik�w, kt�rych p�aca jest wi�ksza ni� 1000 
SELECT pracownicy.id_pracownika, pensja.kwota -- dodatkowo wy�wietlam kwot�, bo akurat �aden pracownik nie zarabia mniej ni� 1000
FROM ksiegowosc. pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
WHERE pensja.kwota > 1000;
--c Wy�wietl id pracownik�w nieposiadaj�cych premii, kt�rych p�aca jest wi�ksza ni� 2000
SELECT pracownicy.id_pracownika, pensja.kwota, premia.id_premii 
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN ksiegowosc.premia premia ON wynagrodzenie.id_premii = premia.id_premii
WHERE premia.id_premii IS NULL AND pensja.kwota > 2000;
--WHERE premia.id_premii IS NOT NULL AND pensja.kwota > 4000; 
--d Wy�wietl pracownik�w, kt�rych pierwsza litera imienia zaczyna si� na liter� 'J'
SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';
--e Wy�wietl pracownik�w, kt�rych nazwisko zawiera liter� 'n' oraz imi� ko�czy si� na liter� 'a
SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';
--f Wy�wietl imi� i nazwisko pracownik�w oraz liczb� ich nadgodzin, przyjmuj�c, i� standardowy czas pracy to 160 h miesi�cznie
SELECT pracownicy.imie, pracownicy.nazwisko, SUM(godziny.liczba_godzin) - 160 AS nadgodziny
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.godziny godziny ON pracownicy.id_pracownika = godziny.id_pracownika
GROUP BY pracownicy.imie, pracownicy.nazwisko
HAVING SUM(godziny.liczba_godzin) > 160; -- dodany warunek sprawdzaj�cy, czy nadgodziny s� dodatnie
--g Wy�wietl imi� i nazwisko pracownik�w, kt�rych pensja zawiera si� w przedziale 1500 � 3000 PLN.
SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja s ON w.id_pensji = s.id_pensji
WHERE s.kwota BETWEEN 1500 AND 3000;
--h Wy�wietl imi� i nazwisko pracownik�w, kt�rzy pracowali w nadgodzinach i nie otrzymali premii.
SELECT pracownicy.imie, pracownicy.nazwisko
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.godziny godziny ON pracownicy.id_pracownika = godziny.id_pracownika
LEFT JOIN ksiegowosc.premia premia ON wynagrodzenie.id_premii = premia.id_premii
WHERE godziny.liczba_godzin > 160 AND premia.id_premii IS NULL;
--i Uszereguj pracownik�w wed�ug pensji.
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota AS pensja
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
ORDER BY pensja.kwota;
--ORDER BY pensja.kwota DESC;
--j Uszereguj pracownik�w wed�ug pensji i premii malej�co
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota AS pensja, premia.kwota AS premia
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN ksiegowosc.premia premia ON wynagrodzenie.id_premii = premia.id_premii
ORDER BY pensja.kwota DESC, premia.kwota DESC;
--ORDER BY premia.kwota DESC, pensja.kwota DESC;




