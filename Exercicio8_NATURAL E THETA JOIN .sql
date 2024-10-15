Obter os nomes dos departamentos que têm turmas que, em 2023/1, 
têm aulas na sala 203 do prédio denominado 'Informática - aulas'. 
Resolver usando theta-join e junção natural.

-- Theta-join

SELECT NomeDepto 
FROM Depto d, Turma t, Horario h, Sala s, Predio p
WHERE d.CodDepto = t.CodDepto
AND t.AnoSem = h.AnoSem
AND t.CodDepto = h.CodDepto
AND t.NumDisc = h.NumDisc
AND t.SiglaTur = h.SiglaTur
AND h.CodPred = s.CodPred
AND h.NumSala = s.NumSala
AND s.CodPred = p.CodPred
AND p.NomePred = "Informatica"
AND s.NumSala = 203
AND h.AnoSem = 20231;

-- Natural join

SELECT NomeDepto
FROM Depto NATURAL JOIN Turma NATURAL JOIN Horario NATURAL JOIN Sala NATURAL JOIN Predio
WHERE NomePred = "Informatica - aulas"
AND NumSala = 203
AND AnoSem = 20231;