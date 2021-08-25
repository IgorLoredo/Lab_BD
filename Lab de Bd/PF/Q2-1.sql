-- Igor Guilherme e Natã Botelho 
--- 2 . a

-- inserindo o campo novo com o pwd e hash (usei pwd pq password é palavra reservada)
drop function password_hash(string text);
-- insere uma nova coluna pwd
alter table pacientes add column pwd text;

--função de hash que fizemos no trabalho 3
create or replace function password_hash(string text) returns text 
	as $$ declare retornar text;
		begin
			retornar := crypt(string, gen_salt('md5'));
			raise notice 'Password - %, Hash: %', string, retornar;
			return retornar;
		end;  
	$$ language plpgsql;

-- atualizar coluna pwd 
update pacientes set pwd = password_hash(concat(id_paciente,cd_municipio)); 

-- function usando o trigger 
create or replace function login_paciente() 
	returns trigger as $login$ 
		begin  -- id paciente e cd_municipio 
			new.pwd := password_hash(concat(new.id_paciente, new.cd_municipio))
			return new;
		end;
	$login$ language plpgsql;

-- criamos um trigger que inseir o pwd depois q ja insidos os dados
create trigger login before insert or update on pacientes
	FOR EACH ROW execute procedure login_paciente();

insert into pacientes (id_paciente,cd_municipio) values ('ID-11188', 'bahia');
insert into pacientes (id_paciente,cd_municipio) values ('ID-11189', 'bahia');



SELECT * FROM pacientes;

DELETE FROM pacientes WHERE cd_municipio LIKE 'bahia';









