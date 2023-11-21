var questaoCertaModel = require("../models/questaoCertaModel");

function cadastrarAcerto(req, res) {
    var quantAcerto = req.body.quantAcertoServer;
    var fkUsuario = req.body.fkUsuarioServer;

    if (quantAcerto == undefined) {
        res.status(400).send("Quantidade de acertos inválidos!");
    } else if (fkUsuario == undefined) {
        res.status(400).send("O usuario inválido!");
    } else {

    questaoCertaModel.cadastrarAcerto(quantAcerto, fkUsuario)
            .then(
                function (resultado) {
                    res.status(201).json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    res.status(500).send("Esse usuário já existe!");
                }
            );
            }
    }

module.exports = {
    cadastrarAcerto
}