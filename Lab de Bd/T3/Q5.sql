
DROP MATERIALIZED VIEW IF EXISTS Atendimento ;
CREATE MATERIALIZED VIEW Atendimento
AS SELECT ID_Paciente , ID_Atendimento , MIN ( DT_Coleta ) Interna , MAX (
DT_Coleta ) Alta , Count (*) TotExam , id_Hospital
FROM Exames
GROUP BY ID_Paciente , ID_Atendimento , id_Hospital
WITH data ;

select id_paciente, interna, alta, id_hospital
FROM atendimento
ORDER BY id_paciente;