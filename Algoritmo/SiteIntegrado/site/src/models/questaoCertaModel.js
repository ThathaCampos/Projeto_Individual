var database = require("../database/config")

function cadastrarAcerto(quantCerta, fkUsuario) {
    var instrucao = `
        INSERT INTO questaoCerta (quantCerta, fkUsuario) VALUES ('${quantCerta}', '${fkUsuario}');
        `
    return database.executar(instrucao);
}

module.exports = {
    cadastrarAcerto
};