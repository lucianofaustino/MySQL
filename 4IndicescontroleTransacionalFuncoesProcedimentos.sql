/*
Contextualização
• Visões e índices
• Controle transacional
• Procedimentos e funções
*/


--• Visões e índices
CREATE DATABASE litoral;
USE litoral;


CREATE TABLE escuna (
	numero INT PRIMARY KEY,
    nome VARCHAR(30),
    capitao_cpf CHAR(11)
);

CREATE TABLE destino (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30)
);

CREATE TABLE passeio (
	id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE,
    hora_saida TIME,
    hora_chegada TIME,
    escuna_numero INT,
    destino_id INT,
	FOREIGN KEY(escuna_numero) REFERENCES escuna(numero),
    FOREIGN KEY(destino_id) REFERENCES destino(id)
);

INSERT INTO escuna VALUES
(12345, "Black Flag","88888888899"),
(12346, "Caveira","66666666677"),
(12347, "Brazuca","44444444455"),
(12348, "Rosa Brilhante 1","12345678900"),
(12349, "Tubarão Ocean","22222222233"),
(12340, "Rosa Brilhante 2","12345678900");

INSERT INTO destino VALUES
(0, "Ilha Dourada"),
(0, "Ilha D'areia fina"),
(0, "Ilha Encantada"),
(0, "Ilha dos Ventos"),
(0, "Ilhinha"),
(0, "Ilha Torta"),
(0, "Ilha dos Sonhos"),
(0, "Ilha do Sono");

INSERT INTO passeio VALUES
(0,20180102,080000,140000,12345,1),
(0,20180102,070000,170000,12346,8),
(0,20180102,080000,140000,12340,3),
(0,20180103,060000,120000,12347,2),
(0,20180103,070000,130000,12348,4),
(0,20180103,080000,140000,12349,6),
(0,20180103,090000,150000,12345,5),
(0,20180104,070000,160000,12347,1),
(0,20180104,070000,170000,12345,3),
(0,20180104,090000,130000,12349,7),
(0,20180105,100000,180000,12340,8),
(0,20180105,090000,130000,12347,7);


SELECT * FROM escuna;
SELECT * FROM destino;
SELECT * FROM passeio;


-- Criação da consulta com o nome da escuna, destino, horas de saída e chegada, e data do passeio

SELECT escuna.nome AS "Escuna", 
    destino.nome AS "Ilha", 
    hora_saida AS "Saida", 
    hora_chegada AS "Chegada", 
    Data    
FROM passeio INNER JOIN escuna
	ON passeio.escuna_numero = escuna.numero 
INNER JOIN destino
	ON passeio.destino_id = destino.id
ORDER BY passeio.data;

-- Ou a mesma consulta com apenas um INNER JOIN, mas com a cláusula WHERE e o conectivo AND
    
SELECT 
	escuna.nome AS "Escuna", 
    destino.nome AS "Ilha", 
    hora_saida AS "Saida", 
    hora_chegada AS "Chegada", 
    Data
FROM passeio INNER JOIN escuna, destino
WHERE passeio.escuna_Numero = escuna.numero AND 
		passeio.destino_ID = destino.id
	ORDER by passeio.data;
    
    
    
-- Criação da VIEW ---------------------------------------
    
CREATE VIEW v_consulta AS
	SELECT escuna.nome AS "Escuna", 
		destino.nome AS "Ilha", 
		hora_saida AS "Saida", 
		hora_chegada AS "Chegada", 
		Data    
	FROM passeio INNER JOIN escuna
		ON passeio.escuna_numero = escuna.numero 
	INNER JOIN destino
		ON passeio.destino_id = destino.id
	ORDER BY passeio.data;
    
-- ver as tabelas e a VIEW (tabela virtual)
SHOW TABLES;

-- consultar a VIEW (tabela virtual)
SELECT * FROM v_consulta;

-- apagar a VIEW
DROP VIEW v_consulta;



-- Segunda parte do conteúdo:

--• Controle transacional
USE litoral;
SELECT * FROM destino;

/* Configurar o ambiente para que as alterações não sejam gravadas automaticamente 
Controle transacional MANUAL (SET AUTOCOMMIT = 0;) 
Controle transacional AUTOMÁTICO (SET AUTOCOMMIT = 1;) */
SET AUTOCOMMIT = 0;

/* Para criar um ponto de restauração no banco*/
SAVEPOINT ponto1;


/* Para fins de teste, o script a seguir visará gerar o mesmo
erro cometido pelo colaborador:*/
UPDATE destino SET Nome = "Pequena Ilha do Mar"; 

SELECT * FROM destino; -- consulta exibe a tabela após o "erro" cometido no UPDATE


/* Utilizar o ponto de restauração criado e testá-lo */
ROLLBACK TO SAVEPOINT ponto1;

SELECT * FROM destino; -- consulta exibe a tabela como estava antes do "erro" cometido no UPDATE


/* Agora alterando corretamente, somente o registro 5.
E para GRAVAR as alterações feitas, deve ser utilizado o comando COMMIT após o Update (já que o AUTOCOMMIT = 0)*/
UPDATE destino SET Nome = "Pequena Ilha do Mar"
WHERE id = 5;

COMMIT;

SELECT * FROM destino;

/* Crie um novo ponto de restauração, pois o COMMIT apaga os pontos de restauração anteriores */

SAVEPOINT ponto2;


-- terceira parte do conteúdo:
--• Procedimentos e funções
CREATE TABLE vendas (
	Numero int PRIMARY KEY AUTO_INCREMENT,
    DestinoId INT,
    Embarque DATE,
    Qtd INT,
    FOREIGN KEY (DestinoId) REFERENCES destino(id)
);

SELECT * FROM destino;

INSERT INTO vendas VALUES
(0,1,20180203,3),
(0,7,20180203,2),
(0,5,20180203,1);

ALTER TABLE destino ADD COLUMN Valor DECIMAL(5,2);

SELECT * FROM  destino;

UPDATE destino SET valor = 100 WHERE id=1;
UPDATE destino SET valor = 120 WHERE id=2;
UPDATE destino SET valor = 80 WHERE id=3;
UPDATE destino SET valor = 90 WHERE id=4;
UPDATE destino SET valor = 100 WHERE id=5;
UPDATE destino SET valor = 150 WHERE id=6;
UPDATE destino SET valor = 120 WHERE id=7;
UPDATE destino SET valor = 180 WHERE id=8;
SELECT * FROM destino;

-- Criar função
CREATE FUNCTION fn_desc(x DECIMAL(5,2), y INT)
RETURNS DECIMAL(5,2)
RETURN ((x*y)*0.7);

SHOW FUNCTION STATUS WHERE db = 'litoral';

SELECT * FROM vendas;

CREATE PROCEDURE proc_desc (VAR_VendaNumero INT)
	SELECT 
		(fn_desc(destino.valor, Vendas.Qtd)) AS "Valor com desconto", 
        destino.Nome AS "Destino",
		vendas.Qtd AS "Passagens", 
		vendas.Embarque
	FROM Vendas INNER JOIN destino
	ON Vendas.DestinoId = destino.Id
	WHERE vendas.Numero = var_VendaNumero;

CALL proc_desc(1);
CALL proc_desc(2);
CALL proc_desc(3);

SHOW FUNCTION STATUS WHERE db = 'litoral';

SHOW PROCEDURE STATUS WHERE db = 'litoral';

DROP FUNCTION fn_desc;

DROP PROCEDURE proc_desc;
















