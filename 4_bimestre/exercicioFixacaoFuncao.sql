/*Funções de String*/

CREATE TABLE nomes(
	nome VARCHAR(255)
);
INSERT INTO nomes (nome) VALUES
('Roberta'),
('Roberto'),
('Maria Clara'),
('João');

SELECT UPPER(nome) AS nomes FROM nomes;

SELECT nome, LENGTH(nome) AS tamanho FROM nomes;

SELECT CONCAT(IF(nome = 'Roberto' or nome = 'João', 'Sr. ', 'Sra. '), nome) AS nome FROM nomes;


/*Funções Numéricas*/

CREATE TABLE produtos(
	produto VARCHAR(255), preco DECIMAL(10,3), quantidade SMALLINT
);

SELECT produto, ROUND(preco, 2) AS preco FROM produtos;

SELECT produto, ABS(quantidade) AS quantidade FROM produtos;

SELECT produto, AVG(preco) AS media FROM produtos GROUP BY produto;


/*Funções de Data*/

CREATE TABLE eventos (
    data_evento DATE
);
INSERT INTO eventos (data_evento) VALUES
('2006-09-29'),
('2006-07-02'),
('2007-01-01'),
('2006-09-26'),
('2023-10-09');

INSERT INTO eventos (data_evento) VALUES (NOW());

SELECT MIN(data_evento) AS evento1, MAX(data_evento) AS evento2, DATEDIFF(MAX(data_evento), MIN(data_evento)) AS tempo FROM eventos;

SELECT data_evento, DAYNAME(data_evento) AS semana FROM eventos;
