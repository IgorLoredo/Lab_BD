

select 	a.id_paciente, a.id_atendimento, interna, alta,	a.id_hospital, dt_desfecho,de_desfecho
FROM atendimento a JOIN desfechos d ON( a.id_atendimento = d.id_atendimento) ORDER BY id_paciente;