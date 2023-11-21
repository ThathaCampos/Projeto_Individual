var usuarioModel = require("../models/usuarioModel");


function autenticar(req, res) {
    var nomeUsuario = req.body.nomeUsuarioServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;


    if (nomeUsuario == "") {
        res.status(400).send("Insira um usuário válido!");
    }else if(email == "") {
        res.status(400).send("Insira um email válido!");
    }else if (senha == "") {
        res.status(400).send("Insira uma senha válida!");

    } else {
        usuarioModel.autenticar(nomeUsuario, email, senha)
            .then(
                function (resultadoAutenticar) {
                    if (resultadoAutenticar.length == 0) {
                        res.status(400).send('Usuário e/ou senha inválidos!');
                        console.log(`Login Controller:  ${resultadoAutenticar}`);
                    } else {
                        res.status(201).json(resultadoAutenticar);
                        console.log(`Login Controller Certo: ${resultadoAutenticar}`);
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nomeCompleto = req.body.nomeCompletoServer;
    var dtNasc = req.body.dataServer;
    var email = req.body.emailServer;
    var nomeUsuario = req.body.nomeUsuarioServer;
    var senha = req.body.senhaServer;

    // Faça as validações dos valores
    if (nomeUsuario == undefined) {
        res.status(400).send("Seu nome de usuário está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (dtNasc == undefined) {
        res.status(400).send("Sua data de nascimento está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nomeCompleto, dtNasc, email, nomeUsuario, senha)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    autenticar,
    cadastrar
}