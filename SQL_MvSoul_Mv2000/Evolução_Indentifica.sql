SELECT
    pw_documento_clinico.cd_paciente,
    pw_documento_clinico.cd_atendimento,
    decode(cd_objeto, 642, 'EVOLUÇÃO TERAPEUTA OCUPACIONAL', 61, 'EVOLUÇÃO MEDICA INTERNAÇÃO',
           62, 'EVOLUÇÃO ENFERMAGEM INTERNAÇÃO', 63, 'EVOLUÇÃO NUTRICIONISTA', 73,
           'EVOLUÇÃO PSICOLOGIA', 87, 'EVOLUÇÃO MEDICA URGÊNCIA', 90, 'EVOLUÇÃO ENFERMAGEM AMBULATORI',
           116, 'EVOLUÇÃO FISIO INTERNAÇAO', 67, 'EVOLUÇÃO FISIOTERAPEUTA', 76,
           'EVOLUÇÃO ASSISTENTE SOCIAL', 78, 'EVOLUÇÃO FONOAUDIOLOGIA', 79, 'EVOLUÇÃO TECNICO DE ENFERMAGEM',
           80, 'EVOLUÇÃO FARMACIA', 82, 'EVOLUÇÃO MEDICA AMBULATORIO', 83,
           'EVOLUÇÃO NUTRICIONISTA AMB', 202, 'EVOLUÇÃO ENFERMAGEM URGENCIA', 881, 'EVOLUÇÃO DENTISTA',
           921, 'EVOLUÇÃO DE ENFERMAGEM CCIH', 69, 'EVOLUÇÃO DE TÉCNICO DE ENFERMAGEM', 'DESCONHECIDO') AS descricao_observacao
FROM
         pw_documento_clinico pw_documento_clinico
    INNER JOIN pw_tipo_documento ON pw_documento_clinico.cd_tipo_documento = pw_tipo_documento.cd_tipo_documento
WHERE
    pw_documento_clinico.cd_atendimento IN (
        SELECT DISTINCT
            cd_atendimento
        FROM
            atendime
        WHERE
                tp_atendimento = 'I'
            AND cd_servico LIKE '1'
            AND cd_convenio LIKE '1'
            AND dt_atendimento BETWEEN TO_DATE('01/01/25', 'DD/MM/YY') AND TO_DATE('31/12/25', 'DD/MM/YY')
    )
    AND pw_documento_clinico.cd_objeto IN ( 642, 61, 62, 63, 73,
                                            87, 90, 116, 67, 76,
                                            78, 79, 80, 82, 83,
                                            202, 881, 921, 69 )
ORDER BY
    pw_documento_clinico.cd_paciente,
    pw_documento_clinico.cd_atendimento
