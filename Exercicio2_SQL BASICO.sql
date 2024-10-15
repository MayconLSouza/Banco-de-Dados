/* A- Exercícios de SELECT básico */                          

/* 1) Queremos selecionar todos os alunos cadastrados. */
SELECT NomeAluno FROM Alunos;

/* 2) Queremos selecionar todos os nomes de disciplina, 
cujo a nota mínima seja maior que 5 ( cinco ). */
SELECT NomeDisciplina FROM Disciplinas WHERE NotaMinimaDisciplina > 5;

/* 3) Queremos selecionar todas disciplinas que tenham
nota mínima entre 3 (três) e 5 (cinco). */
SELECT IdDisciplina, NomeDisciplina FROM Disciplinas WHERE NotaMinimaDisciplina BETWEEN 3 AND 5;

/* B - Exercícios de SELECT (Ordenando e agrupando dados) */

/* 1) Queremos selecionar todos os alunos em ordem alfabética de nome de aluno, 
e também o número da classe que estuda. */
SELECT NomeAluno, IdClasse FROM Alunos ORDER BY NomeAluno ASC;

/* 2) Selecionaremos o item anterior, 
porém ordenado alfabeticamente pelo identificador do aluno de forma descendente  
(ascendente é “default”). */
SELECT NomeAluno, CodAluno FROM Alunos ORDER BY CONVERT(CodAluno, char) DESC;

/* 3) Selecionaremos  todos os alunos que cursam as disciplinas de matemática E de português 
agrupados por aluno e disciplina. */
SELECT a.CodAluno, a.NomeAluno FROM Alunos a
JOIN AlunosDisciplinas ad ON a.CodAluno = ad.CodAluno
JOIN Disciplinas d ON ad.IdDisciplina = d.IdDisciplina
WHERE d.NomeDisciplina IN ('MATEMATICA', 'PORTUGUES')
GROUP BY a.NomeAluno HAVING COUNT(a.NomeAluno) = 2;

SELECT CodAluno FROM AlunosDisciplinas WHERE IdDisciplina = 'MAT'
INTERSECT
SELECT CodAluno FROM AlunosDisciplinas WHERE IdDisciplina = 'POR';

SELECT CodAluno FROM AlunosDisciplinas WHERE IdDisciplina = "MAT" 
AND CodAluno IN (SELECT CodAluno FROM AlunosDisciplinas WHERE IdDisciplina = "POR");

/* C - Exercícios de SELECT (Junção de Tabelas) */

/* 1) Queremos selecionar todos os nomes de alunos que cursam Português ou Matemática. */
SELECT DISTINCT NomeAluno 
FROM Alunos a 
JOIN AlunosDisciplinas ad ON a.CodAluno = ad.CodAluno
WHERE ad.IdDisciplina = 'MAT' OR ad.IdDisciplina = 'POR';

/* 2) Queremos selecionar todos os nomes de alunos cadastrados que cursam  a disciplina 
FÍSICA e seus respectivos endereços. */
SELECT NomeAluno, EndAluno 
FROM Alunos a
JOIN AlunosDisciplinas ad ON a.CodAluno = ad.CodAluno
WHERE ad.IdDisciplina = 'FIS';

/* 3) Queremos selecionar todos os nomes de alunos cadastrados que cursam física 
e o andar que se encontra a classe dos mesmos. Preste atenção ao detalhe da concatenação 
de uma string "andar" junto à coluna do número do andar (Apenas para estética do resultado). */
SELECT a.NomeAluno, c.IdAndar
FROM Alunos a
JOIN AlunosDisciplinas ad ON a.CodAluno = ad.CodAluno
JOIN Classes c ON a.IdClasse = c.IdClasse
WHERE ad.IdDisciplina = 'FIS';
 
/* D - Exercícios de SELECT (OUTER JOIN) */

/* 1. Selecionar todos os Professores com suas respectivas disciplinas 
e os demais Professores que não lecionam disciplina alguma. */
SELECT p.IdProfessor, p.NomeProfessor, d.NomeDisciplina 
FROM Professores p
LEFT JOIN Disciplinas d ON p.IdProfessor = d.IdProfessorDisciplina; 

/* E - Exercícios de SELECT (USE Clausula IN e/ou SUBSelect). Não pode usar junção. */

/* 1. Selecionar todos os nomes de professores que tenham ministrado disciplina 
para alunos que sejam do Estado do Piaui, cujo a classe tenha sido no terceiro andar. */
SELECT DISTINCT p.NomeProfessor
FROM Professores p
WHERE p.IdProfessor IN (
    SELECT d.IdProfessorDisciplina
    FROM Disciplinas d
    WHERE d.IdDisciplina IN (
        SELECT ad.IdDisciplina
        FROM AlunosDisciplinas ad
        WHERE ad.CodAluno IN (
            SELECT a.CodAluno
            FROM Alunos a
            WHERE a.SiglaEstado = 'PI'
              AND a.IdClasse IN (
                  SELECT c.IdClasse
                  FROM Classes c
                  WHERE c.IdAndar = 3
              )
        )
    )
);