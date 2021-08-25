DROP TABLE if exists ExHemograma;

create table ExHemograma as select 
		id_paciente, id_atendimento, dt_coleta,
		de_analito,	de_resultado,	de_valor_referencia,
		'#'|| row_number (*) over (partition BY dt_coleta, 
		count(de_analito), id_hospital ORDER BY dt_coleta)||'#' exam_sequency
		FROM exames 
WHERE UPPER(de_exame) LIKE '%HEMOGRAMA%'
GROUP BY id_paciente, id_atendimento, dt_coleta, 
de_analito, de_resultado, de_valor_referencia, id_hospital;

SELECT COUNT(*) FROM ExHemograma;

