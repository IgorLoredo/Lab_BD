

CREATE OR REPLACE PROCEDURE RecuperarExamesPaciente(paciente text, tipo_exame text, periodo int )    
as $$
declare
	pacientExiste integer; 
	data_recente date;
	aux RECORD;

begin 
	if paciente is null then
		raise exception 'Insira o ID do paciente!';
		return;
	end if;

	select count(*) into pacientExiste from pacientes where id_paciente = paciente;

	if pacientExiste = 0 then 
		raise exception 'Id paciente invalido';
		 return ;
	end if;

	select max(dt_coleta) into data_recente from exames where id_paciente=paciente;

	for aux in
			select p.id_paciente, p.cd_municipio, p.id_hospital, e.id_exame, e.id_atendimento, e.dt_coleta, 
			e.de_origem, e.de_exame, e.de_analito, e.de_resultado, e.cd_unidade, e.de_valor_referencia
			from pacientes p join  exames e on p.id_paciente=e.id_paciente
			where e.id_paciente=paciente 
			and dt_coleta>=data_recente-7*periodo
			order by dt_coleta desc
		loop 
		raise notice 'ID :% Municipio % ID hosp:% ID exe:% ID atend:% Coleta:% Origem exame:% Tipo de exame:%' 	, aux.id_paciente, aux.cd_municipio, aux.id_hospital, aux.id_exame, aux.id_atendimento, 
			aux.dt_coleta, aux.de_origem, aux.de_exame;
    	end loop;
	
			
			
end; 
$$ language plpgsql;

call RecuperarExamesPaciente('769E89D426E84A4797EF495608A0429E', 'hemograma', 5); 
