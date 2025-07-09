--Conferir Pedido
SELECT
    *
FROM
    ped_lab
WHERE
    cd_atendimento LIKE '4145343';

--Atribuir a empresa
           begin dbamv.pkg_mv2000.atribui_empresa(1); end;
--Da um update no pedido de exame 
           UPDATE dbamv.itped_lab 
                  SET CD_EXA_LAB = CD_EXA_LAB
            WHERE cd_ped_lab = 236797
