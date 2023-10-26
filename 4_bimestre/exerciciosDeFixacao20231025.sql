/*Exercício 1*/
CREATE TRIGGER before_clientes_insert 
    	BEFORE INSERT ON Clientes
	FOR EACH ROW 
INSERT INTO Auditoria (mensagem, data_hora) VALUES ('Clientes atualizados', now());

/*Exercício 2*/
CREATE TRIGGER after_clientes_delete
	AFTER DELETE ON Clientes
	FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES ('Tentativa de exclusão');

/*Exercício 3*/
CREATE TRIGGER before_clientes_update
	BEFORE UPDATE ON Clientes
	FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES (concat("Antigo: ", old.nome, "Novo: ", new.nome));

/*Exercício 4*/
DELIMITER //
CREATE TRIGGER not_null_clientes
	BEFORE UPDATE ON Clientes
	FOR EACH ROW
	IF new.nome is NULL or new.nome = '' THEN
		UPDATE Clientes SET nome = old.nome;
		INSERT INTO Auditoria (mensagem) VALUES ('Cliente Nulo');
	END IF;
//
DELIMITER ;

/*Exercício 5*/
DELIMITER //
CREATE TRIGGER before_pedidos_insert
	BEFORE INSERT ON Pedidos
    	FOR EACH ROW
    	UPDATE Produtos SET estoque = estoque - new.quantidade WHERE id = new.produto_id;
    	DECLARE x_estoque INT;
    	SET x_estoque = (SELECT estoque FROM Produtos WHERE id = NEW.produto_id);
    	IF x_estoque < 5 THEN
		INSERT INTO Auditoria (mensagem) VALUES ('Estoque acabando')
	END IF;
//
DELIMITER ;
