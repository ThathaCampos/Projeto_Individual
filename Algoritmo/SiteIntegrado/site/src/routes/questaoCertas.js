var express = require("express");
var router = express.Router();

var questaoCertaController = require("../controllers/questaoCertaController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrarAcerto", function (req, res) {
    questaoCertaController.cadastrarAcerto(req, res);
})

router.get("/mostrarAcerto/:fkUsuario", function (req, res) {
    questaoCertaController.mostrarAcerto(req, res);
})

router.get("/mostrarRanking", function (req, res) {
    questaoCertaController.mostrarRanking(req, res);
})

router.get("/mostrarGrafico", function(req, res){
    questaoCertaController.mostrarGrafico(req, res);
})

router.post("/avaliarQuiz", function (req, res){
    questaoCertaController.avaliarQuiz(req, res);
}) 
// Vai inserir no banco de dados = (post)
// Vai pegar no banco de dados = (get)
// Dar um update no banco de dados = (put)
module.exports = router;