CREATE DATABASE IF NOT EXISTS dt;

USE dt;

CREATE TABLE datahora (
    a date,
    b datetime,
    c1 time(5),
    c2 time,
    d YEAR
);

INSERT INTO datahora 
VALUES 
('2021-09-10',
'2021-09-10 23:45:10',
'10:20:45',
'10:20:45',
'2021');

select * from datahora;
INSERT INTO datahora 
VALUES 
(2021021,
20210219222012,
102045,
102045,
2021);

select * from datahora;


-------------------------------------

USE world;

SHOW TABLES;

SHOW COLUMNS FROM city;


/*nomes de todas as cidades na tabela cidade com
nomes iniciados por ‘Sor’”:*/
SELECT Name
FROM city
WHERE Name LIKE "Sor%";

/*Encontrar nomes e a população de todas as cidades com
nomes iniciados por ‘Sor’”:*/
SELECT Name, Population
FROM city
WHERE Name LIKE "Sor%";

/*nomes, sua população e os países em que se
encontram, para todas as cidades com nomes iniciados por ‘Sor’”:*/
SELECT city.Name, city.Population,
country.Name
FROM city, country
WHERE city.Name LIKE 'Sor%' AND city.CountryCode = country.Code;