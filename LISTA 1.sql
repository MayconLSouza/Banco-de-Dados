-- 1. Obter os códigos dos diferentes departamentos que tem turmas no ano-semestre 2002/1  

DELIMITER //
 
CREATE PROCEDURE exercicio_1 ()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE _CodDepto char(5);
    DECLARE cursor_depto CURSOR FOR
    SELECT CodDepto 
    FROM Turma 
    WHERE AnoSem = 20021;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_depto;
    read_loop: LOOP
		FETCH cursor_depto INTO _CodDepto;
        IF done THEN
			LEAVE read_loop;
		END IF;
        SELECT _CodDepto AS "Codigo do Departamento";
	END LOOP;
    CLOSE cursor_depto;
END //
DELIMITER ;
 
CALL exercicio_1();

-- 2. Obter os códigos dos professores que são do departamento de código 'INF01' e que ministraram ao menos uma turma em 2002/1.  

DELIMITER //
 
CREATE PROCEDURE exercicio_2 ()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE _CodProf int4;
    DECLARE cursor_professor CURSOR FOR
    SELECT DISTINCT CodProf 
    FROM ProfTurma 
    WHERE AnoSem = 20021 
    AND CodDepto = 'INF01';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_professor;
    read_loop: LOOP
		FETCH cursor_professor INTO _CodProf;
        IF done THEN
			LEAVE read_loop;
		END IF;
        SELECT _CodProf AS "Codigo de professor";
	END LOOP;
    CLOSE cursor_professor;
END //
DELIMITER ;
 
CALL exercicio_2();

-- 3. Obter os horários de aula (dia da semana,hora inicial e número de horas ministradas) do professor "Antunes" em 20021.  

DELIMITER //
 
CREATE PROCEDURE exercicio_3()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE _DiaSem int4;
    DECLARE _HoraInicio int4;
    DECLARE _NumHoras int4;
    DECLARE cursor_horario CURSOR FOR
    SELECT DiaSem, HoraInicio, NumHoras 
    FROM Horario WHERE AnoSem = 20021 AND NumDisc IN 
    (SELECT NumDisc FROM ProfTurma WHERE CodProf = 
    (SELECT CodProf FROM Professor WHERE NomeProf = "Antunes"));
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_horario;
    read_loop: LOOP
		FETCH cursor_horario INTO _DiaSem, _HoraInicio, _NumHoras;
        IF done THEN
			LEAVE read_loop;
		END IF;
        SELECT _DiaSem AS "Dia da Semana", _HoraInicio AS "Hora Inicial", _NumHoras AS "Numero de Horas";
	END LOOP;
    CLOSE cursor_horario;
END //
DELIMITER ;
 
CALL exercicio_3();

-- 4. Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na sala 101 do prédio denominado 'Informática - aulas'.  

DELIMITER //

CREATE PROCEDURE exercicio_4 ()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE _NomeDepto varchar(40);
    
    DECLARE cursor_depto CURSOR FOR
    SELECT DISTINCT d.NomeDepto FROM Depto d 
	JOIN Horario h ON d.CodDepto = h.CodDepto
	JOIN Sala s ON h.NumSala = s.NumSala
	JOIN Predio p ON s.CodPred = p.CodPred
	WHERE h.AnoSem = 20021
	AND s.NumSala = 101
	AND p.NomePred = 'Informática - aulas';
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor_depto;
    
    read_loop: LOOP
		FETCH cursor_depto INTO _NomeDepto;
		IF done THEN
			LEAVE read_loop;
		END IF;
        SELECT _NomeDepto AS 'Nome do Departamento';
	END LOOP;
    
    CLOSE cursor_depto;
    
END //
DELIMITER ;

CALL exercicio_4();

-- 5. Obter os códigos dos professores com título denominado 'Doutor' que não ministraram aulas em 2002/1.  

DELIMITER //

CREATE PROCEDURE exercicio_5 ()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE _CodProf int4;
    
    DECLARE cursor_professor CURSOR FOR
    SELECT DISTINCT p.CodProf
	FROM Professor p
	JOIN ProfTurma pt ON p.CodProf = pt.CodProf
	JOIN Titulacao t ON p.CodTit = t.CodTit
	WHERE t.NomeTit = 'Doutor'
	AND pt.AnoSem <> 20021;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor_professor;
    
    read_loop: LOOP
		FETCH cursor_professor INTO _CodProf;
        IF done THEN
			LEAVE read_loop;
		END IF;
		SELECT _CodProf AS "Codigo do Professor";
	END LOOP;
    
    CLOSE cursor_professor;
    
END //
DELIMITER ;

CALL exercicio_5();

-- 6. Obter os identificadores das salas (código do prédio e número da sala) que, em 2002/1:  
-- nas segundas-feiras (dia da semana = 2), tiveram ao menos uma turma do departamento 'Informática', e  
-- nas quartas-feiras (dia da semana = 4), tiveram ao menos uma turma ministrada pelo professor denominado 'Antunes'.  

DELIMITER //
create procedure exercicio_6()
begin     
	declare _CodPred int4;
	declare _NumSala int4;
	declare done boolean default false;
    
	declare cursor_sala cursor for
	select CodPred, NumSala from Horario where AnoSem = 20021 and
	exists (select SiglaTur from Horario where DiaSem = 2 and
	CodDepto = (select CodDepto from Depto where NomeDepto = "Informatica"))
	and
	exists (select SiglaTur from Horario where DiaSem = 4 and
	CodDepto = (select distinct CodDepto from ProfTurma where
	CodProf = (select CodProf from Professor where NomeProf = "Antunes")));
        
    declare continue handler for not found set done = true;
        
    open cursor_sala;
    while (not done) do
		fetch cursor_sala into _CodPred, _NumSala;
        select _CodPred as "Codigo de Predio", _NumSala as "Numero de Sala";
    end while;
	close cursor_sala;
    
end //    
DELIMITER ;

call exercicio_6();

-- 7. Obter o dia da semana, a hora de início e o número de horas de cada horário de cada turma ministrada por um professor de nome `Antunes', em 2002/1, na sala número 101 do prédio de código 43423.  

DELIMITER //
create procedure exercicio_7()
begin
	declare _DiaSem int4;
    declare _HoraInicio int4;
    declare _NumHoras int4;
    declare done boolean default false;
        
    declare cursor_horario cursor for
	select DiaSem, HoraInicio, NumHoras from Horario where SiglaTur in
	(select SiglaTur from ProfTurma where CodProf =
	(select CodProf from Professor where NomeProf = "Antunes")
	and (CodPred = 43423) and (NumSala = 101));

	declare continue handler for not found set done = true;
        
    open cursor_horario;
    while (not done) do
		fetch cursor_horario into _DiaSem, _HoraInicio, _NumHoras;
		select _DiaSem as "Dia da Semana", _HoraInicio as "Horario de Inicio", _NumHoras as "Numero de Horas";
    end while;
    close cursor_horario;

end //
DELIMITER ;

call exercicio_7();

-- 8. Um professor pode ministrar turmas de disciplinas pertencentes a outros departamentos. Para cada professor que já ministrou aulas em disciplinas de outros departamentos, obter o código do professor, seu nome, o nome de seu departamento e o nome do departamento no qual ministrou disciplina.  

DELIMITER //
create procedure exercicio_8()
begin
	declare _CodProf int4;
	declare _NomeProf varchar(40);
	declare _NomeDeptoProf varchar(40);
	declare _NomeDeptoTurma varchar (40);
	declare done boolean default false;
        
    declare cursor_professor cursor for 
	select distinct p.CodProf, p.NomeProf, d.NomeDepto as "Nome do Departamento do Professor", d2.NomeDepto as "Nome do Departamento da Disciplina"
	from Professor p
	join Depto d on p.CodDepto = d.CodDepto
	join ProfTurma pf on p.CodProf = pf.CodProf
	join Depto d2 on pf.CodDepto = d2.CodDepto
	where p.CodDepto != pf.CodDepto;

	declare continue handler for not found set done = true;
        
    open cursor_professor;
    while (not done) do
		fetch cursor_professor into _CodProf, _NomeProf, _NomeDeptoProf,  _NomeDeptoTurma;
		select _CodProf as "Codigo de Professor", _NomeProf as "Nome de Professor", _NomeDeptoProf  as "Nome do Departamento do Professor",  _NomeDeptoTurma as "Nome do Departamento da Disciplina";
    end while;
    close cursor_professor;
	
end //     
DELIMITER ;

call exercicio_8();

-- 9. Obter o nome dos professores que possuem horários conflitantes (possuem turmas que tenham a mesma hora inicial, no mesmo dia da semana e no mesmo semestre). Além dos nomes, mostrar as chaves primárias das turmas em conflito.  

DELIMITER //
create procedure exercicio_9()
begin
	declare _NomeProfessor varchar(40);
	declare _SiglaPrimeiraTurma char(2);
	declare _SiglaSegundaTurma char(2);
	declare done boolean default false;
	
	declare cursor_profturma cursor for 
	select p.NomeProf, pt1.SiglaTur as Turma1, pt2.SiglaTur as Turma2
	from ProfTurma pt1
	join Horario h1 on pt1.AnoSem = h1.AnoSem
    and pt1.CodDepto = h1.CodDepto
    and pt1.NumDisc = h1.NumDisc
    and pt1.SiglaTur = h1.SiglaTur
	join ProfTurma pt2 on pt1.CodProf = pt2.CodProf 
	and pt1.AnoSem = pt2.AnoSem
    and pt1.CodDepto = pt2.CodDepto 
	and (pt1.NumDisc <> pt2.NumDisc or pt1.SiglaTur <> pt2.SiglaTur)
	join Horario h2 on pt2.AnoSem = h2.AnoSem
    and pt2.CodDepto = h2.CodDepto 
	and pt2.NumDisc = h2.NumDisc
    and pt2.SiglaTur = h2.SiglaTur
	join Professor p on pt1.CodProf = p.CodProf
	where h1.DiaSem = h2.DiaSem and h1.HoraInicio = h2.HoraInicio 
	order by p.NomeProf;
			
    open cursor_profturma;
    while (not done) do
		fetch cursor_profturma into _NomeProfessor, _SiglaPrimeiraTurma, _SiglaSegundaTurma;
        select _NomeProfessor as "Nome de Professor", _SiglaPrimeiraTurma as "Sigla da Primeira Turma em Conflito", _SiglaSegundaTurma as "Sigla da Segunda Turma em Conflito";
    end while;
    close cursor_profturma;

end //    
DELIMITER ;

call exercicio_9();

-- 10. Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu pré-requisito.  

DELIMITER //
create procedure exercicio_10()
begin
	declare _NomeDisciplina varchar(10);
	declare _NomePreRequisito varchar(10);
    declare done boolean default false;
       
    declare cursor_prereq cursor for 
	select d.NomeDisc as "Disciplina", d2.NomeDisc as "Pré-Requisito" 
	from PreReq pr
	join Disciplina d on pr.CodDepto = d.CodDepto and pr.NumDisc = d.NumDisc
	join Disciplina d2 on pr.CodDeptoPreReq = d2.CodDepto and pr.NumDiscPreReq = d2.NumDisc;
                    
	declare continue handler for not found set done = true;
        
    open cursor_prereq;
    while (not done) do
		fetch cursor_prereq into _NomeDisciplina,  _NomePreRequisito;
        select _NomeDisciplina as "Disciplina",  _NomePreRequisito as "Pré-Requisito";
    end while;
    close cursor_prereq;

end //
DELIMITER ;

call exercicio_10();

-- 11. Obter os nomes das disciplinas que não têm pré-requisito.  

DELIMITER //
create procedure exercicio_11()
begin
	declare _NomeDisc varchar(10);
    declare done boolean default false;
    
	declare cursor_disciplina cursor for
	select NomeDisc 
	from Disciplina 
	where NumDisc in 
	(select NumDisc from Disciplina 
	left join PreReq using(NumDisc) 
	where NumDiscPreReq is null);
    
	declare continue handler for not found set done = true;
        
    open cursor_disciplina;
    while (not done) do
		fetch cursor_disciplina into _NomeDisc;
        select _NomeDisc as "Nome das Disciplinas";
    end while;
    close cursor_disciplina;

end //
DELIMITER ;

call exercicio_11();

-- 12. Obter o nome de cada disciplina que possui ao menos dois pré-requisitos.  

DELIMITER //
create procedure exercicio_12()
begin
	declare _NomeDisc varchar(10);
    declare done boolean default false;
        
    declare cursor_disciplina cursor for
	select NomeDisc 
	from Disciplina 
	where NumDisc = 
	(select NumDisc from PreReq 
	group by NumDisc having count(NumDisc) >= 2);

	declare continue handler for not found set done = true;
        
    open cursor_disciplina;
    while (not done) do
		fetch cursor_disciplina into _NomeDisc;
        select _NomeDisc as "Nome das Disciplinas";
    end while;
    close cursor_disciplina;

end //
DELIMITER ;

call exercicio_12();