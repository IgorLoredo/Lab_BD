SELECT COUNT(*) FROM exames
	WHERE (LOWER(de_exame) LIKE '%covid%' OR LOWER(de_exame) LIKE '%corona%')
	AND (LOWER(de_resultado) LIKE 'detectado%' OR LOWER(de_resultado) LIKE '%positivo')
	AND dt_coleta BETWEEN '2020-12-01' AND '2020-12-31';