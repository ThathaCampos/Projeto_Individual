// sessão
function validarSessao() {
    var email = sessionStorage.setItem('email');
    var nome = sessionStorage.setItem('nomeUsuario');

    var b_usuario = document.getElementById("b_usuario");
    
    if (email != null && nome != null) {
        b_usuario.innerHTML = nome;
        b_usuario.innerHTML = email;
    } else {
        window.location = "../login.html";
    }
}


// Validar quantidade de acertos
function validarAcerto() {
    var quantidade = sessionStorage.setItem('quantCerta');

    var b_quantidade = document.getElementById("b_quantidade");
    
    if(quantidade != null) {
        b_quantidade.innerHTML = quantidade;
    } else{
        window.location = "../login.html";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../login.html";
}

// carregamento (loading)
function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("div_erros_login");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}

