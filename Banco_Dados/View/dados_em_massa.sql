--  criar os databases que iremos utilizar dados_db tera os dados das tabelas e view_db a estrutura das view
create database if not exists dados_db;

-- apagar a tabela caso ela exista
drop table if exists dados_db.aeroporto;
drop table if exists dados_db.cidade;
drop table if exists dados_db.estado;

-- criação das tabelas estado, cidade e aeroporto
create table dados_db.estado
(
	id int not null auto_increment,
    sigla char(02) not null comment 'Sigla da Unidade da Federação brasileira',
    nome varchar(100) not null comment 'Nome do Estado da Undade da Federação Brasileira',
	primary key estado_id(id),
    unique key sigla(sigla)
) comment 'Unidades da Federação Brasileira';

create table dados_db.cidade
(
	id int not null auto_increment,
    fkestado int not null comment 'Id da Unidade da federação',
    nome varchar(100) not null comment 'Nome da Cidade',
	primary key cidade_id(id),
    constraint cid_est foreign key(fkestado) references dados_db.estado(id),
    key fkestado(fkestado),
    unique key nome(nome,fkestado)
) comment 'Cidades que possuem aeroportos';

create table dados_db.aeroporto
(
	id int not null auto_increment,
    fkcidade int not null comment 'Codigo da Cidade',
	sigla  varchar(05) not null comment 'Sigla Internacional do Aeroporto ICAO',
	nome   varchar(100) not null comment 'Razão Social da Cia Aerea',
	primary key cia_aerea_id(id),
    constraint aer_cid foreign key(fkcidade) references dados_db.cidade(id),
	unique key sigla(sigla),
    key fkcidade(fkcidade)
) auto_increment=1000 comment 'Aeroportos Brasileiros';

--  Dropa as view caso existam
drop FUNCTION if exists dados_db.fn_estado;
drop FUNCTION if exists dados_db.fn_cidade;

-- criação de view para consultar ID de Estado atraves da Sigla do Estado
/*
***  DICA  ***

USAMOS A OPÇÃO DETERMINISTIC PARA NÃO SER NECESSÁRIO ALTERAR PARAMETROS DEFAULT DO BANCO

SET GLOBAL log_bin_trust_function_creators = 1;

*/

DELIMITER $$
CREATE FUNCTION dados_db.fn_estado(fCodigo VARCHAR(20)) 
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE vId int;
    
    set vId = (select id from dados_db.estado where sigla = fCodigo);
    
    return(vId);
   
END$$;
DELIMITER ;

-- criação de view para consultar ID da Cidade atraves Estado da Sigla do Estado e Nome da Cidade
DELIMITER $$
CREATE FUNCTION dados_db.fn_cidade(fUF VARCHAR(02), fCidade varchar(100)) 
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE vId int;
    
    set vId = (select cid.id 
               from dados_db.cidade cid
               inner join dados_db.estado est on est.id = cid.fkEstado
               where est.sigla = fUF
               and   cid.nome = fCidade);
    
    return(vId);
    
END$$;
DELIMITER ;

-- inclusão de dados na tabela estado
insert into dados_db.estado(sigla, nome) values 
		('AC', 'ACRE'),
		('AL', 'ALAGOAS'),
		('AP', 'AMAPÁ'),
		('AM', 'AMAZONAS'),
		('BA', 'BAHIA'),
		('CE', 'CEARÁ'),
		('DF', 'DISTRITO FEDERAL'),
		('ES', 'ESPÍRITO SANTO'),
		('GO', 'GOIÁS'),
		('MA', 'MARANHÃO'),
		('MT', 'MATO GROSSO'),
		('MS', 'MATO GROSSO DO SUL'),
		('MG', 'MINAS GERAIS'),
		('PA', 'PARÁ'),
		('PB', 'PARAÍBA'),
		('PR', 'PARANÁ'),
		('PE', 'PERNAMBUCO'),
		('PI', 'PIAUÍ'),
		('RJ', 'RIO DE JANEIRO'),
		('RN', 'RIO GRANDE DO NORTE'),
		('RS', 'RIO GRANDE DO SUL'),
		('RO', 'RONDÔNIA'),
		('RR', 'RORAIMA'),
		('SC', 'SANTA CATARINA'),
		('SP', 'SÃO PAULO'),
		('SE', 'SERGIPE'),
		('TO', 'TOCANTINS');

-- inclusão de dados na tabela cidade utilizando a function para buscar o ID do estado
INSERT INTO dados_db.cidade(fkestado, nome) VALUES 
		(dados_db.fn_estado('BA'), 'SALVADOR'),
		(dados_db.fn_estado('BA'), 'MARAÚ'),
		(dados_db.fn_estado('BA'), 'CAIRU'),
		(dados_db.fn_estado('PA'), 'BELÉM'),
		(dados_db.fn_estado('RS'), 'BAGÉ'),
		(dados_db.fn_estado('MT'), 'BARRA DO GARÇAS'),
		(dados_db.fn_estado('MT'), 'VÁRZEA GRANDE'),
		(dados_db.fn_estado('GO'), 'GOIÂNIA'),
		(dados_db.fn_estado('PA'), 'ALMEIRIM'),
		(dados_db.fn_estado('RS'), 'PORTO ALEGRE'),
		(dados_db.fn_estado('PE'), 'RECIFE'),
		(dados_db.fn_estado('MT'), 'PORTO ALEGRE DO NORTE'),
		(dados_db.fn_estado('RS'), 'VACARIA'),
		(dados_db.fn_estado('PE'), 'SERRA TALHADA'),
		(dados_db.fn_estado('PE'), 'CARUARU'),
		(dados_db.fn_estado('PB'), 'PATOS'),
		(dados_db.fn_estado('PA'), 'BREVES'),
		(dados_db.fn_estado('RS'), 'CANELA'),
		(dados_db.fn_estado('RS'), 'ERECHIM'),
		(dados_db.fn_estado('RS'), 'ALEGRETE'),
		(dados_db.fn_estado('MT'), 'ARIPUANÃ'),
		(dados_db.fn_estado('RS'), 'SÃO BORJA'),
		(dados_db.fn_estado('RS'), 'SANTA CRUZ DO SUL'),
		(dados_db.fn_estado('RS'), 'SANTA ROSA'),
		(dados_db.fn_estado('MT'), 'SÃO FÉLIX DO ARAGUAIA'),
		(dados_db.fn_estado('MT'), 'ÁGUA BOA'),
		(dados_db.fn_estado('MT'), 'JUÍNA'),
		(dados_db.fn_estado('MT'), 'TANGARÁ DA SERRA'),
		(dados_db.fn_estado('AM'), 'MANAUS'),
		(dados_db.fn_estado('PA'), 'ITAITUBA'),
		(dados_db.fn_estado('AP'), 'MACAPÁ'),
		(dados_db.fn_estado('PA'), 'SANTARÉM'),
		(dados_db.fn_estado('PA'), 'ORIXIMINÁ'),
		(dados_db.fn_estado('PA'), 'TUCURUÍ'),
		(dados_db.fn_estado('PA'), 'PARAGOMINAS'),
		(dados_db.fn_estado('PA'), 'MONTE ALEGRE'),
		(dados_db.fn_estado('PA'), 'BREJO'),
		(dados_db.fn_estado('PA'), 'ÓBIDOS'),
		(dados_db.fn_estado('TO'), 'GURUPI'),
		(dados_db.fn_estado('AM'), 'COARI'),
		(dados_db.fn_estado('AM'), 'LÁBREA'),
		(dados_db.fn_estado('AM'), 'MAUÉS'),
		(dados_db.fn_estado('SP'), 'JUNDIAÍ'),
		(dados_db.fn_estado('RO'), 'PORTO VELHO'),
		(dados_db.fn_estado('SC'), 'CAÇADOR'),
		(dados_db.fn_estado('PR'), 'SÃO JOSÉ DOS PINHAIS'),
		(dados_db.fn_estado('SC'), 'FLORIANÓPOLIS'),
		(dados_db.fn_estado('PR'), 'PATO BRANCO'),
		(dados_db.fn_estado('SC'), 'CORREIA PINTO'),
		(dados_db.fn_estado('PR'), 'APUCARANA'),
		(dados_db.fn_estado('SC'), 'SÃO MIGUEL DO OESTE'),
		(dados_db.fn_estado('PR'), 'ARAPONGAS'),
		(dados_db.fn_estado('CE'), 'ARACATI'),
		(dados_db.fn_estado('SP'), 'AREALVA'),
		(dados_db.fn_estado('SE'), 'ARACAJU'),
		(dados_db.fn_estado('MT'), 'ALTA FLORESTA'),
		(dados_db.fn_estado('SP'), 'ARAÇATUBA'),
		(dados_db.fn_estado('DF'), 'BRASÍLIA'),
		(dados_db.fn_estado('RR'), 'BOA VISTA'),
		(dados_db.fn_estado('PR'), 'CASCAVEL'),
		(dados_db.fn_estado('RJ'), 'CABO FRIO'),
		(dados_db.fn_estado('MG'), 'CONFINS'),
		(dados_db.fn_estado('MS'), 'CAMPO GRANDE'),
		(dados_db.fn_estado('SC'), 'CHAPECÓ'),
		(dados_db.fn_estado('PA'), 'PARAUAPEBAS'),
		(dados_db.fn_estado('GO'), 'CALDAS NOVAS'),
		(dados_db.fn_estado('RJ'), 'CAMPOS DOS GOYTACAZES'),
		(dados_db.fn_estado('MS'), 'CORUMBÁ'),
		(dados_db.fn_estado('RS'), 'CAXIAS DO SUL'),
		(dados_db.fn_estado('MS'), 'BONITO'),
		(dados_db.fn_estado('SP'), 'PRESIDENTE PRUDENTE'),
		(dados_db.fn_estado('PR'), 'FOZ DO IGUAÇU'),
		(dados_db.fn_estado('PE'), 'FERNANDO DE NORONHA'),
		(dados_db.fn_estado('CE'), 'FORTALEZA'),
		(dados_db.fn_estado('RJ'), 'RIO DE JANEIRO'),
		(dados_db.fn_estado('SP'), 'GUARULHOS'),
		(dados_db.fn_estado('MG'), 'GOVERNADOR VALADARES'),
		(dados_db.fn_estado('PA'), 'ALTAMIRA'),
		(dados_db.fn_estado('BA'), 'ILHÉUS'),
		(dados_db.fn_estado('MA'), 'IMPERATRIZ'),
		(dados_db.fn_estado('SC'), 'JAGUARUNA'),
		(dados_db.fn_estado('CE'), 'CRUZ'),
		(dados_db.fn_estado('RO'), 'JI-PARANÁ'),
		(dados_db.fn_estado('PB'), 'SANTA RITA'),
		(dados_db.fn_estado('CE'), 'JUAZEIRO DO NORTE'),
		(dados_db.fn_estado('SC'), 'JOINVILLE'),
		(dados_db.fn_estado('PB'), 'CAMPINA GRANDE'),
		(dados_db.fn_estado('SP'), 'CAMPINAS'),
		(dados_db.fn_estado('PR'), 'LONDRINA'),
		(dados_db.fn_estado('PA'), 'MARABÁ'),
		(dados_db.fn_estado('RJ'), 'MACAÉ'),
		(dados_db.fn_estado('PR'), 'MARINGÁ'),
		(dados_db.fn_estado('MG'), 'MONTES CLAROS'),
		(dados_db.fn_estado('SP'), 'MARÍLIA'),
		(dados_db.fn_estado('AL'), 'RIO LARGO'),
		(dados_db.fn_estado('RN'), 'MOSSORÓ'),
		(dados_db.fn_estado('SC'), 'NAVEGANTES'),
		(dados_db.fn_estado('RS'), 'SANTO ÂNGELO'),
		(dados_db.fn_estado('PI'), 'PARNAÍBA'),
		(dados_db.fn_estado('TO'), 'PALMAS'),
		(dados_db.fn_estado('RS'), 'PELOTAS'),
		(dados_db.fn_estado('PE'), 'PETROLINA'),
		(dados_db.fn_estado('BA'), 'PORTO SEGURO'),
		(dados_db.fn_estado('MT'), 'RONDONÓPOLIS'),
		(dados_db.fn_estado('SP'), 'RIBEIRÃO PRETO'),
		(dados_db.fn_estado('RN'), 'SÃO GONÇALO DO AMARANTE'),
		(dados_db.fn_estado('MT'), 'SINOP'),
		(dados_db.fn_estado('MA'), 'SÃO LUÍS'),
		(dados_db.fn_estado('RS'), 'SANTA MARIA'),
		(dados_db.fn_estado('MT'), 'SORRISO'),
		(dados_db.fn_estado('SP'), 'SÃO PAULO'),
		(dados_db.fn_estado('SP'), 'SÃO JOSÉ DO RIO PRETO'),
		(dados_db.fn_estado('BA'), 'UNA'),
		(dados_db.fn_estado('PI'), 'TERESINA'),
		(dados_db.fn_estado('AM'), 'TEFÉ'),
		(dados_db.fn_estado('MS'), 'TRÊS LAGOAS'),
		(dados_db.fn_estado('AM'), 'TABATINGA'),
		(dados_db.fn_estado('AM'), 'SÃO GABRIEL DA CACHOEIRA'),
		(dados_db.fn_estado('RS'), 'URUGUAIANA'),
		(dados_db.fn_estado('MG'), 'UBERLÂNDIA'),
		(dados_db.fn_estado('MG'), 'UBERABA'),
		(dados_db.fn_estado('BA'), 'VITÓRIA DA CONQUISTA'),
		(dados_db.fn_estado('RO'), 'VILHENA'),
		(dados_db.fn_estado('ES'), 'VITÓRIA'),
		(dados_db.fn_estado('MG'), 'GOIANÁ'),
		(dados_db.fn_estado('BA'), 'BARREIRAS'),
		(dados_db.fn_estado('BA'), 'GUANAMBI'),
		(dados_db.fn_estado('BA'), 'TEIXEIRA DE FREITAS'),
		(dados_db.fn_estado('GO'), 'RIO VERDE'),
		(dados_db.fn_estado('AM'), 'PARINTINS'),
		(dados_db.fn_estado('MG'), 'SANTANA DO PARAÍSO'),
		(dados_db.fn_estado('PR'), 'PONTA GROSSA'),
		(dados_db.fn_estado('PR'), 'TOLEDO'),
		(dados_db.fn_estado('PR'), 'GUARAPUAVA'),
		(dados_db.fn_estado('AC'), 'CRUZEIRO DO SUL'),
		(dados_db.fn_estado('AC'), 'RIO BRANCO'),
		(dados_db.fn_estado('RN'), 'PARNAMIRIM'),
		(dados_db.fn_estado('AM'), 'CARAUARI'),
		(dados_db.fn_estado('AM'), 'EIRUNEPÉ'),
		(dados_db.fn_estado('TO'), 'ARAGUAÍNA'),
		(dados_db.fn_estado('MG'), 'BELO HORIZONTE');

-- inclusão de dados na tabela aeroporto utilizando a function para buscar o ID da cidade
insert into dados_db.aeroporto(fkcidade, sigla, nome) values
	(dados_db.fn_cidade('AC','CRUZEIRO DO SUL'),'SBCZ','CRUZEIRO DO SUL'),
	(dados_db.fn_cidade('AC','RIO BRANCO'),'SBRB','PLÁCIDO DE CASTRO'),
	(dados_db.fn_cidade('AL','RIO LARGO'),'SBMO','ZUMBI DOS PALMARES'),
	(dados_db.fn_cidade('AM','MANAUS'),'SBEG','EDUARDO GOMES'),
	(dados_db.fn_cidade('AM','COARI'),'SWKO','COARI'),
	(dados_db.fn_cidade('AM','LÁBREA'),'SWLB','LÁBREA'),
	(dados_db.fn_cidade('AM','MAUÉS'),'SWMW','MAUÉS'),
	(dados_db.fn_cidade('AM','TEFÉ'),'SBTF','TEFÉ'),
	(dados_db.fn_cidade('AM','TABATINGA'),'SBTT','TABATINGA'),
	(dados_db.fn_cidade('AM','SÃO GABRIEL DA CACHOEIRA'),'SBUA','SÃO GABRIEL DA CACHOEIRA'),
	(dados_db.fn_cidade('AM','PARINTINS'),'SWPI','PARINTINS'),
	(dados_db.fn_cidade('AM','CARAUARI'),'SWCA','CARAUARI'),
	(dados_db.fn_cidade('AM','EIRUNEPÉ'),'SWEI','EIRUNEPÉ'),
	(dados_db.fn_cidade('AP','MACAPÁ'),'SBMQ','ALBERTO ALCOLUMBRE'),
	(dados_db.fn_cidade('BA','SALVADOR'),'SBSV','DEPUTADO LUÍS EDUARDO MAGALHÃES'),
	(dados_db.fn_cidade('BA','MARAÚ'),'SIRI','BARRA GRANDE'),
	(dados_db.fn_cidade('BA','CAIRU'),'SNCL','LORENZO'),
	(dados_db.fn_cidade('BA','ILHÉUS'),'SBIL','BAHIA - JORGE AMADO'),
	(dados_db.fn_cidade('BA','PORTO SEGURO'),'SBPS','PORTO SEGURO'),
	(dados_db.fn_cidade('BA','UNA'),'SBTC','HOTEL TRANSAMÉRICA'),
	(dados_db.fn_cidade('BA','VITÓRIA DA CONQUISTA'),'SBVC','GLAUBER DE ANDRADE ROCHA'),
	(dados_db.fn_cidade('BA','VITÓRIA DA CONQUISTA'),'SBQV','PEDRO OTACÍLIO FIGUEIREDO'),
	(dados_db.fn_cidade('BA','BARREIRAS'),'SNBR','BARREIRAS'),
	(dados_db.fn_cidade('BA','GUANAMBI'),'SNGI','GUANAMBI'),
	(dados_db.fn_cidade('BA','TEIXEIRA DE FREITAS'),'SNTF','TEIXEIRA DE FREITAS'),
	(dados_db.fn_cidade('CE','ARACATI'),'SBAC','ARACATI (SNAT*)'),
	(dados_db.fn_cidade('CE','FORTALEZA'),'SBFZ','PINTO MARTINS'),
	(dados_db.fn_cidade('CE','CRUZ'),'SBJE','COMANDANTE ARISTON PESSOA'),
	(dados_db.fn_cidade('CE','JUAZEIRO DO NORTE'),'SBJU','ORLANDO BEZERRA DE MENEZES'),
	(dados_db.fn_cidade('DF','BRASÍLIA'),'SBBR','PRESIDENTE JUSCELINO KUBITSCHEK'),
	(dados_db.fn_cidade('ES','VITÓRIA'),'SBVT','EURICO DE AGUIAR SALLES'),
	(dados_db.fn_cidade('GO','GOIÂNIA'),'SBGO','SANTA GENOVEVA/GOIÂNIA'),
	(dados_db.fn_cidade('GO','CALDAS NOVAS'),'SBCN','NELSON RODRIGUES GUIMARÃES'),
	(dados_db.fn_cidade('GO','RIO VERDE'),'SWLC','GENERAL LEITE DE CASTRO'),
	(dados_db.fn_cidade('MA','IMPERATRIZ'),'SBIZ','PREFEITO RENATO MOREIRA'),
	(dados_db.fn_cidade('MA','SÃO LUÍS'),'SBSL','MARECHAL CUNHA MACHADO'),
	(dados_db.fn_cidade('MG','CONFINS'),'SBCF','TANCREDO NEVES'),
	(dados_db.fn_cidade('MG','GOVERNADOR VALADARES'),'SBGV','CORONEL ALTINO MACHADO'),
	(dados_db.fn_cidade('MG','MONTES CLAROS'),'SBMK','MÁRIO RIBEIRO'),
	(dados_db.fn_cidade('MG','UBERLÂNDIA'),'SBUL','TEN CEL AVIADOR CÉSAR BOMBONATO'),
	(dados_db.fn_cidade('MG','UBERABA'),'SBUR','MARIO DE ALMEIDA FRANCO'),
	(dados_db.fn_cidade('MG','GOIANÁ'),'SBZM','PRESIDENTE ITAMAR FRANCO'),
	(dados_db.fn_cidade('MG','SANTANA DO PARAÍSO'),'SBIP','USIMINAS'),
	(dados_db.fn_cidade('MG','BELO HORIZONTE'),'SBBH','PAMPULHA - CARLOS DRUMMOND DE ANDRADE'),
	(dados_db.fn_cidade('MS','CAMPO GRANDE'),'SBCG','CAMPO GRANDE'),
	(dados_db.fn_cidade('MS','CORUMBÁ'),'SBCR','CORUMBÁ'),
	(dados_db.fn_cidade('MS','BONITO'),'SBDB','BONITO'),
	(dados_db.fn_cidade('MS','TRÊS LAGOAS'),'SBTG','TRÊS LAGOAS'),
	(dados_db.fn_cidade('MT','BARRA DO GARÇAS'),'SBBW','BARRA DO GARÇAS'),
	(dados_db.fn_cidade('MT','BARRA DO GARÇAS'),'SWPH','PARI-CACHOEIRA'),
	(dados_db.fn_cidade('MT','VÁRZEA GRANDE'),'SBCY','MARECHAL RONDON'),
	(dados_db.fn_cidade('MT','PORTO ALEGRE DO NORTE'),'SDH2','PORTO ALEGRE DO NORTE'),
	(dados_db.fn_cidade('MT','ARIPUANÃ'),'SSOU','ARIPUANÃ'),
	(dados_db.fn_cidade('MT','SÃO FÉLIX DO ARAGUAIA'),'SWFX','SÃO FÉLIX DO ARAGUAIA'),
	(dados_db.fn_cidade('MT','ÁGUA BOA'),'SWHP',"OLHOS D'ÁGUA"),
	(dados_db.fn_cidade('MT','JUÍNA'),'SWJN','JUÍNA'),
	(dados_db.fn_cidade('MT','TANGARÁ DA SERRA'),'SWTS','TANGARÁ DA SERRA'),
	(dados_db.fn_cidade('MT','ALTA FLORESTA'),'SBAT','PILOTO OSVALDO MARQUES DIAS'),
	(dados_db.fn_cidade('MT','RONDONÓPOLIS'),'SBRD','RONDONÓPOLIS - MAESTRO MARINHO FRANCO (*SWRD)'),
	(dados_db.fn_cidade('MT','SINOP'),'SBSI','PRESIDENTE JOÃO BATISTA FIGUEIREDO'),
	(dados_db.fn_cidade('MT','SORRISO'),'SBSO','REGIONAL DE SORRISO ADOLINO BEDIN (SDSS*)'),
	(dados_db.fn_cidade('PA','BELÉM'),'SBBE','INTERNACIONAL DE BELÉM/VAL DE CANS/JÚLIO CEZAR RIBEIRO'),
	(dados_db.fn_cidade('PA','ALMEIRIM'),'SBMD','MONTE DOURADO'),
	(dados_db.fn_cidade('PA','ALMEIRIM'),'SNYA','ALMEIRIM'),
	(dados_db.fn_cidade('PA','BREVES'),'SNVS','BREVES'),
	(dados_db.fn_cidade('PA','ITAITUBA'),'SBIH','ITAITUBA'),
	(dados_db.fn_cidade('PA','SANTARÉM'),'SBSN','MAESTRO WILSON FONSECA'),
	(dados_db.fn_cidade('PA','ORIXIMINÁ'),'SBTB','TROMBETAS'),
	(dados_db.fn_cidade('PA','ORIXIMINÁ'),'SNOX','ORIXIMINÁ'),
	(dados_db.fn_cidade('PA','TUCURUÍ'),'SBTU','TUCURUÍ'),
	(dados_db.fn_cidade('PA','PARAGOMINAS'),'SNEB','NAGIB DEMACHKI'),
	(dados_db.fn_cidade('PA','MONTE ALEGRE'),'SNMA','MONTE ALEGRE'),
	(dados_db.fn_cidade('PA','BREJO'),'SNRJ','JURUTI'),
	(dados_db.fn_cidade('PA','ÓBIDOS'),'SNTI','ÓBIDOS'),
	(dados_db.fn_cidade('PA','PARAUAPEBAS'),'SBCJ','CARAJÁS'),
	(dados_db.fn_cidade('PA','ALTAMIRA'),'SBHT','ALTAMIRA'),
	(dados_db.fn_cidade('PA','MARABÁ'),'SBMA','JOÃO CORREA DA ROCHA'),
	(dados_db.fn_cidade('PB','PATOS'),'SNTS','PATOS'),
	(dados_db.fn_cidade('PB','SANTA RITA'),'SBJP','PRESIDENTE CASTRO PINTO'),
	(dados_db.fn_cidade('PB','CAMPINA GRANDE'),'SBKG','PRESIDENTE JOÃO SUASSUNA'),
	(dados_db.fn_cidade('PE','RECIFE'),'SBRF','GUARARAPES - GILBERTO FREYRE'),
	(dados_db.fn_cidade('PE','SERRA TALHADA'),'SNHS','SANTA MAGALHÃES'),
	(dados_db.fn_cidade('PE','CARUARU'),'SNRU','CARUARU'),
	(dados_db.fn_cidade('PE','FERNANDO DE NORONHA'),'SBFN','FERNANDO DE NORONHA'),
	(dados_db.fn_cidade('PE','PETROLINA'),'SBPL','SENADOR NILO COELHO'),
	(dados_db.fn_cidade('PI','PARNAÍBA'),'SBPB','AEROPORTO INTERNACIONAL DE PARNAÍBA / PREFEITO DOUTOR JOÃO SILVA FILHO'),
	(dados_db.fn_cidade('PI','TERESINA'),'SBTE','SENADOR PETRÔNIO PORTELLA'),
	(dados_db.fn_cidade('PR','SÃO JOSÉ DOS PINHAIS'),'SBCT','AFONSO PENA'),
	(dados_db.fn_cidade('PR','PATO BRANCO'),'SBPO','JUVENAL LOUREIRO CARDOSO'),
	(dados_db.fn_cidade('PR','APUCARANA'),'SSAP','CAPITÃO JOÃO BUSSE'),
	(dados_db.fn_cidade('PR','ARAPONGAS'),'SSOG','ARAPONGAS'),
	(dados_db.fn_cidade('PR','CASCAVEL'),'SBCA','CORONEL ADALBERTO MENDES DA SILVA'),
	(dados_db.fn_cidade('PR','FOZ DO IGUAÇU'),'SBFI','CATARATAS'),
	(dados_db.fn_cidade('PR','LONDRINA'),'SBLO','GOVERNADOR JOSÉ RICHA'),
	(dados_db.fn_cidade('PR','MARINGÁ'),'SBMG','SÍLVIO NAME JÚNIOR'),
	(dados_db.fn_cidade('PR','PONTA GROSSA'),'SBPG','COMANDANTE ANTÔNIO AMILTON BERALDO'),
	(dados_db.fn_cidade('PR','TOLEDO'),'SBTD','LUIZ DALCANALE FILHO'),
	(dados_db.fn_cidade('PR','GUARAPUAVA'),'SSGG','TANCREDO THOMAS DE FARIA'),
	(dados_db.fn_cidade('RJ','CABO FRIO'),'SBCB','CABO FRIO'),
	(dados_db.fn_cidade('RJ','CAMPOS DOS GOYTACAZES'),'SBCP','BARTOLOMEU LISANDRO'),
	(dados_db.fn_cidade('RJ','RIO DE JANEIRO'),'SBGL','AEROPORTO INTERNACIONAL DO RIO DE JANEIRO/GALEÃO – ANTONIO CARLOS JOBIM'),
	(dados_db.fn_cidade('RJ','RIO DE JANEIRO'),'SBRJ','SANTOS DUMONT'),
	(dados_db.fn_cidade('RJ','MACAÉ'),'SBME','MACAÉ'),
	(dados_db.fn_cidade('RN','MOSSORÓ'),'SBMS','DIX-SEPT ROSADO'),
	(dados_db.fn_cidade('RN','SÃO GONÇALO DO AMARANTE'),'SBSG','GOVERNADOR ALUIZIO ALVES'),
	(dados_db.fn_cidade('RN','PARNAMIRIM'),'SBNT','AUGUSTO SEVERO'),
	(dados_db.fn_cidade('RO','PORTO VELHO'),'SBPV','GOVERNADOR JORGE TEIXEIRA DE OLIVEIRA'),
	(dados_db.fn_cidade('RO','JI-PARANÁ'),'SBJI','JI-PARANÁ'),
	(dados_db.fn_cidade('RO','VILHENA'),'SBVH','VILHENA'),
	(dados_db.fn_cidade('RR','BOA VISTA'),'SBBV','ATLAS BRASIL CANTANHEDE'),
	(dados_db.fn_cidade('RS','BAGÉ'),'SBBG','COMANDANTE GUSTAVO KRAEMER'),
	(dados_db.fn_cidade('RS','PORTO ALEGRE'),'SBPA','SALGADO FILHO'),
	(dados_db.fn_cidade('RS','VACARIA'),'SNEE','VACARIA NOVO'),
	(dados_db.fn_cidade('RS','CANELA'),'SSCN','CANELA'),
	(dados_db.fn_cidade('RS','ERECHIM'),'SSER','ERECHIM'),
	(dados_db.fn_cidade('RS','ALEGRETE'),'SSLT','GAUDÊNCIO MACHADO RAMOS'),
	(dados_db.fn_cidade('RS','SÃO BORJA'),'SSSB','SÃO BORJA'),
	(dados_db.fn_cidade('RS','SANTA CRUZ DO SUL'),'SSSC','SANTA CRUZ DO SUL'),
	(dados_db.fn_cidade('RS','SANTA ROSA'),'SSZR','LUIS ALBERTO LEHR'),
	(dados_db.fn_cidade('RS','CAXIAS DO SUL'),'SBCX','HUGO CANTERGIANI'),
	(dados_db.fn_cidade('RS','SANTO ÂNGELO'),'SBNM','SANTO ÂNGELO'),
	(dados_db.fn_cidade('RS','PELOTAS'),'SBPK','JOÃO SIMÕES LOPES NETO'),
	(dados_db.fn_cidade('RS','SANTA MARIA'),'SBSM','SANTA MARIA'),
	(dados_db.fn_cidade('RS','URUGUAIANA'),'SBUG','RUBEM BERTA'),
	(dados_db.fn_cidade('SC','CAÇADOR'),'SBCD','CARLOS ALBERTO DA COSTA NEVES'),
	(dados_db.fn_cidade('SC','FLORIANÓPOLIS'),'SBFL','HERCÍLIO LUZ'),
	(dados_db.fn_cidade('SC','CORREIA PINTO'),'SNCP','REGIONAL DO PLANALTO SERRANO'),
	(dados_db.fn_cidade('SC','SÃO MIGUEL DO OESTE'),'SSOE','HÉLIO WASUM'),
	(dados_db.fn_cidade('SC','CHAPECÓ'),'SBCH','SERAFIN ENOSS BERTASO'),
	(dados_db.fn_cidade('SC','JAGUARUNA'),'SBJA','REGIONAL SUL'),
	(dados_db.fn_cidade('SC','JOINVILLE'),'SBJV','LAURO CARNEIRO DE LOYOLA'),
	(dados_db.fn_cidade('SC','NAVEGANTES'),'SBNF','MINISTRO VICTOR KONDER'),
	(dados_db.fn_cidade('SE','ARACAJU'),'SBAR','SANTA MARIA'),
	(dados_db.fn_cidade('SP','JUNDIAÍ'),'SBJD','COMANDANTE ROLIM ADOLFO AMARO'),
	(dados_db.fn_cidade('SP','AREALVA'),'SBAE','BAURU/AREALVA'),
	(dados_db.fn_cidade('SP','ARAÇATUBA'),'SBAU','ESTADUAL DARIO GUARITA'),
	(dados_db.fn_cidade('SP','PRESIDENTE PRUDENTE'),'SBDN','PRESIDENTE PRUDENTE'),
	(dados_db.fn_cidade('SP','GUARULHOS'),'SBGR','GUARULHOS - GOVERNADOR ANDRÉ FRANCO MONTORO'),
	(dados_db.fn_cidade('SP','CAMPINAS'),'SBKP','VIRACOPOS'),
	(dados_db.fn_cidade('SP','MARÍLIA'),'SBML','FRANK MILOYE MILENKOVICH'),
	(dados_db.fn_cidade('SP','RIBEIRÃO PRETO'),'SBRP','LEITE LOPES'),
	(dados_db.fn_cidade('SP','SÃO PAULO'),'SBSP','CONGONHAS'),
	(dados_db.fn_cidade('SP','SÃO JOSÉ DO RIO PRETO'),'SBSR','PROFESSOR ERIBERTO MANOEL REINO'),
	(dados_db.fn_cidade('TO','GURUPI'),'SWGI','GURUPI'),
	(dados_db.fn_cidade('TO','PALMAS'),'SBPJ','BRIGADEIRO LYSIAS RODRIGUES'),
	(dados_db.fn_cidade('TO','ARAGUAÍNA'),'SWGN','ARAGUAÍNA');
