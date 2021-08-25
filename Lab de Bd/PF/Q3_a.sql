--Recupera o total de exames de ferritina e alanina aminotrsferase, ambos são substâncias relacionadas
--à doenças no fígado, os dados podem indicar que o Covid pode também influenciar sob o sistema hepático
--além de trazer à tona quando agrupado por idade que o grupo de idosos tende a ser mais afetado por
--tais complicações

SELECT aa_nascimento, COUNT(*) FROM pacientes p
	JOIN exames ex ON ex.id_paciente = p.id_paciente
	WHERE (p.ic_sexo = 'M' AND de_exame = 'alanina aminotransferase' AND de_resultado != '*' AND TRIM('<> ' FROM de_resultado)::float > 41)
	OR (p.ic_sexo = 'F' AND de_exame = 'alanina aminotransferase' AND de_resultado != '*' AND TRIM('<> ' FROM de_resultado)::float > 31)
	OR (de_exame = 'ferritina' AND de_resultado::float > 400)
	GROUP BY(aa_nascimento)
	