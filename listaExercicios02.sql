DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
	SELECT Nome FROM Autor;
END;
// DELIMITER ;
CALL sp_ListarAutores(); /*Exercício 1*/
