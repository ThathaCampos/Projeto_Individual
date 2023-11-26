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
select * from questaoCerta;
delete from questaoCerta where idQuestaoCerta in (4, 6, 7, 8, 12,13, 14);
SELECT quantCerta from questaoCerta where fkUsuario = 1 order by idQuestaoCerta desc limit 1;

create table feedback(
idFeedback int,
fkUsuario int,
quantEstrelas int,
dtAvaliacao timestamp,
primary key (idFeedback, fkUsuario),
constraint fkAvaliaUsuario foreign key (fkUsuario) references usuario (idUsuario)
);