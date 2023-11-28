-- Treinar a função VIEW;
create database view_db;
use view_db;

use dados_db;

-- Consultar dados de cidade e estado exibindo a o Id da cidade, sigla do estado e o nome da cidade
select cid.id, est.sigla sigla_estado, cid.nome nome_cidade
from cidade cid
inner join estado est on est.id = cid.fkestado;

-- Consultar dados de cidade, estado e aeroporto exibindo a sigla do estado e do aeroporto, mais o nome da cidade
select cid.id, est.sigla sigla_estado, cid.nome nome_cidade, aer.nome aeroporto
from aeroporto aer
inner join cidade cid on cid.id = aer.fkcidade
inner join estado est on est.id = cid.fkestado;

-- Crie uma view com o Select da 1º consulta deste exercício
create view vw_cidade
as
select cid.id, est.sigla sigla_estado, cid.nome nome_cidade
from cidade cid
inner join estado est on est.id = cid.fkestado;

-- Consultar todas as cidades do estado de São Paulo existentes na View criada pela sigla do estado
select * from vw_cidade where sigla_estado = 'SP';

-- Consultar os aeroportos do estado de São Paulo utilizando a View criada
select aer.nome nome_aeroporto, aer.sigla
from aeroporto aer
inner join vw_cidade cid on cid.id = aer.fkcidade
where cid.sigla_estado = 'SP';

-- Crie uma View que retorne a sigla do aeroporto, do estado e o nome da cidade
create view vw_aeroporto
as
select ae.sigla sigla_aeroporto, 
       es.sigla sigla_uf,
       ci.nome cidade
from aeroporto ae
inner join cidade ci on ci.id = ae.fkcidade
inner join estado es on es.id =ci.fkestado;

select * from vw_aeroporto where sigla_uf = 'PE';


