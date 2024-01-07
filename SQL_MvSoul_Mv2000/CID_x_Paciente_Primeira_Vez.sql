SELECT 
    atendime.cd_paciente,
    atendime.cd_cid
FROM
    atendime atendime
    INNER JOIN cid cid ON atendime.cd_cid = cid.cd_cid
    INNER JOIN paciente on paciente.cd_paciente = atendime.cd_paciente
WHERE
    atendime.CD_CID = 'C900'
    --AND atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND paciente.dt_cadastro BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
GROUP BY 
    atendime.cd_paciente, atendime.cd_cid


SELECT 
    atendime.cd_cid,
    cid.ds_cid,
    count(*)   
FROM
    atendime atendime
    INNER JOIN cid cid ON atendime.cd_cid = cid.cd_cid
    INNER JOIN paciente on paciente.cd_paciente = atendime.cd_paciente
WHERE
     atendime.dt_atendimento BETWEEN TO_DATE('01/01/2022', 'DD/MM/YYYY') AND TO_DATE('31/12/2022', 'DD/MM/YYYY')
     AND atendime.cd_cid like 'C%'
    --AND paciente.dt_cadastro BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
GROUP BY 
    atendime.cd_cid, cid.ds_cid
Order by
    count(*) desc
    
    
SELECT 
    atendime.cd_cid,
    cid.ds_cid,
    count(distinct(atendime.cd_paciente))   
FROM
    atendime atendime
    INNER JOIN cid cid ON atendime.cd_cid = cid.cd_cid
    INNER JOIN paciente on paciente.cd_paciente = atendime.cd_paciente
WHERE
     atendime.dt_atendimento BETWEEN TO_DATE('01/01/2022', 'DD/MM/YYYY') AND TO_DATE('31/12/2022', 'DD/MM/YYYY')
     AND atendime.cd_cid like 'C%'
    --AND paciente.dt_cadastro BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
GROUP BY 
    atendime.cd_cid, cid.ds_cid
Order by
    count(*) desc
