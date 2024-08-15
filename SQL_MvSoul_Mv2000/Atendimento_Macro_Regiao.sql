-- Hematologia Macro 01     
SELECT
    atendime.cd_paciente
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
    INNER JOIN cid ON atendime.cd_cid = cid.cd_cid
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND cid.cd_cid IN ( 'C910', 'C920', 'C924', 'C925' )
    AND cidade.nm_cidade IN ( 'ALAGOINHA', 'ALHANDRA', 'ARACAGI', 'ARARUNA', 'BAIA DA TRAICAO',
                              'BANANEIRAS', 'BAYEUX', 'BELEM', 'BORBOREMA', 'CAAPORA',
                              'CABEDELO', 'CACIMBA DE DENTRO', 'CAICARA', 'CALDAS BRANDAO', 'CAPIM',
                              'CASSERENGUE', 'CONDE', 'CRUZ DO ESPIRITO SANTO', 'CUITE DE MAMANGUAPE', 'CUITEGI',
                              'CURRAL DE CIMA', 'DONA INES', 'DUAS ESTRADAS', 'GUARABIRA', 'GURINHEM',
                              'INGA', 'ITABAIANA', 'ITAPOROROCA', 'ITATUBA', 'JACARAU',
                              'JOAO PESSOA', 'JUAREZ TAVORA', 'JURIPIRANGA', 'LAGOA DE DENTRO', 'LOGRADOURO',
                              'LUCENA', 'MAMANGUAPE', 'MARCACAO', 'MARI', 'MATARACA',
                              'MOGEIRO', 'MULUNGU', 'PEDRAS DE FOGO', 'PEDRO REGIS', 'PILAR',
                              'PILOES', 'PILOEZINHOS', 'PIRPIRITUBA', 'PITIMBU', 'RIACHAO',
                              'RIACHAO DO BACAMARTE', 'RIACHAO DO POCO', 'RIO TINTO', 'SALGADO DE SAO FELIX', 'SANTA RITA',
                              'SAO JOSE DOS RAMOS', 'SAO MIGUEL DE TAIPU', 'SAPE', 'SERRA DA RAIZ', 'SERRARIA',
                              'SERTAOZINHO', 'SOBRADO', 'SOLANEA', 'TACIMA' )
    AND cd_uf LIKE 'PB'
GROUP BY
    atendime.cd_paciente;
    
-- Hematologia Macro 02     
SELECT
    atendime.cd_paciente
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
    INNER JOIN cid ON atendime.cd_cid = cid.cd_cid
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND cid.cd_cid IN ( 'C910', 'C920', 'C924', 'C925' )
    AND cidade.nm_cidade IN ( 'ALAGOA GRANDE', 'ALAGOA NOVA', 'ALCANTIL', 'ALGODAO DE JANDAIRA', 'AMPARO',
                              'ARARA', 'AREIA', 'AREIAL', 'AROEIRAS', 'ASSUNCAO',
                              'BARAUNA', 'BARRA DE SANTA ROSA', 'BARRA DE SANTANA', 'BARRA DE SAO MIGUEL', 'BOA VISTA',
                              'BOQUEIRAO', 'CABACEIRAS', 'CAMALAU', 'CAMPINA GRANDE', 'CARAUBAS',
                              'CATURITE', 'CONGO', 'COXIXOLA', 'CUBATI', 'CUITE',
                              'DAMIAO', 'ESPERANCA', 'FAGUNDES', 'FREI MARTINHO', 'GADO BRAVO',
                              'GURJAO', 'JUAZEIRINHO', 'LAGOA SECA', 'LIVRAMENTO', 'MASSARANDUBA',
                              'MATINHAS', 'MONTADAS', 'MONTEIRO', 'NATUBA', 'NOVA FLORESTA',
                              'NOVA PALMEIRA', 'OLIVEDOS', 'OURO VELHO', 'PARARI', 'PEDRA LAVRADA',
                              'PICUI', 'POCINHOS', 'PRATA', 'PUXINANA', 'QUEIMADAS', 'REMIGIO',
                              'RIACHO DE SANTO ANTONIO', 'SANTA CECILIA', 'SANTO ANDRE', 'SAO DOMINGOS DO CARIRI', 'SAO JOAO DO CARIRI',
                              'SAO JOAO DO TIGRE', 'SAO JOSE DOS CORDEIROS', 'SAO SEBASTIAO DE LAGOA DE ROCA', 'SAO SEBASTIAO DO UMBUZEIRO'
                              , 'SAO VICENTE DO SERIDO','SERRA BRANCA', 'SERRA REDONDA', 'SOLEDADE', 'SOSSEGO', 'SUME',
                              'TAPEROA', 'TENORIO', 'UMBUZEIRO', 'ZABELE' )
    AND cd_uf LIKE 'PB'
GROUP BY
    atendime.cd_paciente;

-- Hematologia Macro 03 
SELECT
    atendime.cd_paciente
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN cidade ON cidade.cd_cidade = paciente.cd_cidade
    INNER JOIN cid ON atendime.cd_cid = cid.cd_cid
WHERE
    atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
    AND cid.cd_cid IN ( 'C910', 'C920', 'C924', 'C925' )
       AND ( cidade.nm_cidade LIKE 'AGUA BRANCA'
          OR cidade.nm_cidade LIKE 'AGUIAR'
          OR cidade.nm_cidade LIKE 'APARECIDA'
          OR cidade.nm_cidade LIKE 'AREIA DE BARAUNAS'
          OR cidade.nm_cidade LIKE 'BELEM DO BREJO DO CRUZ'
          OR cidade.nm_cidade LIKE 'BERNARDINO BATISTA'
          OR cidade.nm_cidade LIKE 'BOA VENTURA'
          OR cidade.nm_cidade LIKE 'BOM JESUS'
          OR cidade.nm_cidade LIKE 'BOM SUCESSO'
          OR cidade.nm_cidade LIKE 'BONITO DE SANTA FE'
          OR cidade.nm_cidade LIKE 'BREJO DO CRUZ'
          OR cidade.nm_cidade LIKE 'BREJO DOS SANTOS'
          OR cidade.nm_cidade LIKE 'CACHOEIRA DOS INDIOS'
          OR cidade.nm_cidade LIKE 'CACIMBA DE AREIA'
          OR cidade.nm_cidade LIKE 'CACIMBAS'
          OR cidade.nm_cidade LIKE 'CAJAZEIRAS'
          OR cidade.nm_cidade LIKE 'CAJAZEIRINHAS'
          OR cidade.nm_cidade LIKE 'CARRAPATEIRA'
          OR cidade.nm_cidade LIKE 'CATINGUEIRA'
          OR cidade.nm_cidade LIKE 'CATOLE DO ROCHA'
          OR cidade.nm_cidade LIKE 'CONCEICAO'
          OR cidade.nm_cidade LIKE 'CONDADO'
          OR cidade.nm_cidade LIKE 'COREMAS'
          OR cidade.nm_cidade LIKE 'CURRAL VELHO'
          OR cidade.nm_cidade LIKE 'DESTERRO'
          OR cidade.nm_cidade LIKE 'DIAMANTE'
          OR cidade.nm_cidade LIKE 'EMAS'
          OR cidade.nm_cidade LIKE 'IBIARA'
          OR cidade.nm_cidade LIKE 'IGARACY'
          OR cidade.nm_cidade LIKE 'IMACULADA'
          OR cidade.nm_cidade LIKE 'ITAPORANGA'
          OR cidade.nm_cidade LIKE 'JERICO'
          OR cidade.nm_cidade LIKE 'JOCA CLAUDINO'
          OR cidade.nm_cidade LIKE 'JUNCO DO SERIDO'
          OR cidade.nm_cidade LIKE 'JURU'
          OR cidade.nm_cidade LIKE 'LAGOA'
          OR cidade.nm_cidade LIKE 'LASTRO'
          OR cidade.nm_cidade LIKE 'MALTA'
          OR cidade.nm_cidade LIKE 'MANAIRA'
          OR cidade.nm_cidade LIKE 'MARIZOPOLIS'
          OR cidade.nm_cidade LIKE 'MATO GROSSO'
          OR cidade.nm_cidade LIKE 'MATUREIA'
          OR cidade.nm_cidade LIKE 'MONTE HOREBE'
          OR cidade.nm_cidade LIKE 'NAZAREZINHO'
          OR cidade.nm_cidade LIKE 'NOVA OLINDA'
          OR cidade.nm_cidade LIKE 'PASSAGEM'
          OR cidade.nm_cidade LIKE 'PATOS'
          OR cidade.nm_cidade LIKE 'PAULISTA'
          OR cidade.nm_cidade LIKE 'PEDRA BRANCA'
          OR cidade.nm_cidade LIKE 'PIANCO'
          OR cidade.nm_cidade LIKE 'POCO DANTAS'
          OR cidade.nm_cidade LIKE 'POCO DE JOSE DE MOURA'
          OR cidade.nm_cidade LIKE 'POMBAL'
          OR cidade.nm_cidade LIKE 'PRINCESA ISABEL'
          OR cidade.nm_cidade LIKE 'QUIXABA'
          OR cidade.nm_cidade LIKE 'RIACHO DOS CAVALOS'
          OR cidade.nm_cidade LIKE 'SALGADINHO'
          OR cidade.nm_cidade LIKE 'SANTA CRUZ'
          OR cidade.nm_cidade LIKE 'SANTA HELENA'
          OR cidade.nm_cidade LIKE 'SANTA INES'
          OR cidade.nm_cidade LIKE 'SANTA LUZIA'
          OR cidade.nm_cidade LIKE 'SANTA TERESINHA'
          OR cidade.nm_cidade LIKE 'SANTANA DE MANGUEIRA'
          OR cidade.nm_cidade LIKE 'SANTANA DOS GARROTES'
          OR cidade.nm_cidade LIKE 'SAO BENTINHO'
          OR cidade.nm_cidade LIKE 'SAO BENTO'
          OR cidade.nm_cidade LIKE 'SAO DOMINGOS'
          OR cidade.nm_cidade LIKE 'SAO FRANCISCO'
          OR cidade.nm_cidade LIKE 'SAO JOAO DO RIO DO PEIXE'
          OR cidade.nm_cidade LIKE 'SAO JOSE DA LAGOA TAPADA'
          OR cidade.nm_cidade LIKE 'SAO JOSE DE CAIANA'
          OR cidade.nm_cidade LIKE 'SAO JOSE DE ESPINHARAS'
          OR cidade.nm_cidade LIKE 'SAO JOSE DE PIRANHAS'
          OR cidade.nm_cidade LIKE 'SAO JOSE DE PRINCESA'
          OR cidade.nm_cidade LIKE 'SAO JOSE DO BONFIM'
          OR cidade.nm_cidade LIKE 'SAO JOSE DO BREJO DO CRUZ'
          OR cidade.nm_cidade LIKE 'SAO JOSE DO SABUGI'
          OR cidade.nm_cidade LIKE 'SAO MAMEDE'
          OR cidade.nm_cidade LIKE 'SERRA GRANDE'
          OR cidade.nm_cidade LIKE 'SOUSA'
          OR cidade.nm_cidade LIKE 'TAVARES'
          OR cidade.nm_cidade LIKE 'TEIXEIRA'
          OR cidade.nm_cidade LIKE 'TRIUNFO'
          OR cidade.nm_cidade LIKE 'UIRAUNA'
          OR cidade.nm_cidade LIKE 'VARZEA'
          OR cidade.nm_cidade LIKE 'VIEIROPOLIS'
          OR cidade.nm_cidade LIKE 'VISTA SERRANA'
          OR cidade.nm_cidade LIKE '%OLHO% %AGUA%'
          OR cidade.nm_cidade LIKE '%MAE% %AGUA%' )
    AND cd_uf LIKE 'PB'
GROUP BY
    atendime.cd_paciente;
