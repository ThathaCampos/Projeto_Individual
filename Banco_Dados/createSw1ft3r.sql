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

create table questaoCerta(
idQuestaoCerta int,
fkUsuario int,
numeroQuestao int,
primary key (idQuestaoCerta, fkUsuario),
constraint fkQuestaoUsuario foreign key (fkUsuario) references usuario(idUsuario)
);

create table feedback(
idFeedback int,
fkUsuario int,
quantEstrelas int,
dtAvaliacao timestamp,
primary key (idFeedback, fkUsuario),
constraint fkAvaliaUsuario foreign key (fkUsuario) references usuario (idUsuario)
);