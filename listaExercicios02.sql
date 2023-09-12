DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
	SELECT Nome FROM Autor;
END;
// DELIMITER ;
CALL sp_ListarAutores(); /*Exercício 1*/

DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN
	SELECT Titulo FROM Livro INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID AND Categoria.Nome = Nome_Categoria;
END;
// DELIMITER ;
CALL sp_LivrosPorCategoria('Romance'); /*Exercício 2*/

