-- 1. Obter os nomes docentes cuja titulação tem código diferente de 8.
SELECT NomeProf 
FROM Professor 
WHERE CodTit != 8;

-- 2. Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na
-- sala 204 do prédio denominado 'Polimeros'. Resolver usando theta-join
-- e junção natural.
SELECT NomeDepto 
FROM Depto  
NATURAL JOIN Turma
NATURAL JOIN Horario 
NATURAL JOIN Sala
NATURAL JOIN Predio
WHERE AnoSem = 20021
AND NumSala = 204
AND Predio = 'Polimeros';

-- 3.Obter o nome dos professores que possuem horários conflitantes (possuem
-- turmas que tenham a mesma hora inicial, no mesmo dia da semana e no mesmo
-- semestre).
SELECT DISTINCT P.NomeProf
FROM Professor P
NATURAL JOIN ProfTurma PT
NATURAL JOIN Horario H1
NATURAL JOIN Horario H2
WHERE H1.AnoSem = H2.AnoSem
AND H1.DiaSem = H2.DiaSem
AND H1.HoraInicio = H2.HoraInicio
AND (H1.CodDepto != H2.CodDepto OR H1.NumDisc != H2.NumDisc OR H1.SiglaTur != H2.SiglaTur);

-- 4. Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido
-- do nome da disciplina que é seu pré-requisito (usar junções explícitas - quando
-- possível usar junção natural).
SELECT D.NomeDisc AS Disciplina, D2.NomeDisc AS PreRequisito
FROM PreReq PR
NATURAL JOIN Disciplina D  
JOIN Disciplina D2 ON PR.CodDeptoPreReq = D2.CodDepto  
AND PR.NumDiscPreReq = D2.NumDisc;


-- 5. Para cada disciplina, mesmo para aquelas que não possuem pré-requisito, obter o
-- nome da disciplina seguido do nome da disciplina que é seu pré-requisito (usar
-- junções explícitas - quando possível usar junção natural).
SELECT D.NomeDisc AS Disciplina, COALESCE(D2.NomeDisc, 'Sem Pre-requisito') AS PreRequisito
FROM Disciplina D
LEFT JOIN PreReq PR ON D.CodDepto = PR.CodDepto AND D.NumDisc = PR.NumDisc  
LEFT JOIN Disciplina D2 ON PR.CodDeptoPreReq = D2.CodDepto  
AND PR.NumDiscPreReq = D2.NumDisc;


-- 6. Para cada disciplina que tem um pré-requisito que a sua vez também tem um
-- pré-requisito, obter o nome da disciplina seguido do nome do pré-requisito de
-- seu pré-requisito.
SELECT D.NomeDisc AS Disciplina, D1.NomeDisc AS PreRequisito, D2.NomeDisc AS PreRequisitoDoPreRequisito
FROM PreReq PR1
JOIN Disciplina D ON PR1.CodDepto = D.CodDepto AND PR1.NumDisc = D.NumDisc  
JOIN Disciplina D1 ON PR1.CodDeptoPreReq = D1.CodDepto AND PR1.NumDiscPreReq = D1.NumDisc  
JOIN PreReq PR2 ON PR1.CodDeptoPreReq = PR2.CodDepto AND PR1.NumDiscPreReq = PR2.NumDisc  
JOIN Disciplina D2 ON PR2.CodDeptoPreReq = D2.CodDepto AND PR2.NumDiscPreReq = D2.NumDisc;  


-- 7. Obter uma tabela que contém três colunas. Na primeira coluna aparece o nome
-- de cada disciplina que possui pré-requisito, na segunda coluna aparece o nome
-- de cada um de seus pré-requisitos e a terceira contém o nível de pré-requisito.
-- Nível 1 significa que trata-se de um pré-requisito imediato da disciplina, nível 2
-- significa que trata-se de um pré-requisito de um pré-requisito da disciplina, e
-- 3 assim por diante. Limitar a consulta para três níveis. (DICA USAR UNION ALL)
-- Nível 1: Pré-requisito imediato
SELECT D.NomeDisc AS Disciplina, D1.NomeDisc AS PreRequisito, 1 AS Nivel
FROM PreReq PR1
JOIN Disciplina D ON PR1.CodDepto = D.CodDepto AND PR1.NumDisc = D.NumDisc
JOIN Disciplina D1 ON PR1.CodDeptoPreReq = D1.CodDepto AND PR1.NumDiscPreReq = D1.NumDisc

UNION ALL

-- Nível 2: Pré-requisito do pré-requisito
SELECT D.NomeDisc AS Disciplina, D2.NomeDisc AS PreRequisito, 2 AS Nivel
FROM PreReq PR1
JOIN Disciplina D ON PR1.CodDepto = D.CodDepto AND PR1.NumDisc = D.NumDisc
JOIN PreReq PR2 ON PR1.CodDeptoPreReq = PR2.CodDepto AND PR1.NumDiscPreReq = PR2.NumDisc
JOIN Disciplina D2 ON PR2.CodDeptoPreReq = D2.CodDepto AND PR2.NumDiscPreReq = D2.NumDisc

UNION ALL

-- Nível 3: Pré-requisito do pré-requisito do pré-requisito
SELECT D.NomeDisc AS Disciplina, D3.NomeDisc AS PreRequisito, 3 AS Nivel
FROM PreReq PR1
JOIN Disciplina D ON PR1.CodDepto = D.CodDepto AND PR1.NumDisc = D.NumDisc
JOIN PreReq PR2 ON PR1.CodDeptoPreReq = PR2.CodDepto AND PR1.NumDiscPreReq = PR2.NumDisc
JOIN PreReq PR3 ON PR2.CodDeptoPreReq = PR3.CodDepto AND PR2.NumDiscPreReq = PR3.NumDisc
JOIN Disciplina D3 ON PR3.CodDeptoPreReq = D3.CodDepto AND PR3.NumDiscPreReq = D3.NumDisc;


-- 8. Obter os códigos dos professores com código de título vazio que não
-- ministraram aulas em 2023/2 (resolver com junção natural).
SELECT P.CodProf
FROM Professor P
NATURAL LEFT JOIN ProfTurma PT  
WHERE P.CodTit IS NULL  
AND (PT.AnoSem IS NULL OR PT.AnoSem != 20232);  
