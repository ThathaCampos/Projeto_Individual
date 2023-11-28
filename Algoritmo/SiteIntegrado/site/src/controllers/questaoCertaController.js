var questaoCertaModel = require("../models/questaoCertaModel");

function cadastrarAcerto(req, res) {
    var quantCerta = req.body.quantCertaServer;
    var fkUsuario = req.body.fkUsuarioServer;

    if (quantCerta == undefined) {
        res.status(400).send("Quantidade de acertos inválidos!");
    } else if (fkUsuario == undefined) {
        res.status(400).send("O usuario inválido!");
    } else {

        questaoCertaModel.cadastrarAcerto(fkUsuario, quantCerta)
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

function mostrarAcerto(req, res) {
    var fkUsuario = req.params.fkUsuario;

    if (fkUsuario == undefined) {
        res.status(400).send("O usuario inválido!");
    } else {

        questaoCertaModel.mostrarAcerto(fkUsuario)
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


function mostrarRanking(req, res) {
   
        questaoCertaModel.mostrarRanking()
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

function mostrarGrafico(req, res) {
    
    questaoCertaModel.mostrarGrafico()
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

function avaliarQuiz(req, res) {

    var quantEstrelas = req.body.quantEstrelasServer;
    var fkUsuario = req.body.fkUsuarioServer;

    questaoCertaModel.avaliarQuiz(fkUsuario, quantEstrelas)
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

function mostrarAvaliacao(req, res) {

    questaoCertaModel.mostrarAvaliacao()
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

module.exports = {
    cadastrarAcerto,
    mostrarAcerto,
    mostrarRanking,
    mostrarGrafico,
    avaliarQuiz,
    mostrarAvaliacao
}