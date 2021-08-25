
with exameGenero as (
		select p.ic_sexo, e.de_exame, COUNT(*) as conta from pacientes p JOIN exames e
			on p.id_paciente = e.id_paciente
			group by rollup(p.ic_sexo, e.de_exame)
	)

select* from exameGenero
	where conta between 10 and 20
	order by 3 desc;