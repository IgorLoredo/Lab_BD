
select distinct de_desfecho	from DESFECHOS;

select distinct de_tipo_atendimento	from DESFECHOS;

select * from desfechos where lower(de_desfecho) like lower('%�bito%');

select * from desfechos where de_desfecho like 'Alta m�dica curado'; 
