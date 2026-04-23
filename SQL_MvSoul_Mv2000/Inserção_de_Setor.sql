INSERT INTO usuario_unid_int (
    CD_UNID_INT,
    CD_ID_USUARIO,
    CD_SETOR,
    SN_SOLICITACAO_PRODUTO_SETOR,
    SN_SOLICITACAO_PRODUTO_GAS_SAL,
    SN_SOLICITACAO_PRODUTO_PACIENT,
    SN_SOLICITACAO_PRODUTO_ESTOQ,
    SN_SOLICITACAO_PRODUTO_EMP,
    SN_MOVIMENTACAO_SETOR,
    SN_MOVIMENTACAO_GASTO_SALA,
    SN_MOVIMENTACAO_PACIENTE,
    SN_MOVIMENTACAO_ESTOQUE,
    SN_MOVIMENTACAO_EMPRESA,
    SN_CONFIRMACAO_RECEBIMENTO
)
SELECT 
    cfg.CD_UNID_INT,
    u.cd_usuario,
    cfg.CD_SETOR,
    'S','S','S','S','S',
    'S','S','S','S','S',
    'S'
FROM (
    SELECT DISTINCT usuarios.cd_usuario
    FROM usuarios
    INNER JOIN usuario_unid_int 
        ON usuarios.cd_usuario = usuario_unid_int.cd_id_usuario
    WHERE usuarios.sn_ativo LIKE 'S%'
      AND usuarios.cd_prestador IS NOT NULL
) u
CROSS JOIN (
    SELECT 11 AS CD_UNID_INT, 204 AS CD_SETOR FROM dual
    UNION ALL
    SELECT NULL, 204 FROM dual
) cfg
WHERE NOT EXISTS (
    SELECT 1
    FROM usuario_unid_int x
    WHERE x.cd_id_usuario = u.cd_usuario
      AND NVL(x.cd_unid_int, -1) = NVL(cfg.cd_unid_int, -1)
      AND x.cd_setor = cfg.cd_setor
);
