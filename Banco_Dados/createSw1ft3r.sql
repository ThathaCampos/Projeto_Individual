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
SELECT idUsuario, nomeUsuario, email, senha FROM usuario WHERE nomeUsuario = 'thamires@email.com' AND email = '123456' AND senha = 'undefined';

create table questaoCerta(
idQuestaoCerta int auto_increment,
fkUsuario int,
quantCerta int,
primary key (idQuestaoCerta, fkUsuario),
constraint fkQuestaoUsuario foreign key (fkUsuario) references usuario(idUsuario)
);
select * from questaoCerta;

create table feedback(
idFeedback int,
fkUsuario int,
quantEstrelas int,
dtAvaliacao timestamp,
primary key (idFeedback, fkUsuario),
constraint fkAvaliaUsuario foreign key (fkUsuario) references usuario (idUsuario)
);