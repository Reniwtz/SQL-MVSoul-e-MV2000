SELECT DISTINCT
    ( amostra.cd_amostra ) cd_amostra,
    itped_lab.cd_ped_lab,
    amostra.cd_tubo_coleta,
    tubo_coleta.ds_tubo_coleta,
    amostra.cd_material,
    material.ds_material
FROM
         dbamv.itped_lab
    INNER JOIN dbamv.exa_lab_material ON ( itped_lab.cd_exa_lab = exa_lab_material.cd_exa_lab )
    INNER JOIN dbamv.amostra ON ( amostra.cd_material = exa_lab_material.cd_material
                                  AND amostra.cd_tubo_coleta = exa_lab_material.cd_tubo_coleta )
    INNER JOIN dbamv.amostra_exa_lab ON ( amostra_exa_lab.cd_itped_lab = itped_lab.cd_itped_lab
                                          AND amostra_exa_lab.cd_amostra = amostra.cd_amostra )
    INNER JOIN dbamv.tubo_coleta ON ( amostra.cd_tubo_coleta = tubo_coleta.cd_tubo_coleta )
    INNER JOIN dbamv.material ON ( amostra.cd_material = material.cd_material )
WHERE
    itped_lab.sn_coleta_pendente = 'S';
