--Puxando todos os procedimentos com os codigos 040401012
select  cd_procedimento, dt_atendimento, cd_convenio from  atendime
WHERE
    cd_procedimento LIKE '0404010121%'
    and cd_convenio = 2
    and (dt_atendimento BETWEEN ( '01/08/2022' ) and ( '31/08/2022' ));

            
--Puxando todos os procedimentos com os codigos 0401010074
select  cd_procedimento, dt_atendimento, cd_convenio from  atendime
WHERE
    cd_procedimento LIKE '0401010074%'
    and cd_convenio = 16
    and (dt_atendimento BETWEEN ( '01/01/2022' ) and ( '21/12/2022' ));


0401020088
0404010113

select * from atendime

--Puxando a lista de Procedimento de exerese
SELECT cd_procedimento, ds_procedimento FROM procedimento_sus
WHERE
    ds_procedimento LIKE 'EXERESE%';
    
SELECT * FROM CONVENIO
