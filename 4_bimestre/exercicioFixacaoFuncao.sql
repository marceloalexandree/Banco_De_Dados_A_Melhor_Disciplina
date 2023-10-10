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

/*Funções de Controle de Fluxo*/

SELECT produto, IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS estoque FROM produtos;

SELECT produto, 
	CASE
        WHEN preco < 25.00 THEN 'Barato'
        WHEN preco >= 25.00 AND preco < 50.00 THEN 'Médio'
        ELSE 'Caro'
    END 
    AS categoria FROM produtos;


/*Função Personalizada*/

DELIMITER //
CREATE FUNCTION TOTAL_VALOR(preco DECIMAL(10, 3), quantidade SMALLINT)
RETURNS DECIMAL(10, 3) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 3);
    SET total = preco * quantidade;
    RETURN total;
END;
// DELIMITER ;

SELECT produto, TOTAL_VALOR(preco, quantidade) AS total FROM produtos;


/*Funções de Agregação*/

SELECT COUNT(*) AS qtd_produtos FROM produtos;

SELECT produto, MAX(preco) AS preco FROM produtos GROUP BY produto;

SELECT produto, MIN(preco) AS preco FROM produtos GROUP BY produto;

SELECT SUM(IF(quantidade > 0, quantidade, 0)) AS qtd_estoque FROM produtos;

/*Criando funções*/

DELIMITER //
CREATE FUNCTION fatorial(numero INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE resultado INT DEFAULT 1;
    DECLARE contador INT;
    SET contador = numero;
    WHILE contador > 1 DO
        SET resultado = resultado * contador;
        SET contador = contador - 1;
    END WHILE;
    RETURN resultado;
END;
// DELIMITER ;

CREATE FUNCTION exponecial(numero INT, expoente INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = numero;
    WHILE expoente > 1 DO
        SET resultado = resultado * numero;
        SET expoente = expoente - 1;
    END WHILE;
    RETURN resultado;
END;
// DELIMITER ;
