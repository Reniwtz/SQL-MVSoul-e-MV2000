--- SELECT FISIOTERAPIA SUS
select SUM (QDE_PRODUZ) from desenv.src_datasus
where descricao like '%FISIO%'
AND COMP IN ('11/2014','12/2014','01/2015','02/2015','03/2015','04/2015','05/2015',
             '06/2015','07/2015','08/2015','09/2015','10/2015','11/2015','12/2015')
ORDER BY COMP


select * from 
