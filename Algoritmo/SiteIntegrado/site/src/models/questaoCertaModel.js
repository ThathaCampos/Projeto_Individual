var database = require("../database/config")

function cadastrarAcerto(quantCerta, fkUsuario) {
    var instrucao = `
        INSERT INTO questaoCerta (quantCerta, fkUsuario) VALUES ('${quantCerta}', '${fkUsuario}');
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
    select fkUsuario, nomeUsuario, max(quantCerta) Quantidade_de_acertos from questaoCerta join usuario on fkUsuario = idUsuario 
group by fkUsuario, nomeUsuario order by Quantidade_de_acertos and nomeUsuario limit 3;
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
module.exports = {
    cadastrarAcerto,
    mostrarAcerto,
    mostrarRanking,
    mostrarGrafico
};