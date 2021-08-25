alter table exames alter column id_hospital type text; 
alter table pacientes alter column id_hospital type text;
alter table desfechos alter column id_hospital type text; 

update desfechos set id_hospital = 'HCFMUSP' where id_hospital = '0';
UPDATE desfechos set id_hospital = 'HSL' where id_hospital = '1';

update pacientes set id_hospital = 'HCFMUSP' where id_hospital = '0';
update pacientes set id_hospital = 'HSL' where id_hospital = '1';

update  exames	set id_hospital = 'HCFMUSP' where id_hospital = '0';
update exames set id_hospital = 'HSL' where id_hospital = '1';