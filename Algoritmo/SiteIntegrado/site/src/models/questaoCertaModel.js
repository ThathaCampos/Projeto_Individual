var database = require("../database/config")

function cadastrarAcerto(fkUsuario, quantCerta) {
    var instrucao = `
        INSERT INTO questaoCerta (fkUsuario, quantCerta) VALUES ('${fkUsuario}', '${quantCerta}');
        `
    return database.executar(instrucao);
}

function mostrarAcerto(fkUsuario) {
    var instrucao = `
    SELECT quantCerta from questaoCerta where fkUsuario = ${fkUsuario} order by idQuestaoCerta desc limit 1;
    `
    return database.executar(instrucao);
}

function mostrarRanking() {
    var instrucao = `
    select nomeUsuario,
	   quantCerta as Quantidade_de_acertos
    from questaoCerta
    join usuario on fkUsuario = idUsuario
    where quantCerta >= 0
    order by quantCerta and nomeUsuario desc limit 3;
    `
    return database.executar(instrucao);
}


function mostrarGrafico() {
    var instrucao = `
    select count(quantCerta) Menor_Que_Cinco,
	   (select count(quantCerta) from questaoCerta where quantCerta > 5 and quantCerta <= 8) Menor_Que_8,
       (select count(quantCerta) from questaoCerta where quantCerta > 8) Maior_Que_8
    from questaoCerta where quantCerta <= 5;
    `
    return database.executar(instrucao);
}

function avaliarQuiz(fkUsuario, quantEstrelas) {

    var instrucao = `
    insert into feedback (fkUsuario, quantEstrelas) values (${fkUsuario}, ${quantEstrelas});
    `
    return database.executar(instrucao);
}

function mostrarAvaliacao() {

    var instrucao = `
    select count(quantEstrelas) Igual_1,
	   (select count(quantEstrelas) from feedback where quantEstrelas = 2) Igual_2,
       (select count(quantEstrelas) from feedback where quantEstrelas = 3) Igual_3,
       (select count(quantEstrelas) from feedback where quantEstrelas = 4) Igual_4,
       (select count(quantEstrelas) from feedback where quantEstrelas = 5) Igual_5
from feedback
where quantEstrelas = 1;
    `
    return database.executar(instrucao);
}
module.exports = {
    cadastrarAcerto,
    mostrarAcerto,
    mostrarRanking,
    mostrarGrafico,
    avaliarQuiz,
    mostrarAvaliacao
};