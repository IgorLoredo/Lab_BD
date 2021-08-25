
alter table pacientes ADD COLUMN senha TEXT;


UPDATE PACIENTES SET SENHA = password_hash(CONCAT(id_paciente , ' - ', IC_SEXO, ' - ', AA_NASCIMENTO));

SELECT * FROM PACIENTES;
