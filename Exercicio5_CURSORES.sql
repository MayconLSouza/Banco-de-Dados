-- Criando database

CREATE DATABASE FACULDADE;
USE FACULDADE;

-- Criando tabelas

CREATE TABLE Depto (
	CodDepto char(5),
	NomeDepto varchar(40)
);

CREATE TABLE Disciplina (
	CodDepto char(5),
	NumDisc int4,
	NomeDisc varchar(10),
	CreditosDisc int4
);

CREATE TABLE PreReq (
	CodDepto char(5),
	NumDisc int4,
	CodDeptoPreReq char(5),
	NumDiscPreReq int4
);

CREATE TABLE Turma (
	AnoSem int4,
	CodDepto char(5),
	NumDisc int4,
	SiglaTur char(2),
	CapacTur int4
);

CREATE TABLE Horario (
	AnoSem int4,
	CodDepto char(5),
	NumDisc int4,
	SiglaTur char(2),
	DiaSem int4,
	HoraInicio int4,
	NumHoras int4,
	CodPred int4,
	NumSala int4
);

CREATE TABLE Predio (
	CodPred int4,
	NomePred varchar(40)
);

CREATE TABLE Sala (
	CodPred int4,
	NumSala int4,
	DescricaoSala varchar(10),
	CapacSala int4
);

CREATE TABLE Professor (
	CodProf int4,
	NomeProf varchar(40),
	CodTit int4,
	CodDepto varchar(40)
);

CREATE TABLE ProfTurma (
	AnoSem int4,
	CodDepto char(5),
	NumDisc int4,
	SiglaTur char(2),
	CodProf int4
);

CREATE TABLE Titulacao (
	CodTit int4,
	NomeTit varchar(40)
);

-- Chaves primarias

ALTER TABLE Depto ADD CONSTRAINT PK_Depto PRIMARY KEY (CodDepto);
ALTER TABLE Disciplina ADD CONSTRAINT PK_Disciplina PRIMARY KEY (CodDepto, NumDisc);
ALTER TABLE PreReq ADD CONSTRAINT PK_PreReq PRIMARY KEY (CodDeptoPreReq, NumDiscPreReq, CodDepto, NumDisc);
alter table Turma add constraint PK_Turma primary key (AnoSem, CodDepto, NumDisc, SiglaTur);
alter table Horario add constraint PK_Horario primary key (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio);
alter table Predio add constraint PK_Predio primary key (CodPred);
alter table Sala add constraint PK_Sala primary key (CodPred, NumSala);
alter table Professor add constraint PK_Professor primary key (CodProf);
alter table ProfTurma add constraint PK_ProfTurma primary key (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf);
alter table Titulacao add constraint PK_Titulacao primary key (CodTit);

-- Chaves estrangeiras

alter table Disciplina add constraint FK_Discipli_Relation_Depto foreign key (CodDepto) references Depto (CodDepto);
alter table PreReq add constraint FK_PreReq_Tem_Pre_Discipli foreign key (CodDepto, NumDisc) references Disciplina (CodDepto, NumDisc);
alter table PreReq add constraint FK_PreReq_Eh_Pre_Discipli foreign key (CodDeptoPreReq, NumDiscPreReq) references Disciplina (CodDepto, NumDisc);
alter table Turma add constraint FK_Turma_Relation_Discipli foreign key (CodDepto) references Disciplina (CodDepto);
alter table Horario add constraint FK_Horario_Relation_turma foreign key (AnoSem, CodDepto, NumDisc, SiglaTur) references Turma (AnoSem, CodDepto, NumDisc, SiglaTur);
alter table Horario add constraint FK_Horario_Relation_Sala foreign key (CodPred, NumSala) references Sala (CodPred, NumSala);
alter table Sala add constraint FK_Sala_Relation_Predio foreign key (CodPred) references Predio (CodPred);
alter table Professor add constraint FK_Professor_Relation_Depto foreign key (CodDepto) references Depto (CodDepto);
alter table Professor add constraint FK_Professor_Relation_Titulacao foreign key (CodTit) references Titulacao (CodTit);
alter table ProfTurma add constraint FK_ProfTurm_Turma foreign key (AnoSem, CodDepto, NumDisc, SiglaTur) references Turma (AnoSem, CodDepto, NumDisc, SiglaTur);
alter table ProfTurma add constraint FK_ProfTurm_Professor foreign key (CodProf) references Professor (CodProf);

-- Inserindo dados nas tabelas

INSERT INTO Depto (CodDepto, NomeDepto) VALUES
('CS001', 'Ciencia da Computacao'),
('MAT01', 'Matematica'),
('FIS01', 'Fisica');

INSERT INTO Disciplina (CodDepto, NumDisc, NomeDisc, CreditosDisc) VALUES 
('CS001', 101, 'Algoritmos', 4), 
('CS001', 102, 'BD', 3), 
('CS001', 103, 'Redes', 4), 
('MAT01', 201, 'Calculo I', 5), 
('MAT01', 202, 'Alg Linear', 4), 
('FIS01', 301, 'Fisica I', 4);

INSERT INTO PreReq (CodDepto, NumDisc, CodDeptoPreReq, NumDiscPreReq) VALUES
('CS001', 102, 'CS001', 101), -- Banco de Dados requer Algoritmos
('CS001', 103, 'CS001', 101), -- Redes requer Algoritmos
('MAT01', 202, 'MAT01', 201); -- Algebra Linear requer Calculo I

INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES
(20231, 'CS001', 101, 'A1', 30),
(20231, 'CS001', 102, 'A1', 25),
(20231, 'CS001', 103, 'B1', 20),
(20231, 'MAT01', 201, 'A1', 40),
(20231, 'MAT01', 202, 'B1', 35),
(20231, 'FIS01', 301, 'A1', 40);

INSERT INTO Predio (CodPred, NomePred) VALUES
(1, 'Predio de Computacao'),
(2, 'Predio de Matematica'),
(3, 'Predio de Fisica');

INSERT INTO Sala (CodPred, NumSala, DescricaoSala, CapacSala) VALUES
(1, 101, 'Sala 101', 30),
(1, 102, 'Sala 102', 25),
(1, 103, 'Sala 103', 20),
(2, 201, 'Sala 201', 40),
(2, 202, 'Sala 202', 35),
(3, 301, 'Sala 301', 40);

INSERT INTO Horario (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio, NumHoras, CodPred, NumSala) VALUES
(20231, 'CS001', 101, 'A1', 2, 900, 2, 1, 101),
(20231, 'CS001', 102, 'A1', 4, 1100, 3, 1, 102),
(20231, 'CS001', 103, 'B1', 3, 1400, 2, 1, 103),
(20231, 'MAT01', 201, 'A1', 1, 800, 4, 2, 201),
(20231, 'MAT01', 202, 'B1', 3, 1000, 3, 2, 202),
(20231, 'FIS01', 301, 'A1', 5, 1300, 2, 3, 301);

INSERT INTO Titulacao (CodTit, NomeTit) VALUES
(1, 'Doutor'),
(2, 'Mestre'),
(3, 'Especialista');

INSERT INTO Professor (CodProf, NomeProf, CodTit, CodDepto) VALUES
(1001, 'Joao Silva', 1, 'CS001'),
(1002, 'Maria Lima', 2, 'MAT01'),
(1003, 'Carlos Souza', 3, 'FIS01');

INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES
(20231, 'CS001', 101, 'A1', 1001),
(20231, 'CS001', 102, 'A1', 1001),
(20231, 'CS001', 103, 'B1', 1001),
(20231, 'MAT01', 201, 'A1', 1002),
(20231, 'MAT01', 202, 'B1', 1002),
(20231, 'FIS01', 301, 'A1', 1003);

-- Procedure usando cursor explicito, para Selecionar a quantidade de disciplinas agrupadas por Departamento

-- SELECT
SELECT CodDepto, COUNT(NumDisc) FROM Disciplina GROUP BY CodDepto;
SELECT depto.NomeDepto, COUNT(disc.NumDisc) FROM Depto depto JOIN Disciplina disc ON depto.CodDepto = disc.CodDepto GROUP BY depto.CodDepto;

-- PROCEDURE

DELIMITER //

CREATE PROCEDURE qtd_disciplinas_por_depto ()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE nome_depto varchar(40);
    DECLARE qtd_disc INT;
    
    DECLARE cursor_deptos CURSOR FOR
	SELECT depto.NomeDepto, COUNT(disc.NumDisc) 
    FROM Depto depto JOIN Disciplina disc 
    ON depto.CodDepto = disc.CodDepto 
    GROUP BY depto.CodDepto;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor_deptos;
    
    read_loop: LOOP
		FETCH cursor_deptos INTO nome_depto, qtd_disc;
        IF done THEN
			LEAVE read_loop;
		END IF;
        SELECT nome_depto AS Departamento, qtd_disc AS Quantidade_Disciplinas;
	END LOOP;
    
    CLOSE cursor_deptos;
    
END //
DELIMITER ;

CALL qtd_disciplinas_por_depto();






