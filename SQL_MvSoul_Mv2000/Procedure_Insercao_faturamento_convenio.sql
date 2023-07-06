create or replace PROCEDURE INSERE_FATURAMENTO_CONVENIO (
    vnumero_origem IN NUMBER := NULL,
    vds_ori_ate VARCHAR2 := NULL,
    vcd_atendimento IN NUMBER := NULL,
    vnm_paciente VARCHAR2 := NULL,
    vcd_paciente IN NUMBER := NULL,
    vnr_cpf IN NUMBER := NULL,
    vdt_atendimento DATE := NULL,
    vdt_alta DATE,
    vnm_convenio IN VARCHAR2 := NULL,
    vcd_prestador IN NUMBER,
    vnm_prestador IN VARCHAR2,
    vcd_pro_int IN NUMBER := NULL,
    vvalor_hnl IN NUMBER,
    vvalor_ho IN NUMBER,
    vvl_total_conta IN NUMBER := NULL,
    vcd_reg_fat IN NUMBER := NULL,
    vcd_remessa IN NUMBER := NULL,
    vdt_competencia DATE := NULL)
AS
    vTP_STATUS VARCHAR2(1);
    vTESTE_CD_PACIENTE NUMBER(8,0);
BEGIN
    IF (vTESTE_CD_PACIENTE IS NULL) THEN
        IF (vDT_TRIAGEM IS NOT NULL AND vDT_CONSULTA IS NULL AND vDT_TRATAMENTO IS NULL) THEN
            vTP_STATUS := 'C'; -- AGUARDANDO CONSULTA
        ELSIF (vDT_TRIAGEM IS NOT NULL AND vDT_CONSULTA IS NOT NULL AND vDT_TRATAMENTO IS NULL) THEN
            vTP_STATUS := 'T'; -- AGUARDANDO TRATAMENTO
        ELSIF (vDT_TRIAGEM IS NOT NULL AND vDT_CONSULTA IS NOT NULL AND vDT_TRATAMENTO IS NOT NULL) THEN
            vTP_STATUS := 'F'; -- TRATAMENTO FINALIZADO
        ELSE
            vTP_STATUS := 'A';
        END IF;
        INSERT INTO NIR_PACIENTES
            (numero_origemL, ds_ori_ate, cd_atendimento, nm_paciente, cd_paciente, nr_cpf, vdt_atendimento, dt_alta, nm_convenio, cd_prestador, nm_prestador, cd_pro_int, valor_hnl, valor_h, vl_total_conta, cd_reg_fat, cd_remessa, dt_competencia )
        VALUES
            (vnumero_origemL, vds_ori_ate, vcd_atendimento, vnm_paciente, vcd_paciente, vnr_cpf, vdt_atendimento, vdt_alta, vnm_convenio, vcd_prestador, vnm_prestador, vcd_pro_int, vvalor_hnl, vvalor_h, vvl_total_conta, vcd_reg_fat, vcd_remessa, vdt_competencia ));
    END IF;
END INSERE_FATURAMENTO_CONVENIO;
