CREATE DATABASE FABRICA;
USE FABRICA;

CREATE TABLE Pecas (
	CodPeca char(2),
    NomePeca varchar(10),
    CorPeca varchar(10),
    PesoPeca int,
    CidadePeca varchar(20)
);

ALTER TABLE Pecas ADD CONSTRAINT PK_Pecas PRIMARY KEY (CodPeca);

CREATE TABLE Fornecedores (
	CodFornec char(5),
    NomeFornec varchar(10),
    StatusFornec int,
    CidadeFornec varchar(20)
);

ALTER TABLE Fornecedores ADD CONSTRAINT PK_Fornecedores PRIMARY KEY (CodFornec);

CREATE TABLE Embarcados (
	CodPeca char(2),
	CodFornec char(2),
    QtdEmbarc int
);

ALTER TABLE Embarcados ADD CONSTRAINT PK_Embarcados PRIMARY KEY (CodPeca, COdFornec);

ALTER TABLE Embarcados ADD CONSTRAINT FK_Embarcados_Pecas FOREIGN KEY (CodPeca) REFERENCES Pecas(CodPeca);
ALTER TABLE Embarcados ADD CONSTRAINT FK_Embarcados_Fornecedores FOREIGN KEY (CodFornec) REFERENCES Fornecedores(CodFornec);

INSERT INTO Pecas (CodPeca, NomePeca, CorPeca, PesoPeca, CidadePeca) VALUES
('P1', 'Eixo', 'Cinza', 10, 'Poa'),
('P2', 'Rolamento', 'Preto', 16, 'Rio'),
('P3', 'Mancal', 'Verde', 30, 'Sao Paulo');

INSERT INTO Fornecedores (CodFornec, NomeFornec, StatusFornec, CidadeFornec) VALUES
('F1', 'Silva', 5, 'Sao Paulo'),
('F2', 'Souza', 10, 'Rio'),
('F3', 'Alvares', 5, 'Sao Paulo'),
('F4', 'Tavares', 8, 'Rio');

INSERT INTO Embarcados (CodPeca, CodFornec, QtdEmbarc) VALUES
('P1', 'F1', 300),
('P1', 'F2', 400),
('P1', 'F3', 200),
('P2', 'F1', 300),
('P2', 'F4', 350);

/* 1) Obter o número de fornecedores na base de dados */
SELECT COUNT(CodFornec) FROM Fornecedores;

/* 2) Obter o número de cidades em que há fornecedores  */
SELECT COUNT(DISTINCT CidadeFornec) FROM Fornecedores;

/* 3) Obter o número de fornecedores com cidade informada */
SELECT COUNT(CidadeFornec) FROM Fornecedores;

/* 4) Obter a quantidade máxima embarcada */
SELECT MAX(QtdEmbarc) FROM Embarcados;

/* 5) Obter o número de embarques de cada fornecedor */
SELECT CodFornec, COUNT(CodFornec) FROM Embarcados GROUP BY CodFornec;
 
/* 6) Obter o número de embarques de quantidade maior que 300 de cada 
fornecedor */
SELECT CodFornec, COUNT(QtdEmbarc) FROM Embarcados WHERE QtdEmbarc > 300 GROUP BY CodFornec;
  
/* 7) Obter a quantidade total embarcada de peças de cor cinza para cada fornecedor */
SELECT SUM(QtdEmbarc) FROM Embarcados WHERE CodPeca IN (SELECT CodPeca FROM Pecas WHERE CorPeca = "Cinza");
 
/* 8) Obter o quantidade total embarcada de peças para cada fornecedor. Exibir o 
resultado por ordem descendente de quantidade total embarcada. */
SELECT CodFornec, SUM(QtdEmbarc) AS TOTAL FROM Embarcados GROUP BY CodFornec ORDER BY TOTAL DESC;
 
/* 9) Obter os códigos de fornecedores que tenham embarques de mais de 500 unidades 
de peças cinzas, junto com a quantidade de embarques de peças cinzas */
SELECT CodFornec, SUM(QtdEmbarc) AS TOTAL FROM Embarcados WHERE CodPeca IN (SELECT CodPeca FROM Pecas WHERE CorPeca = "Cinza") GROUP BY CodFornec HAVING TOTAL > 500; 
    