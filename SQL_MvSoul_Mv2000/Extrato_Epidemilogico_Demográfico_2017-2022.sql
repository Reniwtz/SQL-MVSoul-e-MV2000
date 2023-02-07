/*Extrato epidemiol�gico demogr�fico HNL dos pacientes atendidos entre
2017-2022, constando CID, g�nero, idade e ra�a. */
SELECT
    a.cd_cid                                           AS cid,
    t.nm_sexo                                          AS g�nero,
    trunc(to_char(sysdate - p.dt_nascimento) / 365.25) AS idade,
    r.nm_raca_cor                                      AS ra�a
FROM
    atendime  a,
    paciente  p,
    tipo_sexo t,
    raca_cor  r
WHERE
        a.cd_paciente = p.cd_paciente
    AND p.tp_sexo = t.tp_sexo
    AND p.tp_cor = r.tp_cor
    AND a.dt_atendimento BETWEEN ( '01/01/2017' ) AND ( '31/12/2022' );
