

-- isso é para mudar o formato do tipo date, pois não aceita como está nos csv
set datestyle to European;

-- chave primaria, id_paciente, 
CREATE table IF NOT EXISTS PACIENTES  (
	id_paciente char(40) NOT NULL,
	ic_sexo char(1),
	aa_nascimento VARCHAR(8),
	cd_uf VARCHAR(2),
	cd_municipio VARCHAR(60),
	cd_cepreduzido VARCHAR(10),
	CD_PAIS VARCHAR(4),
	id_hospital varchar(4),
	PRIMARY KEY (id_paciente)
);


CREATE TABLE IF NOT exists DESFECHOS( 
	id_paciente varchar(40) NOT NULL,
	id_atendimento varchar(40) NOT NULL,
	dt_atendimento date NOT NULL,
	de_tipo_atendimento varchar(40) not null,
	id_clinica  NUMERIC(4) NOT null,
	de_clinica text not null,
	dt_desfecho VARCHAR(10) NOT NULL,
	DE_DESFECHO text,
	PRIMARY KEY (id_paciente, id_atendimento),
	constraint fk_paciente FOREIGN KEY(id_paciente) references pacientes(id_paciente) ON DELETE CASCADE
	
);

--id_paciente and id_atendimento

CREATE table IF NOT EXISTS EXAMES (
	id_exame SERIAL not null,
	id_atendimento VARCHAR (32) NOT null,
	id_paciente varchar(32) not null,
	DT_COLETA DATE NOT NULL,
	de_origem text not null,
	de_exame text not null,
	de_analito text not null,
	de_resultado text,
	cd_unidade varchar(40),
	de_valor_referencia text,
	primary key(id_exame, id_paciente),	
	CONSTRAINT fk_paciente FOREIGN KEY(ID_PACIENTE)  references pacientes(id_paciente)
	  ON DELETE CASCADE
);

---inserindo pacientes
COPY pacientes(
	id_paciente,
	ic_sexo ,
	aa_nascimento,
	CD_PAIS,
	cd_uf ,
	cd_municipio ,
	cd_cepreduzido
	)
	FROM 'C:\Users\Igor\Desktop\Lab_de_BD\HSL_Pacientes_3.csv' 
	WITH( FORMAT CSV, HEADER, DELIMITER '|'); 


COPY pacientes(
	id_paciente,
	ic_sexo ,
	aa_nascimento,
	CD_PAIS,
	cd_uf ,
	cd_municipio ,
	cd_cepreduzido
	)
	FROM 'C:\Users\Igor\Desktop\Lab_de_BD\HC_PACIENTES_1.csv' 
	WITH( FORMAT CSV, HEADER, DELIMITER '|'); 
--


--inserindo exames, é a parte maior
copy exames(
	id_atendimento,
	id_paciente,
	dt_coleta,
	de_origem,
	de_exame,
	de_analito,
	de_resultado,
	cd_unidade,
	de_valor_referencia
	) 
	from 'C:\Users\Igor\Desktop\Lab_de_BD\HSL_Exames_3.csv' 
	with (format csv, header, delimiter '|');



copy exames(
	id_atendimento,
	id_paciente,
	dt_coleta,
	de_origem,
	de_exame,
	de_analito,
	de_resultado,
	cd_unidade,
	de_valor_referencia
	)
from 'C:\Users\Igor\Desktop\Lab_de_BD\HC_EXAMES_1.csv'
WITH( FORMAT CSV, HEADER, DELIMITER '|'); 



-- inserindo desfechos

copy desfechos (
	ID_PACIENTE,
	ID_ATENDIMENTO,
	DT_ATENDIMENTO,
	DE_TIPO_ATENDIMENTO,
	ID_CLINICA,
	DE_CLINICA,
	DT_DESFECHO,
	DE_DESFECHO
	)
	from 'C:\Users\Igor\Desktop\Lab_de_BD\HSL_Desfechos_3.csv' 
	with (format csv, header, delimiter '|');

-- mostrar a quantidade em cada pacientes, defeschos 
select count(*) FROM desfechos ;
select count(*) FROM pacientes;
select count(*) FROM exames;
select  count( distinct id_paciente) FROM pacientes;
select count (distinct id_exame) FROM exames;




-- apagar tudo depois

DROP TABLE IF EXISTS PACIENTES CASCADE;
DROP TABLE IF EXISTS EXAMES;
DROP TABLE IF EXISTS DESFECHOS;





