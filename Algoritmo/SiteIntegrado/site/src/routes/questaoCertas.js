var express = require("express");
var router = express.Router();

var questaoCertaController = require("../controllers/questaoCertaController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrarAcerto", function (req, res) {
    questaoCertaController.cadastrarAcerto(req, res);
})

module.exports = router;