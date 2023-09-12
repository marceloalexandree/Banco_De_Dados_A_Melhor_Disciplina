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

DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN
	SELECT Categoria.Nome, COUNT(*) AS qtd_livros FROM Livro INNER JOIN Categoria ON Categoria.Categoria_ID = Livro.Categoria_ID WHERE Categoria.Nome = Nome_Categoria GROUP BY Nome;
END;
// DELIMITER ;
CALL sp_ContarLivrosPorCategoria('Autoajuda'); /*Exercício 3*/
