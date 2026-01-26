DELETE FROM  reg_fat WHERE cd_atendimento = '4315860'
DELETE FROM  res_lei WHERE cd_atendimento = '4315860'
DELETE FROM  responsa WHERE cd_atendimento = '4315860'
DELETE FROM  solsaipro_mov_int WHERE cd_atendimento = '4315860'
DELETE FROM  atendime WHERE cd_atendimento = '4315860'

DELETE FROM  mov_int WHERE cd_mov_int = '190010'

UPDATE leito SET tp_ocupacao = 'V'
WHERE cd_leito = 400
