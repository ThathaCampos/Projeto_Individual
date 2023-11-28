create database sw1ft3r;
use sw1ft3r;

create table usuario(
idUsuario int primary key auto_increment,
nomeCompleto varchar(45),
dtNasc date,
email varchar(45),
nomeUsuario varchar(45),
senha varchar(45)
);


insert into usuario (idUsuario) values
	(1),
    (2),
    (3),
    (4);
    
insert into usuario (idUsuario, nomeUsuario) values
	(10, 'Thamires'),
    (11, 'Vitor'),
    (12, 'Caique'),
    (13, 'Bruno');

select * from usuario;
select fkUsuario, nomeUsuario, max(quantCerta) Quantidade_de_acertos from questaoCerta join usuario on fkUsuario = idUsuario 
group by fkUsuario, nomeUsuario order by Quantidade_de_acertos and nomeUsuario limit 3;



create table questaoCerta(
idQuestaoCerta int auto_increment,
fkUsuario int,
quantCerta int,
primary key (idQuestaoCerta, fkUsuario),
constraint fkQuestaoUsuario foreign key (fkUsuario) references usuario(idUsuario)
);

insert into questaoCerta (fkUsuario, quantCerta) values
	(1, 4),
    (1, 6),
    (1, 13),
    (2, 13),
    (2, 10),
    (3, 3),
    (3, 8);

insert into questaoCerta (fkUsuario, quantCerta) values
	(2, 7);
    
insert into questaoCerta (fkUsuario, quantCerta) values
	(10, 13),
    (11, 12),
    (12, 10),
    (13, 9);

select * from questaoCerta;
delete from questaoCerta where idQuestaoCerta in (4, 6, 7, 8, 12,13, 14);
SELECT quantCerta from questaoCerta where fkUsuario = 1 order by idQuestaoCerta desc limit 1;
select count(quantCerta) Menor_Que_Cinco,
	   (select count(quantCerta) from questaoCerta where quantCerta > 5 and quantCerta <= 8) Menor_Que_8,
       (select count(quantCerta) from questaoCerta where quantCerta > 8) Maior_Que_8
from questaoCerta
where quantCerta <= 5;

select nomeUsuario,
	   quantCerta
from questaoCerta
join usuario on fkUsuario = idUsuario
where quantCerta >= 0
order by quantCerta and nomeUsuario desc limit 3;

select nomeUsuario,
	   (select max(quantCerta) from questaoCerta join usuario on fkUsuario = idUsuario),
	   quantCerta Quantidade_de_acertos
from questaoCerta
join usuario on fkUsuario = idUsuario 
where quantCerta > 8
order by Quantidade_de_acertos and nomeUsuario;


create table feedback(
idFeedback int auto_increment,
fkUsuario int,
quantEstrelas int,
dtAvaliacao timestamp default current_timestamp,
primary key (idFeedback, fkUsuario),
constraint fkAvaliaUsuario foreign key (fkUsuario) references usuario (idUsuario)
);

select * from feedback;

