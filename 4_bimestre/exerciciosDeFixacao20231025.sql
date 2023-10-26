/*Exercício 1*/
CREATE TRIGGER before_clientes_insert 
    BEFORE INSERT ON Clientes
    FOR EACH ROW 
	INSERT INTO Auditoria (mensagem, data_hora) VALUES ('Clientes atualizados', now());
