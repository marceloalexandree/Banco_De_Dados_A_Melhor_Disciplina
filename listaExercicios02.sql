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


DELIMITER // /*Exercício 3*/
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN
	SELECT Categoria.Nome, COUNT(*) AS qtd_livros FROM Livro INNER JOIN Categoria ON Categoria.Categoria_ID = Livro.Categoria_ID WHERE Categoria.Nome = Nome_Categoria GROUP BY Nome;
END;
// DELIMITER ;
CALL sp_ContarLivrosPorCategoria('Autoajuda'); /*Exercício 3*/


DELIMITER // 
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


DELIMITER // 
CREATE PROCEDURE sp_LivrosAteAno(ano INT)
BEGIN
	SELECT Titulo FROM Livro WHERE Ano_Publicacao = ano;
END;
// DELIMITER ;
CALL sp_LivrosAteAno('2005'); /*Exercício 5*/


DELIMITER // 
CREATE PROCEDURE sp_TitulosPorCategoria(IN Nome_Categoria VARCHAR(100))
BEGIN
	SELECT Livro.Titulo FROM Livro INNER JOIN Categoria WHERE Categoria.Categoria_ID = Livro.Categoria_ID AND Categoria.Nome = Nome_Categoria;
END;
// DELIMITER ;
CALL sp_TitulosPorCategoria('Romance'); /*Exercício 6*/


DELIMITER // 
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


DELIMITER // /*Delimitador: restringe o início e fim da procedure*/
CREATE PROCEDURE sp_AutorAntigo() /*Criação da procedure*/
BEGIN /*Marca o início do que a procedure irá executar*/
	SELECT Nome FROM Autor ORDER BY Data_Nascimento LIMIT  1; /*Faz uma consulta do atributo Nome da tabela Livro ordenando do pelo atributo Data_Nascimento e retornando apenas o mais velho*/
END; /*Marca o fim do que a procedure irá executar*/
// DELIMITER ; /*Delimitador: restringe o início e fim da procedure*/
CALL sp_AutorAntigo(); /*Chamada da procedure criada*/ /*Exercício 8*/

/*Exercício 9 - Explicação do Exercício 8*/

DELIMITER // 
CREATE PROCEDURE sp_LivrosESeusAutores()
BEGIN
	SELECT Livro.Titulo, Autor.Nome, Autor.Sobrenome FROM Livro INNER JOIN Autor_Livro INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID AND Livro.Livro_ID = Autor_Livro.Livro_ID;
END;
// DELIMITER ;
CALL sp_LivrosESeusAutores(); /*Exercício 10*/
