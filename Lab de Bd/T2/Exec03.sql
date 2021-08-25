
create or replace function password_hash(string text) returns text 
as $$
declare retornar text;
begin
	retornar := crypt(string, gen_salt('md5'));
	raise notice ' %, ----  %', string, retornar;
	return retornar;
end;  $$ language plpgsql;


--SELECT ('B^rJgb');
--SELECT password_hash('Z67&*T');
--SELECT password_hash('scc0541LabBD');
--SELECT password_hash('covid19-Fapesp');