DELIMITER // /*Exercício 1*/
CREATE PROCEDURE sp_ListarAutores()
BEGIN
	SELECT Nome FROM Autor;
END;
// DELIMITER ;
CALL sp_ListarAutores(); /*Exercício 1*/


DELIMITER // /*Exercício 2*/
CREATE PROCEDURE sp_LivrosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN
	SELECT Titulo FROM Livro INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID AND Categoria.Nome = Nome_Categoria;
END;
// DELIMITER ;
CALL sp_LivrosPorCategoria('Romance'); /*Exercício 2*/


DELIMITER // /*Exercício 3*/
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN
	SELECT Categoria.Nome, COUNT(*) AS qtd_livros FROM Livro INNER JOIN Categoria ON Categoria.Categoria_ID = Livro.Categoria_ID WHERE Categoria.Nome = Nome_Categoria GROUP BY Nome;
END;
// DELIMITER ;
CALL sp_ContarLivrosPorCategoria('Autoajuda'); /*Exercício 3*/


DELIMITER // /*Exercício 4*/
DROP PROCEDURE sp_VerificarLivrosCategoria;
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN Nome_Categoria VARCHAR(100), OUT Possui_Livros VARCHAR(25))
BEGIN
	DECLARE qtd_livros INT;
	SELECT COUNT(*) INTO qtd_livros FROM Livro INNER JOIN Categoria ON Categoria.Categoria_ID = Livro.Categoria_ID WHERE Categoria.Nome = Nome_Categoria GROUP BY Nome;
    SET qtd_livros = qtd_livros;
    IF qtd_livros > 0 THEN
		SET Possui_Livros = 'Possui Livros';
	ELSE
		SET Possui_Livros = 'Não Possui Livros';
	END IF;
END;
// DELIMITER ;
CALL sp_VerificarLivrosCategoria('Autoajuda', @Possui_Livros);
SELECT @Possui_Livros; /*Exercício 4*/


DELIMITER // /*Exercício 5*/
CREATE PROCEDURE sp_LivrosAteAno(ano INT)
BEGIN
	SELECT Titulo FROM Livro WHERE Ano_Publicacao = ano;
END;
// DELIMITER ;
CALL sp_LivrosAteAno('2005'); /*Exercício 5*/


DELIMITER // /*Exercício 6*/
CREATE PROCEDURE sp_TitulosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN
	SELECT Livro.Titulo FROM Livro INNER JOIN Categoria WHERE Categoria.Categoria_ID = Livro.Categoria_ID AND Categoria.Nome = Nome_Categoria;
END;
// DELIMITER ;
CALL sp_TitulosPorCategoria('Romance'); /*Exercício 6*/


DELIMITER // /*Exercício 7*/
DROP PROCEDURE sp_AdicionarLivro;
CREATE PROCEDURE sp_AdicionarLivro(IN Nome_Livro VARCHAR(100))
BEGIN
	DECLARE qtd_livros INT;
    SELECT COUNT(Titulo) INTO qtd_livros FROM Livro WHERE Nome_Livro = Titulo;
	IF qtd_livros = 0 THEN
		INSERT INTO Livro (Titulo) VALUES (Nome_Livro);
	ELSE
		SELECT Titulo FROM Livro WHERE Titulo = Nome_Livro;
	END IF;
END;
// DELIMITER ;
CALL sp_AdicionarLivro('Marcelo Gostoso'); /*Exercício 7*/
