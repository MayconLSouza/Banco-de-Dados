/*
Criar trigger para registrar um LOG das atualizações das Tabela Professor. No Log deve existir:

           1-  código do usuário que fez a alteração;

           2-  chave primaria do registro alterado;

           3-  Tipo de alteração realizado (INSERT ou UPDATE ou DELETE);

           4-  Data e Hora da alteração.



Entregar a estrutura da Tabela de LOG ( pode ser chamada Tabela_Log_Professor ) ;

e o Código da(s) Trigger(s).

-- para selecionar o usuario corrente no mysql
SELECT CURRENT_USER();
*/

CREATE TABLE Tabela_Log_Professor (
    ID_Log INT AUTO_INCREMENT PRIMARY KEY,
    CodUsuario varchar (100),
    CodProf INT,
    TipoAlteracao VARCHAR(10),
    DataHora_Alteracao DATETIME
);

DELIMITER //

CREATE TRIGGER Log_Professor_Insert
AFTER INSERT
ON Professor
FOR EACH ROW
BEGIN
    INSERT INTO Tabela_Log_Professor (CodUsuario, CodProf, TipoAlteracao, DataHora_Alteracao)
    VALUES (CURRENT_USER(), NEW.CodProf, 'INSERT', NOW());
END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER Log_Professor_Update
AFTER UPDATE
ON  Professor
FOR EACH ROW
BEGIN
    INSERT INTO Tabela_Log_Professor (CodUsuario, CodProf, TipoAlteracao, DataHora_Alteracao)
    VALUES (CURRENT_USER(), NEW.CodProf, 'UPDATE', NOW());
END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER Log_Professor_Delete
AFTER DELETE
ON Professor
FOR EACH ROW
BEGIN 
    INSERT INTO Tabela_Log_Professor (CodUsuario, CodProf, TipoAlteracao, DataHora_Alteracao)
    VALUES (CURRENT_USER(), OLD.CodProf, 'DELETE', NOW());
END //
DELIMITER ;