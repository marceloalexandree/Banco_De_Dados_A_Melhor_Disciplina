/*Função para Contagem de Livros por Gênero*/

DELIMITER //
CREATE FUNCTION total_livros_por_genero(genero_nome VARCHAR(255)) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE fechar INT;
    DECLARE titulo VARCHAR(255);
    DECLARE genero_id INT;
    DECLARE total_livros INT DEFAULT 0;

    DECLARE cursor_livros CURSOR FOR SELECT livro.titulo, livro.id_genero FROM Livro INNER JOIN Genero ON Livro.id_genero = Genero.id WHERE Genero.nome_genero = genero_nome;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fechar = 0;

    OPEN cursor_livros;

    livros_loop: LOOP
        FETCH cursor_livros INTO titulo, genero_id;

        IF fechar = 0 THEN
            LEAVE livros_loop;
        END IF;

        SET total_livros = total_livros + 1;
    END LOOP livros_loop;

    CLOSE cursor_livros;

    RETURN total_livros;
END;
//
DELIMITER ;

/*Função para Listar Livros de um Autor Específico*/
DELIMITER //
CREATE FUNCTION listar_livros_por_autor(primeiro_nome_autor VARCHAR(255), ultimo_nome_autor VARCHAR(255)) RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE fechar INT;
    DECLARE x_titulo_livro TEXT;
    DECLARE lista_titulos TEXT DEFAULT '';
    
    DECLARE cursor_livros_autor CURSOR FOR SELECT livro.titulo FROM Livro INNER JOIN Livro_Autor ON Livro.id = Livro_Autor.id_livro INNER JOIN Autor ON Livro_Autor.id_autor = Autor.id WHERE Autor.primeiro_nome = primeiro_nome_autor AND Autor.ultimo_nome = ultimo_nome_autor;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fechar = 0;

    OPEN cursor_livros_autor;

    livros_loop: LOOP
        FETCH cursor_livros_autor INTO x_titulo_livro;

        IF fechar = 0 THEN
            LEAVE livros_loop;
        END IF;

        IF lista_titulos <> '' THEN
            SET lista_titulos = CONCAT(lista_titulos, ', ', x_titulo_livro);
        ELSE
            SET lista_titulos = x_titulo_livro;
        END IF;
    END LOOP livros_loop;

    CLOSE cursor_livros_autor;

    RETURN lista_titulos;
END;
//
DELIMITER ;

/*Função para Atualizar Resumos de Livros*/
DELIMITER //
CREATE FUNCTION atualizar_resumos() RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE fechar INT;
    DECLARE x_id INT;
    DECLARE x_resumo TEXT;
    
    DECLARE cursor_livros CURSOR FOR SELECT id, resumo FROM Livro;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fechar = 0;
    
    OPEN cursor_livros;
    
    livros_loop: LOOP
        FETCH cursor_livros INTO x_id, x_resumo;
        
        IF fechar = 0 THEN
            LEAVE livros_loop;
        END IF;
        
        SET x_resumo = CONCAT(x_resumo, ' Este é um excelente livro!');
        
        UPDATE Livro SET resumo = x_resumo WHERE id = x_id;
    END LOOP livros_loop;
    
    CLOSE cursor_livros;
    RETURN 'Resumos atualizados';
END;
//
DELIMITER ;

/*Função para Obter a Média de Livros por Editora*/
DELIMITER //
CREATE FUNCTION media_livros_por_editora()
RETURNS DECIMAL(10,3)
DETERMINISTIC
BEGIN
    DECLARE fechar INT;
    DECLARE x_livro INT DEFAULT 0;
    DECLARE x_editora INT DEFAULT 0;
    DECLARE media_livros_por_editora DECIMAL(10,3) DEFAULT 0;
    
    DECLARE cursor_editora CURSOR FOR SELECT id FROM Editora;
    
	DECLARE cursor_livro CURSOR FOR SELECT COUNT(*) FROM Livro WHERE id_editora = x_editora;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fechar = 0;
    
    OPEN cursor_editora;
    editora_loop: LOOP
        FETCH cursor_editora INTO x_editora;
        IF fechar = 0 THEN
            LEAVE editora_loop;
        END IF;
        
        OPEN cursor_livro;
			FETCH cursor_livro INTO x_livro;
        CLOSE cursor_livro;
        
        SET media_livros_por_editora = media_livros_por_editora + (x_livro / (SELECT COUNT(*) FROM Editora));
    END LOOP editora_loop;
    
    CLOSE cursor_editora;
    
    RETURN media_livros_por_editora;
END;
//
DELIMITER ;

/*Função para Listar Autores sem Livros Publicados*/
DELIMITER //
CREATE FUNCTION autores_sem_livros()
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE fechar INT;
    DECLARE contagem_autor INT;
    DECLARE lista_autores VARCHAR(255);

    DECLARE cursor_autor CURSOR FOR SELECT id FROM Autor;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fechar = 0;
    
    OPEN cursor_autor;
    autor_loop: LOOP
        FETCH cursor_autor INTO contagem_autor;
        IF fechar = 0 THEN
            LEAVE autor_loop;
        END IF;
        IF (SELECT COUNT(*) FROM Livro_Autor WHERE id_autor = contagem_autor) = 0 THEN
            SET lista_autores = CONCAT(lista_autores, (SELECT CONCAT(primeiro_nome, ultimo_nome) FROM Autor WHERE id = contagem_autor), ',');
        END IF;
    END LOOP;
    
    CLOSE cursor_autor;
    
    RETURN lista_autores;
END
//
DELIMITER ;
