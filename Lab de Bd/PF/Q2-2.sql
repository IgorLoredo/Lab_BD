---2 .b 
 
--table criada 
DROP table IF EXISTS LogAcesso;
create table LogAcesso(
	date_create timestamp,
	type_operation text,
	table_request text
);

-- crio uma function para inserir logs
create or replace function function_log()
	returns trigger as $trigger_log$
		begin 
			insert into LogAcesso(date_create,type_operation,table_request)
				values (current_timestamp,TG_OP, TG_TABLE_NAME);
			return new;
		end;
	$trigger_log$ language plpgsql;
	
--- agora criamos trigger para cara tabla 
create trigger triggerLogPacientes after
	insert or delete or update on pacientes 
		for each row execute function function_log();
		
create trigger triggerLogDefechos after
	insert or delete or update on desfechos
		for each row execute function function_log();

create trigger triggerLogExames after
	insert or delete or update on exames
		for each row execute function function_log();

insert into pacientes (id_paciente) values ('ID-11188');
insert into desfechos (id_paciente, id_atendimento) VALUES ('ID-11188', 'id_atendimeento');
insert into exames (id_exame) values (0751127);

update pacientes set id_paciente = 'ID-111' where id_paciente = 'ID-11188';
update exames set id_exame = 07511272 where id_exame = 0751127;

delete from desfechos where id_paciente  = 'ID-111';
delete from pacientes where id_paciente = 'ID-111';
select * from logacesso;


