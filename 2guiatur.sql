CREATE DATABASE IF NOT EXISTS guiatur
	DEFAULT CHARSET = utf8
    DEFAULT COLLATE = utf8_general_ci;
    
SHOW CREATE DATABASE guiatur;

USE guiatur;

CREATE TABLE IF NOT EXISTS pais (
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL DEFAULT '',
	continente ENUM('Ásia', 'Europa', 'América', 'África',
	'Oceania', 'Antártida') NOT NULL DEFAULT 'América',
	codigo CHAR(3) NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS estado (
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL DEFAULT '',
	sigla CHAR(2) NOT NULL DEFAULT ''
);
CREATE TABLE IF NOT EXISTS cidade (
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL DEFAULT '',
	populacao INT(11) NOT NULL DEFAULT '0'
);
CREATE TABLE IF NOT EXISTS ponto_tur (
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL DEFAULT '',
	tipo ENUM('Atrativo', 'Serviço', 'Equipamento',
	'Infraestrutura', 'Instituição', 'Organização'),
	publicado ENUM('Não', 'Sim') NOT NULL DEFAULT 'Não'
);

CREATE TABLE coordenada (
	latitude FLOAT(10,6),
    longitude FLOAT(10,6)
);

USE guiatur;
SHOW TABLES FROM guiatur;
DESCRIBE pais;

INSERT INTO pais (nome, continente, codigo)
VALUES
('Brasil', 'América', 'BRA'),
('Índia', 'Ásia', 'IDN'),
('China', 'Ásia', 'CHI'),
('Japão', 'Ásia', 'JPN');

SELECT * FROM pais;

describe estado;
INSERT INTO estado (nome, sigla)
VALUES('Maranhão', 'MA'),
('São Paulo', 'SP'),
('Santa Catarina', 'SC'),
('Rio de Janeiro', 'RJ');

SELECT * FROM estado;

INSERT INTO cidade (nome, populacao)
values('Sorocaba', 700000),
('Déli', 26000000),
('Xangai', 22000000),
('Tóquio', 38000000);

SELECT * FROM cidade;

INSERT INTO ponto_tur (nome, tipo)
VALUES('Quinzinho de Barros', 'Instituição'),
('Parque Estadual do Jalapão', 'Atrativo'),
('Torre Eiffel', 'Atrativo'),
('Fogo de Chão', 'Serviço');
Describe ponto_tur;
SELECT * FROM ponto_tur;


-- alterar para atrativo o primeiro ponto turístico
UPDATE ponto_tur SET tipo = 'Atrativo'
WHERE id = 1;

-- alterar o segundo país (Índia) para ter o cód. 'IND'
SELECT * FROM pais;
UPDATE pais SET codigo = 'IND'
WHERE id = 2;

-- deletar a primeira cidade
SELECT * FROM cidade;
DELETE FROM cidade WHERE id = 1;

USE guiatur;

/* determinados países terem mais de
um idioma, embora um seja determinado como o idioma oficial.
Nessa relação, temos a cardinalidade de 1 para N */

CREATE TABLE IF NOT EXISTS linguagemPais (
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	codigoPais INT(11),
	linguagem VARCHAR(30) NOT NULL DEFAULT '',
	oficial ENUM('Sim', 'Não') NOT NULL DEFAULT'Não'
);
DESCRIBE pais;

/*Criar integridade referencial antre as tebelas linguagemPais e país*/
ALTER TABLE linguagempais ADD CONSTRAINT FK_linguagempais
FOREIGN KEY (codigoPais) REFERENCES pais(id);
DESCRIBE linguagempais;

/*Modificar o código do país para ser obrigatória a inclusão*/
ALTER TABLE linguagempais MODIFY codigoPais INT(11) NOT NULL;

SHOW TABLES FROM guiatur;
DESCRIBE pais;
SELECT * FROM pais;

/*Teste de exclusão - inserindo dados na tabela com chave estrangeira*/
INSERT INTO linguagempais VALUES (0,4,'japones','sim');
SELECT * FROM linguagempais;
DROP TABLE pais;

/*Excluir a restrição de chave estrangeira e tabela*/
ALTER TABLE linguagemPais DROP FOREIGN KEY FK_linguagemPais;
/*agora a tabela país pode ser excluída*/
DROP TABLE pais; 


/*listar todas as constraints do banco*/
SELECT *
FROM information_schema.key_column_usage
WHERE constraint_schema='guiatur';

SHOW TABLES;

-- Alterar tabela de Elementos Turísticos, adicionando campos latitude e longitude. 
DESCRIBE ponto_tur;
ALTER TABLE ponto_tur ADD coordenada POINT;
DROP TABLE coordenada;


-- Alterar a tabela “Países”, adicionando uma nota de 0 a 10 com o nível de interesse para o turista ('0','1','2','3','4','5','6','7','8','9','10')
ALTER TABLE pais ADD interesse ENUM('0','1','2','3','4','5','6','7','8','9','10');

-- Alterar tabela “Cidades”, incluindo uma lista com os três melhores restaurantes. 
ALTER TABLE cidade ADD melhoresRest VARCHAR(300) DEFAULT '';




INSERT INTO ponto_tur (nome, coordenada) 
VALUES ('Ponte da Amizade',POINT(1.123456,3.434343)); 

SELECT * FROM ponto_tur;
SELECT *, AsText(coordenada) FROM ponto_tur;






















