--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48)
ALTER TABLE ksiegowosc.pracownicy
ADD telefon1 VARCHAR(20);

UPDATE ksiegowosc.pracownicy
SET telefon1 = CONCAT('(+48)', telefon); 

ALTER TABLE ksiegowosc.pracownicy 
DROP COLUMN telefon;

EXEC sp_rename 'ksiegowosc.pracownicy.telefon1', 'telefon', 'COLUMN';

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333� 
ALTER TABLE ksiegowosc.pracownicy
ADD telefon1 VARCHAR(20);

UPDATE ksiegowosc.pracownicy
SET telefon1 = CONCAT(SUBSTRING(telefon, 1, 5), ' ', SUBSTRING(telefon, 6, 3), '-', SUBSTRING(telefon, 8, 3), '-', SUBSTRING(telefon, 11, 3)); 

ALTER TABLE ksiegowosc.pracownicy 
DROP COLUMN telefon;

EXEC sp_rename 'ksiegowosc.pracownicy.telefon1', 'telefon', 'COLUMN';

SELECT pracownicy.telefon
FROM ksiegowosc.pracownicy

--c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter
SELECT TOP 1
       UPPER(pracownicy.imie) AS imie,
       UPPER(pracownicy.nazwisko) AS nazwisko,
       UPPER(pracownicy.adres) AS adres,
       UPPER(pracownicy.telefon) AS telefon
FROM ksiegowosc.pracownicy
ORDER BY LEN(pracownicy.nazwisko) DESC;
--d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5 
SELECT pracownik.id_pracownika, pracownik.imie, pracownik.nazwisko, pracownik.adres, pracownik.telefon, pensja.kwota
FROM ksiegowosc.pracownicy pracownik
LEFT JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = pracownik.id_pracownika
LEFT JOIN ksiegowosc.pensja pensja ON pensja.id_pensji = w.id_pensji

SELECT pracownik.imie, pracownik.nazwisko, pensja.kwota, CONVERT(VARCHAR(32), HashBytes('MD5', imie), 2) AS kodowane_imie,
CONVERT(VARCHAR(32), HashBytes('MD5', nazwisko), 2) AS kodowane_nazwisko, CONVERT(VARCHAR(32), HashBytes('MD5', CAST(pensja.kwota AS varchar(50))), 2) AS kodowana_pensja
FROM ksiegowosc.pracownicy pracownik
LEFT JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = pracownik.id_pracownika
LEFT JOIN ksiegowosc.pensja pensja ON pensja.id_pensji = w.id_pensji;

--f) Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne.
SELECT p.imie, p.nazwisko, pn.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
LEFT JOIN ksiegowosc.pensja pn ON pn.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii;
--g) wygeneruj raport (zapytanie), kt�re zwr�ci w wyniki tre�� wg poni�szego szablonu: Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma� pensj� ca�kowit� na kwot� 7540 z�, 
--gdzie wynagrodzenie zasadnicze wynosi�o: 5000 z�, premia: 2000 z�, nadgodziny: 540 z�
SELECT 
CONCAT('Pracownik ',p.imie,' ',p.nazwisko,', w dniu ', 
CONVERT(VARCHAR, g.data), ' otrzyma� pensj� ca�kowit� na kwot� ', 
(pn.kwota+pr.kwota),' z�, gdzie wynagrodzenie zasadnicze wynosi�o: ',(CAST( pn.kwota/g.liczba_godzin * 90 AS DECIMAL(10, 2))), ' z�, premia: ',
pr.kwota, ' z�, nadgodziny: ',(CAST(pn.kwota - pn.kwota/g.liczba_godzin * 90 AS DECIMAL(10, 2))), 'z�')
AS raport
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.godziny g ON g.id_godziny=w.id_godziny
JOIN ksiegowosc.pensja pn ON pn.id_pensji=w.id_pensji
JOIN ksiegowosc.premia pr ON pr.id_premii=w.id_premii;
