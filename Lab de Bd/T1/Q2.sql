select '+velho', max(dt_coleta) as idade	from exames;
	
select '+novo', min(dt_coleta) as idade	from exames ;
	
select count(de_exame) from exames where lower(de_exame) like lower('%covid%') ;

select * from exames where lower(de_exame) like '%covid%' and lower(de_resultado) like 'detectado%';