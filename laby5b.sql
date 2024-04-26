--k) Zlicz i pogrupuj pracownik�w wed�ug pola �stanowisko�.
SELECT pensja.stanowisko AS PoStanowiskach, COUNT(*) AS LiczbaPracownikow
FROM ksiegowosc.pensja
GROUP BY pensja.stanowisko;
--l) Policz �redni�, minimaln� i maksymaln� p�ac� dla stanowiska �kierownik� (je�eli takiego nie masz, to przyjmij dowolne inne).
SELECT pensja.stanowisko AS PoStanowiskach, MIN(kwota) AS MinimalnaP�aca, MAX(kwota) AS MaxymalnaP�aca, CAST(AVG(kwota) AS DECIMAL(10, 2)) AS �redniaP�aca
FROM ksiegowosc.pensja 
WHERE pensja.stanowisko = 'Kierownik'
GROUP BY pensja.stanowisko;
--m) Policz sum� wszystkich wynagrodze�.
SELECT SUM(pensja.kwota) + SUM(pr.kwota) AS SumaWynagrodzen
FROM ksiegowosc.pensja 
JOIN ksiegowosc.wynagrodzenie w ON w.id_pensji=pensja.id_pensji
JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
--f) Policz sum� wynagrodze� w ramach danego stanowiska.
SELECT pensja.stanowisko, SUM(pensja.kwota) + SUM(pr.kwota) AS Wynagrodzenie
FROM ksiegowosc.pensja
JOIN ksiegowosc.wynagrodzenie w ON w.id_pensji=pensja.id_pensji
JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
GROUP BY pensja.stanowisko;
--g) Wyznacz liczb� premii przyznanych dla pracownik�w danego stanowiska.
SELECT pensja.stanowisko, Count(pr.id_premii) AS LiczbaPremii
FROM ksiegowosc.pensja
JOIN ksiegowosc.wynagrodzenie w ON w.id_pensji=pensja.id_pensji
JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
GROUP BY pensja.stanowisko;
--h) Usu� wszystkich pracownik�w maj�cych pensj� mniejsz� ni� 1200 z�.
DELETE pracownik
FROM ksiegowosc.pracownicy pracownik
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika=pracownik.id_pracownika
JOIN ksiegowosc.pensja p ON p.id_pensji = w.id_pensji
WHERE p.kwota < 1200
--WHERE p.kwota < 2500
