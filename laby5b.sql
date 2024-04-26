--k) Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’.
SELECT pensja.stanowisko AS PoStanowiskach, COUNT(*) AS LiczbaPracownikow
FROM ksiegowosc.pensja
GROUP BY pensja.stanowisko;
--l) Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (je¿eli takiego nie masz, to przyjmij dowolne inne).
SELECT pensja.stanowisko AS PoStanowiskach, MIN(kwota) AS MinimalnaP³aca, MAX(kwota) AS MaxymalnaP³aca, CAST(AVG(kwota) AS DECIMAL(10, 2)) AS ŒredniaP³aca
FROM ksiegowosc.pensja 
WHERE pensja.stanowisko = 'Kierownik'
GROUP BY pensja.stanowisko;
--m) Policz sumê wszystkich wynagrodzeñ.
SELECT SUM(pensja.kwota) + SUM(pr.kwota) AS SumaWynagrodzen
FROM ksiegowosc.pensja 
JOIN ksiegowosc.wynagrodzenie w ON w.id_pensji=pensja.id_pensji
JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
--f) Policz sumê wynagrodzeñ w ramach danego stanowiska.
SELECT pensja.stanowisko, SUM(pensja.kwota) + SUM(pr.kwota) AS Wynagrodzenie
FROM ksiegowosc.pensja
JOIN ksiegowosc.wynagrodzenie w ON w.id_pensji=pensja.id_pensji
JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
GROUP BY pensja.stanowisko;
--g) Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska.
SELECT pensja.stanowisko, Count(pr.id_premii) AS LiczbaPremii
FROM ksiegowosc.pensja
JOIN ksiegowosc.wynagrodzenie w ON w.id_pensji=pensja.id_pensji
JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
GROUP BY pensja.stanowisko;
--h) Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³.
DELETE pracownik
FROM ksiegowosc.pracownicy pracownik
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika=pracownik.id_pracownika
JOIN ksiegowosc.pensja p ON p.id_pensji = w.id_pensji
WHERE p.kwota < 1200
--WHERE p.kwota < 2500
