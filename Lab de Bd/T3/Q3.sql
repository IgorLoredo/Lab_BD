drop table if exists HistExamDesfechos;

create table HistExamDesfechos as
select row_number() over (partition by id_paciente order by dt_atividade, de_exame, de_analito) as id_atividade,
count(id_exame) over(partition by id_paciente) as qtd_resultados_exames, 
*
from exames e join desfechos d on(e.id_paciente = d.id_paciente);

SELECT * from HistExamDesfechos	order BY dt_coleta desc, dt_desfecho desc limit 20;

-