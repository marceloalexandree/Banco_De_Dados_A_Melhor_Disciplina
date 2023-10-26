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
