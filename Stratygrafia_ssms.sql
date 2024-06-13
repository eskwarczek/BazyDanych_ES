ALTER DATABASE [wydajnosc]
SET SINGLE_USER --or RESTRICTED_USER
WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE [wydajnosc];
GO

CREATE DATABASE wydajnosc;
GO

USE wydajnosc;
GO

CREATE SCHEMA tabela_stratygraficzna;
GO

-- Tworzenie tabel
CREATE TABLE tabela_stratygraficzna.Eon (
    ID_eon VARCHAR(10) PRIMARY KEY,
    NazwaEon NVARCHAR(40) NOT NULL
);

CREATE TABLE tabela_stratygraficzna.Era (
    ID_era VARCHAR(10) PRIMARY KEY,
    ID_eon VARCHAR(10) NOT NULL,
    NazwaEra NVARCHAR(40) NOT NULL,
    FOREIGN KEY (ID_eon) REFERENCES tabela_stratygraficzna.Eon(ID_eon)
);

CREATE TABLE tabela_stratygraficzna.Okres (
    ID_okres VARCHAR(10) PRIMARY KEY,
    ID_era VARCHAR(10) NOT NULL,
    NazwaOkres NVARCHAR(40) NOT NULL,
    FOREIGN KEY (ID_era) REFERENCES tabela_stratygraficzna.Era(ID_era)
);

CREATE TABLE tabela_stratygraficzna.Epoka (
    ID_epoka VARCHAR(10) PRIMARY KEY,
    ID_okres VARCHAR(10) NOT NULL,
    NazwaEpoka NVARCHAR(40) NOT NULL,
    FOREIGN KEY (ID_okres) REFERENCES tabela_stratygraficzna.Okres(ID_okres)
);

CREATE TABLE tabela_stratygraficzna.Pietra (
    ID_pietro VARCHAR(10) PRIMARY KEY,
    ID_epoka VARCHAR(10) NOT NULL,
    NazwaPietro NVARCHAR(40) NOT NULL,
    FOREIGN KEY (ID_epoka) REFERENCES tabela_stratygraficzna.Epoka(ID_epoka)
);

-- Wprowadzanie danych
-- Eon
INSERT INTO tabela_stratygraficzna.Eon (ID_eon, NazwaEon) VALUES ('EON1', 'Fanerozoik');

-- Era
INSERT INTO tabela_stratygraficzna.Era (ID_era, ID_eon, NazwaEra) VALUES
('ERA1', 'EON1', 'Paleozoik'),
('ERA2', 'EON1', 'Mezozoik'),
('ERA3', 'EON1', 'Kenozoik');

-- Okres
INSERT INTO tabela_stratygraficzna.Okres (ID_okres, ID_era, NazwaOkres) VALUES
('OKR1', 'ERA1', 'Kambr'),
('OKR2', 'ERA1', 'Ordowik'),
('OKR3', 'ERA1', 'Sylur'),
('OKR4', 'ERA1', 'Dewon'),
('OKR5', 'ERA1', 'Karbon'),
('OKR6', 'ERA1', 'Perm'),
('OKR7', 'ERA2', 'Trias'),
('OKR8', 'ERA2', 'Jura'),
('OKR9', 'ERA2', 'Kreda'),
('OKR10', 'ERA3', 'Paleogen'),
('OKR11', 'ERA3', 'Neogen'),
('OKR12', 'ERA3', 'Czwartorzed');

-- Epoka
INSERT INTO tabela_stratygraficzna.Epoka (ID_epoka, ID_okres, NazwaEpoka) VALUES
('EPOK1', 'OKR1', 'dolny'), ('EPOK2', 'OKR1', 'srodkowy'), ('EPOK3', 'OKR1', 'gorny'),
('EPOK4', 'OKR2', 'dolny'), ('EPOK5', 'OKR2', 'srodkowy'), ('EPOK6', 'OKR2', 'gorny'),
('EPOK7', 'OKR3', 'dolny'), ('EPOK8', 'OKR3', 'gorny'),
('EPOK9', 'OKR4', 'dolny'), ('EPOK10', 'OKR4', 'srodkowy'), ('EPOK11', 'OKR4', 'gorny'),
('EPOK12', 'OKR5', 'dolny'), ('EPOK13', 'OKR5', 'gorny'),
('EPOK14', 'OKR6', 'dolny'), ('EPOK15', 'OKR6', 'gorny'),
('EPOK16', 'OKR7', 'dolny'), ('EPOK17', 'OKR7', 'srodkowy'), ('EPOK18', 'OKR7', 'gorny'),
('EPOK19', 'OKR8', 'dolna'), ('EPOK20', 'OKR8', 'srodkowa'), ('EPOK21', 'OKR8', 'gorna'),
('EPOK22', 'OKR9', 'dolna'), ('EPOK23', 'OKR9', 'gorna'),
('EPOK24', 'OKR10', 'Paleocen'), ('EPOK25', 'OKR10', 'Eocen'), ('EPOK26', 'OKR10', 'Oligocen'),
('EPOK27', 'OKR11', 'Miocen'), ('EPOK28', 'OKR11', 'Pliocen'),
('EPOK29', 'OKR12', 'Plejstocen'), ('EPOK30', 'OKR12', 'Holocen');

-- Kambryjski
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE1', 'EPOK1', 'Fortunian'),
('PIE2', 'EPOK2', 'Tommotian'),
('PIE3', 'EPOK2', 'Atdabanian'),
('PIE4', 'EPOK2', 'Botomian'),
('PIE5', 'EPOK2', 'Toyonian'),
('PIE6', 'EPOK3', 'Drumian'),
('PIE7', 'EPOK3', 'Guzhangian'),
('PIE8', 'EPOK3', 'Paibian'),
('PIE9', 'EPOK3', 'Jiangshanian'),
('PIE10', 'EPOK3', 'Stage 10');

-- Ordowik
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE11', 'EPOK4', 'Tremadocian'),
('PIE12', 'EPOK4', 'Floian'),
('PIE13', 'EPOK5', 'Dapingian'),
('PIE14', 'EPOK5', 'Darriwilian'),
('PIE15', 'EPOK6', 'Sandbian'),
('PIE16', 'EPOK6', 'Katian'),
('PIE17', 'EPOK6', 'Hirnantian');

-- Sylur
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE18', 'EPOK7', 'Rhuddanian'),
('PIE19', 'EPOK7', 'Aeronian'),
('PIE20', 'EPOK7', 'Telychian'),
('PIE21', 'EPOK8', 'Sheinwoodian'),
('PIE22', 'EPOK8', 'Homerian'),
('PIE23', 'EPOK8', 'Gorstian'),
('PIE24', 'EPOK8', 'Ludfordian'),
('PIE25', 'EPOK8', 'Pridoli');

-- Dewon
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE26', 'EPOK9', 'Lochkovian'),
('PIE27', 'EPOK9', 'Pragian'),
('PIE28', 'EPOK9', 'Emsian'),
('PIE29', 'EPOK10', 'Eifelian'),
('PIE30', 'EPOK10', 'Givetian'),
('PIE31', 'EPOK11', 'Frasnian'),
('PIE32', 'EPOK11', 'Famennian');

-- Karbon
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE33', 'EPOK12', 'Tournaisian'),
('PIE34', 'EPOK12', 'Visean'),
('PIE35', 'EPOK13', 'Serpukhovian'),
('PIE36', 'EPOK13', 'Bashkirian'),
('PIE37', 'EPOK13', 'Moscovian'),
('PIE38', 'EPOK13', 'Kasimovian'),
('PIE39', 'EPOK13', 'Gzhelian');

-- Perm
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE40', 'EPOK14', 'Asselian'),
('PIE41', 'EPOK14', 'Sakmarian'),
('PIE42', 'EPOK14', 'Artinskian'),
('PIE43', 'EPOK14', 'Kungurian'),
('PIE44', 'EPOK15', 'Roadian'),
('PIE45', 'EPOK15', 'Wordian'),
('PIE46', 'EPOK15', 'Capitanian'),
('PIE47', 'EPOK15', 'Wuchiapingian'),
('PIE48', 'EPOK15', 'Changhsingian');

-- Trias
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE49', 'EPOK16', 'Induan'),
('PIE50', 'EPOK16', 'Olenekian'),
('PIE51', 'EPOK17', 'Anisian'),
('PIE52', 'EPOK17', 'Ladinian'),
('PIE53', 'EPOK18', 'Carnian'),
('PIE54', 'EPOK18', 'Norian'),
('PIE55', 'EPOK18', 'Rhaetian');

-- Jura
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE56', 'EPOK19', 'Hettangian'),
('PIE57', 'EPOK19', 'Sinemurian'),
('PIE58', 'EPOK19', 'Pliensbachian'),
('PIE59', 'EPOK19', 'Toarcian'),
('PIE60', 'EPOK20', 'Aalenian'),
('PIE61', 'EPOK20', 'Bajocian'),
('PIE62', 'EPOK20', 'Bathonian'),
('PIE63', 'EPOK20', 'Callovian'),
('PIE64', 'EPOK21', 'Oxfordian'),
('PIE65', 'EPOK21', 'Kimmeridgian'),
('PIE66', 'EPOK21', 'Tithonian');

-- Kreda
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE67', 'EPOK22', 'Berriasian'),
('PIE68', 'EPOK22', 'Valanginian'),
('PIE69', 'EPOK22', 'Hauterivian'),
('PIE70', 'EPOK22', 'Barremian'),
('PIE71', 'EPOK22', 'Aptian'),
('PIE72', 'EPOK22', 'Albian'),
('PIE73', 'EPOK23', 'Cenomanian'),
('PIE74', 'EPOK23', 'Turonian'),
('PIE75', 'EPOK23', 'Coniacian'),
('PIE76', 'EPOK23', 'Santonian'),
('PIE77', 'EPOK23', 'Campanian'),
('PIE78', 'EPOK23', 'Maastrichtian');

-- Paleogen
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE79', 'EPOK24', 'Danian'),
('PIE80', 'EPOK24', 'Selandian'),
('PIE81', 'EPOK24', 'Thanetian'),
('PIE82', 'EPOK25', 'Ypresian'),
('PIE83', 'EPOK25', 'Lutetian'),
('PIE84', 'EPOK25', 'Bartonian'),
('PIE85', 'EPOK25', 'Priabonian'),
('PIE86', 'EPOK26', 'Rupelian'),
('PIE87', 'EPOK26', 'Chattian');

-- Neogen
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE88', 'EPOK27', 'Aquitanian'),
('PIE89', 'EPOK27', 'Burdigalian'),
('PIE90', 'EPOK27', 'Langhian'),
('PIE91', 'EPOK27', 'Serravallian'),
('PIE92', 'EPOK27', 'Tortonian'),
('PIE93', 'EPOK27', 'Messinian'),
('PIE94', 'EPOK28', 'Zanclean'),
('PIE95', 'EPOK28', 'Piacenzian');

-- Czwartorzêd
INSERT INTO tabela_stratygraficzna.Pietra (ID_pietro, ID_epoka, NazwaPietro) VALUES
('PIE96', 'EPOK29', 'Gelasian'),
('PIE97', 'EPOK29', 'Calabrian'),
('PIE98', 'EPOK29', 'Chibanian'),
('PIE99', 'EPOK29', 'Upper Pleistocene'),
('PIE100', 'EPOK30', 'Greenlandian'),
('PIE101', 'EPOK30', 'Northgrippian'),
('PIE102', 'EPOK30', 'Meghalayan');

SELECT * FROM tabela_stratygraficzna.Era;
SELECT * FROM tabela_stratygraficzna.Okres;
SELECT * FROM tabela_stratygraficzna.Eon;
SELECT * FROM tabela_stratygraficzna.Epoka;
SELECT * FROM tabela_stratygraficzna.Pietra;

-- Tworzenie tabeli TabelaStra
CREATE TABLE tabela_stratygraficzna.TabelaStraty (
    ID_pietra VARCHAR(10) PRIMARY KEY,
    Pietro NVARCHAR(40),
    ID_epoki VARCHAR(10),
    Epoka NVARCHAR(40),
    ID_okresu VARCHAR(10),
    Okres NVARCHAR(40),
    ID_ery VARCHAR(10),
    Era NVARCHAR(40),
    ID_eonu VARCHAR(10),
    Eon NVARCHAR(40)
);

-- Wstawianie danych do TabelaStra
INSERT INTO tabela_stratygraficzna.TabelaStraty (ID_pietra, Pietro, ID_epoki, Epoka, ID_okresu, Okres, ID_ery, Era, ID_eonu, Eon)
SELECT
    p.ID_pietro,
    p.NazwaPietro,
    ep.ID_epoka,
    ep.NazwaEpoka,
    o.ID_okres,
    o.NazwaOkres,
    er.ID_era,
    er.NazwaEra,
    eo.ID_eon,
    eo.NazwaEon
FROM
    tabela_stratygraficzna.Pietra p
INNER JOIN 
    tabela_stratygraficzna.Epoka ep ON p.ID_epoka = ep.ID_epoka
INNER JOIN
    tabela_stratygraficzna.Okres o ON ep.ID_okres = o.ID_okres
INNER JOIN
    tabela_stratygraficzna.Era er ON o.ID_era = er.ID_era 
INNER JOIN
    tabela_stratygraficzna.Eon eo ON er.ID_eon = eo.ID_eon;

-- Wyœwietlenie zawartoœci tabeli TabelaStra
SELECT * FROM tabela_stratygraficzna.TabelaStraty;


-- Utworzenie tabel "Dziesiec" i "Milion"
CREATE SCHEMA liczby;

CREATE TABLE liczby.dziesiec (
    cyfra INT NOT NULL
);

INSERT INTO liczby.dziesiec (cyfra)
VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

SELECT
    l1.cyfra + 10 * l2.cyfra + 100 * l3.cyfra + 1000 * l4.cyfra + 10000 * l5.cyfra + 100000 * l6.cyfra AS liczba
INTO
    liczby.milion
FROM
    liczby.dziesiec l1,
    liczby.dziesiec l2,
    liczby.dziesiec l3,
    liczby.dziesiec l4,
    liczby.dziesiec l5,
    liczby.dziesiec l6;

SELECT * FROM liczby.milion
ORDER BY liczby.milion.liczba;

-- Testy
-- 1
SELECT 
    COUNT(*)
FROM
    liczby.milion m
INNER JOIN
    tabela_stratygraficzna.TabelaStraty t
ON
    m.liczba % 95 = CAST(RIGHT(t.ID_pietra, LEN(t.ID_pietra) - 3) AS INT);

-- 2
SELECT
    COUNT(*)
FROM
    liczby.milion m
INNER JOIN
    tabela_stratygraficzna.Pietra p
ON
    m.liczba % 95 = CAST(RIGHT(p.ID_pietro, LEN(p.ID_pietro) - 3) AS INT)
INNER JOIN 
    tabela_stratygraficzna.Epoka ep
ON
    p.ID_epoka = ep.ID_epoka
INNER JOIN
    tabela_stratygraficzna.Okres o
ON
    ep.ID_okres = o.ID_okres
INNER JOIN
    tabela_stratygraficzna.Era er
ON
    o.ID_era = er.ID_era
INNER JOIN
    tabela_stratygraficzna.Eon eo
ON
    er.ID_eon = eo.ID_eon;

-- 3
SELECT
    COUNT(*)
FROM
    liczby.milion m
WHERE
    m.liczba % 95 = 
    (SELECT 
        CAST(RIGHT(p.ID_pietro, LEN(p.ID_pietro) - 3) AS INT) 
    FROM 
        tabela_stratygraficzna.Pietra p
    WHERE
        m.liczba % 95 = CAST(RIGHT(p.ID_pietro, LEN(p.ID_pietro) - 3) AS INT));

-- 4
SELECT
    COUNT(*)
FROM
    liczby.milion m
WHERE
    m.liczba % 95 IN
    (SELECT
        CAST(RIGHT(p.ID_pietro, LEN(p.ID_pietro) - 3) AS INT)
    FROM
        tabela_stratygraficzna.Pietra p
    INNER JOIN 
        tabela_stratygraficzna.Epoka ep
    ON
        p.ID_epoka = ep.ID_epoka
    INNER JOIN
        tabela_stratygraficzna.Okres o
    ON
        ep.ID_okres = o.ID_okres
    INNER JOIN
        tabela_stratygraficzna.Era er
    ON
        o.ID_era = er.ID_era
    INNER JOIN
        tabela_stratygraficzna.Eon eo
    ON
        er.ID_eon = eo.ID_eon);

-- Dodawanie indeksów
CREATE INDEX ix_eon_id_eon
ON tabela_stratygraficzna.Eon(ID_eon);

CREATE INDEX ix_era_id_era
ON tabela_stratygraficzna.Era(ID_era);

CREATE INDEX ix_era_id_eon
ON tabela_stratygraficzna.Era(ID_eon);

CREATE INDEX ix_okres_id_okres
ON tabela_stratygraficzna.Okres(ID_okres);

CREATE INDEX ix_okres_id_era
ON tabela_stratygraficzna.Okres(ID_era);

CREATE INDEX ix_epoka_id_epoka
ON tabela_stratygraficzna.Epoka(ID_epoka);

CREATE INDEX ix_epoka_id_okres
ON tabela_stratygraficzna.Epoka(ID_okres);

CREATE INDEX ix_pietra_id_pietro
ON tabela_stratygraficzna.Pietra(ID_pietro);

CREATE INDEX ix_pietra_id_epoka
ON tabela_stratygraficzna.Pietra(ID_epoka);

CREATE INDEX ix_tabelastra_id_pietro
ON tabela_stratygraficzna.TabelaStraty(ID_pietra);

CREATE INDEX ix_tabelastra_id_epoka
ON tabela_stratygraficzna.TabelaStraty(ID_epoki);

CREATE INDEX ix_tabelastra_id_okres
ON tabela_stratygraficzna.TabelaStraty(ID_okresu);

CREATE INDEX ix_tabelastra_id_era
ON tabela_stratygraficzna.TabelaStraty(ID_ery);

CREATE INDEX ix_tabelastra_id_eon
ON tabela_stratygraficzna.TabelaStraty(ID_eonu);

CREATE INDEX ix_milion_liczba
ON liczby.milion(liczba);

-- Usuwanie indeksów
DROP INDEX ix_eon_id_eon
ON tabela_stratygraficzna.Eon;

DROP INDEX ix_era_id_era
ON tabela_stratygraficzna.Era;

DROP INDEX ix_era_id_eon
ON tabela_stratygraficzna.Era;

DROP INDEX ix_okres_id_okres
ON tabela_stratygraficzna.Okres;

DROP INDEX ix_okres_id_era
ON tabela_stratygraficzna.Okres;

DROP INDEX ix_epoka_id_epoka
ON tabela_stratygraficzna.Epoka;

DROP INDEX ix_epoka_id_okres
ON tabela_stratygraficzna.Epoka;

DROP INDEX ix_pietra_id_pietro
ON tabela_stratygraficzna.Pietra;

DROP INDEX ix_pietra_id_epoka
ON tabela_stratygraficzna.Pietra;

DROP INDEX ix_tabelastra_id_pietro
ON tabela_stratygraficzna.TabelaStra;

DROP INDEX ix_tabelastra_id_epoka
ON tabela_stratygraficzna.TabelaStra;

DROP INDEX ix_tabelastra_id_okres
ON tabela_stratygraficzna.TabelaStra;

DROP INDEX ix_tabelastra_id_era
ON tabela_stratygraficzna.TabelaStra;

DROP INDEX ix_tabelastra_id_eon
ON tabela_stratygraficzna.TabelaStra;

DROP INDEX ix_milion_liczba
ON liczby.milion;

