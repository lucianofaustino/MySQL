create database SuperGames;
use SuperGames;
drop DATABASE supergames;

CREATE TABLE localizacao (
    Id INT(3) PRIMARY KEY AUTO_INCREMENT,
    Secao VARCHAR(50) NOT NULL,
    Prateleira INT(3) ZEROFILL NOT NULL
);

CREATE TABLE jogo (
    Cod INT(3) PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Valor DECIMAL(6 , 2 ) NOT NULL,
    Localizacao_Id INT(3) NOT NULL,
    FOREIGN KEY (Localizacao_Id)
        REFERENCES Localizacao (Id)
);

INSERT localizacao VALUES 
(0, "Guerra", "001"),
(0, "Guerra", "002"),
(0, "Aventura", "100"),
(0, "Aventura", "101"),
(0, "RPG", "150"),
(0, "RPG", "151"),
(0, "Plataforma 2D", "200"),
(0, "Plataforma 2D", "201");


INSERT jogo VALUES 
(0, "COD 3", 125.00, 1),
(0, "BF 1", 150.00, 2),
(0, "Zelda BotW", 200.00, 3),
(0, "Zelda OoT", 99.00, 4),
(0, "Chrono T", 205.00, 5);


SELECT * FROM localizacao;
SELECT * FROM jogo;

-- Identificar o nome do jogo e a prateleira
SELECT jogo.nome, localizacao.prateleira
FROM jogo INNER JOIN localizacao
ON localizacao.id = jogo.localizacao_Id;

-- Identificar o nome dos jogos da seção de jogos de Aventura.

SELECT jogo.nome
FROM jogo INNER JOIN localizacao
ON localizacao.id = jogo.localizacao_Id
WHERE secao = 'Aventura';

-- Identificar TODAS as seções e os respectivos nomes dos
-- jogos, ordenando as seleções em ordem crescente pelo nome dos jogos.

SELECT  localizacao.secao, localizacao.prateleira, jogo.nome
FROM localizacao LEFT JOIN jogo
ON localizacao.Id = jogo.localizacao_Id
ORDER BY jogo.nome ASC;

SELECT * FROM jogo;
SELECT * FROM localizacao;


-- Desenvolver uma função de agregação que retorne a quantidade
-- de registros na tabela jogo.
SELECT COUNT(*) FROM jogo;


-- Desenvolver uma função de agregação que retorne o
-- valor do jogo de maior preço (valor).
SELECT MAX(valor) AS "Maior valor" FROM jogo;



-- Desenvolver uma função de agregação que retorne o valor
-- do jogo de menor preço (valor). 
SELECT MIN(valor) AS "Menor valor" FROM jogo;
SELECT * FROM jogo;

-- Desenvolver uma função de agregação que retorne o valor
-- médio dos jogos de guerra
SELECT AVG(valor) AS "Media guerra" 
FROM jogo INNER JOIN localizacao
ON localizacao.id = jogo.localizacao_id
WHERE localizacao.secao = "Guerra";



-- Desenvolver uma função de agregação que retorne o
-- valor total em estoque na loja.
SELECT SUM(valor) AS "Total" FROM jogo;





















-- Desenvolver uma função de agregação que retorne a quantidade
-- de registros na tabela jogo.
SELECT COUNT(*) FROM jogo;


-- Desenvolver uma função de agregação que retorne o
-- valor do jogo de maior preço (valor).
SELECT MAX(valor) AS "Maior Valor" FROM jogo;


-- Desenvolver uma função de agregação que retorne o valor
-- do jogo de menor preço (valor). 
SELECT MIN(valor) FROM jogo;


-- Desenvolver uma função de agregação que retorne o valor
-- médio dos jogos de guerra
SELECT AVG(valor) AS "MediaGuerra" 
FROM jogo INNER JOIN localizacao
ON localizacao.id = jogo.localizacao_id
WHERE localizacao.secao = "Guerra";


-- Desenvolver uma função de agregação que retorne o
-- valor total em estoque na loja.

SELECT SUM(valor) AS "TOTAL" FROM jogo;

USE supergames;
SELECT * FROM localizacao;
INSERT jogo VALUES
(0, "Super Metroid", 205.00, 7),
(0, "DKC 2", 100.00, 8),
(0, "FF XV", 120.00, 5),
(0, "Xenoblade 2", 199.00, 6);

SELECT * FROM jogo;

/* Alterar valor dos jogos em promoção */

UPDATE jogo SET valor = valor * 0.5
WHERE nome = 'BF 1';

UPDATE jogo SET valor = valor * 0.5
WHERE nome = 'COD 3';

SELECT * FROM jogo;

/* Criar uma tabela 'Promoção'*/

CREATE TABLE promocao (
    Promo INT(3) PRIMARY KEY AUTO_INCREMENT,
    Cod_Jogo INT(3) NOT NULL,
    FOREIGN KEY (Cod_Jogo)
        REFERENCES Jogo (Cod)
);

/* inserção dos jogos em promoção */
INSERT promocao VALUES (0,1),(0,2);


SELECT * FROM promocao;

/* Selecionar os jogos em promoção */
SELECT jogo.nome, jogo.valor
FROM jogo
WHERE jogo.cod IN (SELECT cod_jogo FROM promocao);

    
    
/* ...ou utilizando JOIN.... */    
    
SELECT 
    jogo.nome AS 'Título',
    jogo.valor AS 'Preço'
FROM
    jogo INNER JOIN promocao ON jogo.cod = promocao.cod_jogo;



/* Selecionar os jogos que NÃO estão em promoção */
SELECT jogo.nome, jogo.valor
FROM jogo
WHERE jogo.cod NOT IN (SELECT cod_jogo FROM promocao);
            
/* selecionar o jogo mais barato utilizando subconsultas e funções de agregação*/


























INSERT promocao VALUES 
(0, 1),
(0, 2);

SELECT * FROM promocao;

/* Selecionar os jogos em promoção */
SELECT 
    jogo.nome AS 'Título',
    jogo.valor AS 'Preço'
FROM
    jogo
WHERE
    jogo.COD IN (SELECT Cod_Jogo FROM promocao);
    
    
/* ...ou utilizando JOIN.... */    
    
SELECT 
    jogo.nome AS 'Título',
    jogo.valor AS 'Preço'
FROM
    jogo INNER JOIN promocao ON jogo.cod = promocao.cod_jogo;



/* Selecionar os jogos que NÃO estão em promoção */
SELECT 
    jogo.nome AS 'Título', jogo.valor AS 'Preço'
FROM
    jogo
WHERE
    jogo.COD NOT IN (SELECT 
            Cod_Jogo
        FROM
            promocao);
            
/* selecionar o jogo mais barato utilizando subconsultas e funções de agregação*/

SELECT nome AS 'mais barato!' 
FROM jogo WHERE valor = SOME (SELECT MIN(valor) FROM jogo);
            
























