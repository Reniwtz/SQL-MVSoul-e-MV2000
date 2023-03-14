select DISTINCT(NR_MATRICULA_volume) from same
 where dt_cadastro between '01/07/2022' and '31/07/2022' and NR_VOLUME = 1;


select * from same
 where dt_cadastro between '01/08/2022' and '31/08/2022';

select dt_cadastro, count(nr_matricula_same)
  from same 
 where dt_cadastro between '02/12/2016' and '02/12/2016'
group by dt_cadastro
order by dt_cadastro;
