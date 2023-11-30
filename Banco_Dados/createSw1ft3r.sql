create database sw1ft3r;
use sw1ft3r;


create table usuario(
idUsuario int primary key auto_increment,
nomeCompleto varchar(45),
dtNasc date,
email varchar(45),
nomeUsuario varchar(45) unique,
senha varchar(45)
);
select * from usuario;


create table questaoCerta(
idQuestaoCerta int auto_increment,
fkUsuario int,
quantCerta int,
dtHora timestamp default current_timestamp,
primary key (idQuestaoCerta, fkUsuario),
constraint fkQuestaoUsuario foreign key (fkUsuario) references usuario(idUsuario)
);
select * from questaoCerta;

create table feedback(
idFeedback int auto_increment,
fkUsuario int,
quantEstrelas int,
dtAvaliacao timestamp default current_timestamp,
primary key (idFeedback, fkUsuario),
constraint fkAvaliaUsuario foreign key (fkUsuario) references usuario (idUsuario)
);
select * from feedback;



-- Selects/ Inserts da table usuario
insert into usuario(nomeCompleto, dtNasc, email, nomeUsuario, senha) values
('Thamires Campos', '2002-03-29', 'thamires@email.com', 'Thatha', '123456'),
('Lucas Carvalho', '2004-07-03', 'lucas@email.com', 'Batman', 'batman123'),
('Bruno Araújo', '2004-08-20', 'bruno@email.com', 'Efacil', 'css123456');

select fkUsuario, nomeUsuario, max(quantCerta) Quantidade_de_acertos from questaoCerta join usuario on fkUsuario = idUsuario 
group by fkUsuario, nomeUsuario order by Quantidade_de_acertos and nomeUsuario limit 3;

select nomeUsuario,
	   quantCerta, dtHora
from questaoCerta
join usuario on fkUsuario = idUsuario
where quantCerta >= 0 
order by dtHora desc;

select nomeUsuario,
	   (select max(quantCerta) from questaoCerta join usuario on fkUsuario = idUsuario),
	   quantCerta Quantidade_de_acertos
from questaoCerta
join usuario on fkUsuario = idUsuario 
where quantCerta > 8
order by Quantidade_de_acertos and nomeUsuario;


-- Selects/ Inserts da table questaoCerta
insert into questaoCerta (fkUsuario, quantCerta) values
(1, 13),
(2, 8),
(3, 5);
select * from questaoCerta;
delete from questaoCerta where idQuestaoCerta in (4, 6, 7, 8, 12,13, 14);
SELECT quantCerta from questaoCerta where fkUsuario = 1 order by idQuestaoCerta desc limit 1;
select count(quantCerta) Menor_Que_Cinco,
	   (select count(quantCerta) from questaoCerta where quantCerta > 5 and quantCerta <= 8) Menor_Que_8,
       (select count(quantCerta) from questaoCerta where quantCerta > 8) Maior_Que_8
from questaoCerta
where quantCerta <= 5;

-- Selects da table feedback
select count(quantEstrelas) Igual_1,
	   (select count(quantEstrelas) from feedback where quantEstrelas = 2) Igual_2,
       (select count(quantEstrelas) from feedback where quantEstrelas = 3) Igual_3,
       (select count(quantEstrelas) from feedback where quantEstrelas = 4) Igual_4,
       (select count(quantEstrelas) from feedback where quantEstrelas = 5) Igual_5
from feedback
where quantEstrelas = 1;

select quantEstrelas from feedback where fkUsuario = 1;

