

--CREATE table EstatisticasCovid (Data DATE, CasosPos INTEGER, CasosNeg INTEGER, Recuperados INTEGER, Obitos INTEGER);

CREATE OR REPLACE function insertDados () 
	RETURNS TRIGGER AS
$$
	DECLARE
	var RECORD;
	BEGIN
	FOR var IN SELECT NEW.dt_coleta,
						  COUNT( CASE WHEN LOWER(NEW.de_resultado) LIKE '%positivo%' THEN de_resultado
								  END)AS CasosPos,
							COUNT( CASE	WHEN LOWER(NEW.de_resultado) LIKE '%negativo%' THEN de_resultado
								  END)AS CasosNeg,
							COUNT( CASE WHEN lower(de_desfecho) LIKE '%alta%' THEN de_desfecho
								  END)AS Recuperados,
							COUNT( CASE WHEN lower(de_desfecho) LIKE '%obito%'  THEN de_desfecho
								  END)AS Obitos
						FROM exames_aux e
						LEFT JOIN desfechos d ON(NEW.id_paciente = d.id_paciente AND NEW.id_atendimento = d.id_atendimento)
						WHERE NEW.id_exame = e.id_exame
						GROUP BY NEW.dt_coleta
						ORDER BY NEW.dt_coleta
					LOOP
						INSERT INTO EstatisticasCovid (data, casospos, casosneg, recuperados, obitos)
						VALUES (var.dt_coleta, var.CasosPos, var.CasosNeg, var.Recuperados, var.Obitos);
					END LOOP;
		RETURN NULL;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER getEstatic AFTER INSERT ON exames FOR EACH ROW
	EXECUTE PROCEDURE insertDados(id_exame, id_paciente, id_atendimento, dt_coleta, de_resultado);

INSERT INTO EXAMES (ID_EXAME, ID_PACIENTE, ID_ATENDIMENTO, DT_COLETA, DE_ORIGEM, DE_EXAME, DE_ANALITO, DE_RESULTADO, CD_UNIDADE, DE_VALOR_REFERENCIA, ID_HOSPITAL)
SELECT ID_EXAME, ID_PACIENTE, ID_ATENDIMENTO, DT_COLETA, DE_ORIGEM, DE_EXAME, DE_ANALITO, DE_RESULTADO, CD_UNIDADE, DE_VALOR_REFERENCIA, ID_HOSPITAL
FROM (
	SELECT *,
		   ROW_NUMBER() OVER (ORDER BY ID_EXAME) AS ORDEM
	FROM EXAMES_AUX
) AS A
WHERE ORDEM = 1
ORDER BY ID_EXAME;


INSERT INTO exames (id_exame, id_paciente, id_atendimento, dt_coleta, de_origem, de_exame, de_analito, de_resultado, cd_unidade, de_valor_referencia, id_hospital)
SELECT id_exame, id_paciente, id_atendimento, dt_coleta, de_origem, de_exame, de_analito, de_resultado, cd_unidade, de_valor_referencia, id_hospital
FROM (
	SELECT *,
		   row_number() OVER (ORDER BY id_exame) AS ordem
	FROM exames_aux
) AS a
WHERE ordem = 2
ORDER BY dt_coleta;


INSERT INTO EXAMES (ID_EXAME, ID_PACIENTE, ID_ATENDIMENTO, DT_COLETA, DE_ORIGEM, DE_EXAME, DE_ANALITO, DE_RESULTADO, CD_UNIDADE, DE_VALOR_REFERENCIA, ID_HOSPITAL)
SELECT ID_EXAME, ID_PACIENTE, ID_ATENDIMENTO, DT_COLETA, DE_ORIGEM, DE_EXAME, DE_ANALITO, DE_RESULTADO, CD_UNIDADE, DE_VALOR_REFERENCIA, ID_HOSPITAL
FROM (
	SELECT *,
		   ROW_NUMBER() OVER (ORDER BY ID_EXAME) AS ORDEM
	FROM EXAMES_AUX
) AS A
WHERE ORDEM = 3
ORDER BY DT_COLETA;

INSERT INTO EXAMES (ID_EXAME, ID_PACIENTE, ID_ATENDIMENTO, DT_COLETA, DE_ORIGEM, DE_EXAME, DE_ANALITO, DE_RESULTADO, CD_UNIDADE, DE_VALOR_REFERENCIA, ID_HOSPITAL)
SELECT ID_EXAME, ID_PACIENTE, ID_ATENDIMENTO, DT_COLETA, DE_ORIGEM, DE_EXAME, DE_ANALITO, DE_RESULTADO, CD_UNIDADE, DE_VALOR_REFERENCIA, ID_HOSPITAL
FROM (
	SELECT *,
		   ROW_NUMBER() OVER (ORDER BY ID_EXAME) AS ORDEM
	FROM EXAMES_AUX
) AS A
WHERE ORDEM = 4
ORDER BY DT_COLETA;


INSERT INTO exames (id_exame, id_paciente, id_atendimento, dt_coleta, de_origem, de_exame, de_analito, de_resultado, cd_unidade, de_valor_referencia, id_hospital)
SELECT id_exame, id_paciente, id_atendimento, dt_coleta, de_origem, de_exame, de_analito, de_resultado, cd_unidade, de_valor_referencia, id_hospital
FROM (
	SELECT *,
		   row_number() OVER (ORDER BY id_exame) AS ordem
	FROM exames_aux
) AS a
WHERE ordem = 5
ORDER BY dt_coleta;

SELECT * FROM EstaCovid;
