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

module.exports = {
    cadastrarAcerto,
    mostrarAcerto,
    mostrarRanking
};