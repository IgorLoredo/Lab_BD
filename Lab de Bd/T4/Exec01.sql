

create table exames_aux as select * from exames where lower(de_exame) like 'covid-19-pcr%'
		and (lower(de_resultado) like '%não detectado%' or lower(de_resultado) like '%detectado%')
			order by de_exame limit 5;
			
delete from exames where id_exame if (select distinct id_exame from exames_aux);
select * from exames where id_exame in (select distinct id_exame from exames_aux);