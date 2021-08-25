DROP INDEX IF EXISTS idx_id_origem_d;
DROP INDEX IF EXISTS idx_id_origem_p;
DROP INDEX IF EXISTS idx_id_origem_e;
DROP INDEX IF EXISTS IdxExamesCovidDetectado;
DROP INDEX IF EXISTS IdxHospital;

CREATE INDEX idx_id_origem_d ON desfechos (id_paciente);
CREATE UNIQUE INDEX idx_id_origem_p ON pacientes (id_paciente);
CREATE INDEX idx_id_origem_e ON exames (id_paciente, de_origem);

CREATE INDEX IdxExamesCovidDetectado ON exames (LOWER(de_exame) , LOWER(de_resultado));
CREATE INDEX IdxHospital ON desfechos USING (id_paciente) WHERE (id_hospital = 1);