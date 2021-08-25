select 'Pacientes:', count(ic_sexo) from pacientes ;
select count(distinct aa_nascimento) from pacientes;

select 'Homens', count(*) from pacientes where ic_sexo like 'M'
	union
select 'Mulheres',count(*) from pacientes where ic_sexo like 'F'; 


select '+Velho', MAX(aa_nascimento) as idade
	FROM pacientes;
	
select '+Novo', MIN( aa_nascimento) as idade
	FROM pacientes;
	
