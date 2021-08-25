

select p.id_paciente, count(*) as qtd_exames, count(distinct e.de_exame) as qtd_tipo_exame
from exames e join pacientes p 
ON (p.id_paciente = e.id_paciente)
WHERE UPPER(cd_municipio) LIKE 'SAO PAULO'
GROUP BY ROLLUP (p.id_paciente)
ORDER BY tipo_exames_amount DESC;

