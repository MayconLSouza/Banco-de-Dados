/* 1.1. DESENHO DE MODELO DE DADOS FISICOS */
CREATE DATABASE Curso;

USE Curso;

CREATE TABLE Estados (
	SiglaEstado char(2),
	NomeEstado varchar(40)
);

ALTER TABLE Estados ADD CONSTRAINT PK_Estados PRIMARY KEY (SiglaEstado);

CREATE TABLE Classes (
	IdClasse smallint,
	IdAndar smallint
);
	
ALTER TABLE Classes ADD CONSTRAINT PK_Classes PRIMARY KEY (IdClasse);

CREATE TABLE Alunos (
	CodAluno smallint,
	NomeAluno varchar(45),
	EndAluno varchar(100),
	SiglaEstado char(2),
	IdClasse smallint
);

ALTER TABLE Alunos ADD CONSTRAINT PK_Alunos PRIMARY KEY (CodAluno);

ALTER TABLE Alunos ADD CONSTRAINT FK_Alunos_Estados FOREIGN KEY (SiglaEstado) REFERENCES Estados(SiglaEstado);
ALTER TABLE Alunos ADD CONSTRAINT FK_Alunos_Classes FOREIGN KEY (IdClasse) REFERENCES Classes(IdClasse); 

CREATE TABLE Professores (
	IdProfessor char(3),
	NomeProfessor varchar(25)
);

ALTER TABLE Professores ADD CONSTRAINT PK_Professores PRIMARY KEY (IdProfessor);

CREATE TABLE Disciplinas (
	IdDisciplina char(3),
	NomeDisciplina varchar(15),
	IdProfessorDisciplina char(3),
	NotaMinimaDisciplina smallint
);

ALTER TABLE Disciplinas ADD CONSTRAINT PK_Disciplinas PRIMARY KEY (IdDisciplina);

ALTER TABLE Disciplinas ADD CONSTRAINT FK_Disciplinas_Professores FOREIGN KEY (IdProfessorDisciplina) REFERENCES Professores(IdProfessor);

CREATE TABLE AlunosDisciplinas (
	CodAluno smallint,
	IdDisciplina char(3),
	NotaAluno smallint
);

ALTER TABLE AlunosDisciplinas ADD CONSTRAINT PK_AlunosDisciplinas PRIMARY KEY (CodAluno, IdDisciplina);

ALTER TABLE AlunosDisciplinas ADD CONSTRAINT FK_AlunosDisciplinas_Alunos FOREIGN KEY (CodAluno) REFERENCES Alunos(CodAluno);
ALTER TABLE AlunosDisciplinas ADD CONSTRAINT FK_AlunosDisciplinas_Disciplinas FOREIGN KEY (IdDisciplina) REFERENCES Disciplinas(IdDisciplina);
	
/* 1.2. DESCRICAO DO CONTEUDO DAS TABELAS QUE SERAO UTILIZADAS */

INSERT INTO Professores (IdProfessor, NomeProfessor) VALUES
('JOI', 'JOILSON CARDOSO'),
('OSE', 'OSEAS SANTANA'),
('VIT', 'VITOR VASCONCELOS'),
('FER', 'JOSE ROBERTO FERROLI'),
('LIM', 'VALMIR LIMA'),
('EDS', 'EDSON SILVA'),
('WAG', 'WAGNER OKIDA');

INSERT INTO Estados (SiglaEstado, NomeEstado) VALUES
('SP', 'SAO PAULO');

INSERT INTO Classes (IdClasse, IdAndar) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Alunos (CodAluno, NomeAluno, EndAluno, SiglaEstado, IdClasse) VALUES
(1, 'ANTONIO CARLOS PENTEADOR', 'RUA X', 'SP', 1),
(2, 'AUROMIR DA SILVA VALDEVINO', 'RUA W', 'SP', 1),
(3, 'ANDRE COSTA', 'RUA T', 'SP', 1),
(4, 'ROBERTO SOARES DE MENEZES', 'RUA BW', 'SP', 2),
(5, 'DANIA', 'RUA CCC', 'SP', 2),
(6, 'CARLOS MAGALHAES', 'AV SP', 'SP', 2),
(7, 'MARCELO RAUBA', 'AV SAO LUIS', 'SP', 3),
(8, 'FERNANDO', 'AV COUNTYR', 'SP', 3),
(9, 'WALMIR BURIN', 'RUA SSISIS', 'SP', 3);

INSERT INTO Disciplinas (IdDisciplina, NomeDisciplina, IdProfessorDisciplina, NotaMinimaDisciplina) VALUES
('MAT', 'MATEMATICA', 'JOI', 7),
('POR', 'PORTUGUES', 'VIT', 5),
('FIS', 'FISICA', 'OSE', 3),
('HIS', 'HISTORIA', 'EDS', 2),
('GEO', 'GEOGRAFIA', 'WAG', 4),
('ING', 'INGLES', 'LIM', 2);

INSERT INTO AlunosDisciplinas (CodAluno, IdDisciplina, NotaAluno) VALUES
(1, 'MAT', 0),
(2, 'MAT', 0),
(3, 'MAT', 1),
(4, 'POR', 2),
(5, 'POR', 2),
(6, 'POR', 2),
(7, 'FIS', 3),
(8, 'FIS', 3),
(9, 'FIS', 3),
(1, 'POR', 2),
(2, 'POR', 2),
(7, 'POR', 2),
(1, 'FIS', 3);




