/* 1- Procedure para Inserir um registro na Tabela Peça, usando parâmetros; */
DELIMITER //

CREATE PROCEDURE inserir_peca (
	IN Cod_Peca char(2),
	IN Nome_Peca varchar(10),
    IN Cor_Peca varchar(10),
    IN Peso_Peca int,
    IN Cidade_Peca varchar(20)
	)
BEGIN 
	INSERT INTO Pecas (CodPeca, NomePeca, CorPeca, PesoPeca, CidadePeca) VALUES
	(Cod_Peca, Nome_Peca, Cor_Peca, Peso_Peca, Cidade_Peca);
END //

DELIMITER ;

CALL inserir_peca ("P4", "Sapata", "Prata", 25, "Suzano");

SELECT * FROM Pecas;

/* 2- Procedure para Inserir 5000 registros distintos na Tabela Peça; */
DELIMITER //

CREATE PROCEDURE inserir_n_pecas (IN qtd_registro INT)
BEGIN
	DECLARE i INT;
	SET i = 5;
	WHILE i <= qtd_registro + 5 DO
		INSERT INTO Pecas (CodPeca, NomePeca, CorPeca, PesoPeca, CidadePeca) 
		VALUES (
			CONCAT('P', CAST(i AS CHAR)), -- CodPeca
			CONCAT('Peca_', i), -- NomePeca
			'Preto', -- CorPeca
			i, -- PesoPeca
			'Sao Paulo' -- CidadePeca
		);	
		SET i = i + 1;
	END WHILE;
END //
DELIMITER ; 

CALL inserir_n_pecas(5000);
