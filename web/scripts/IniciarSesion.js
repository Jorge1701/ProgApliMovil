
$("#btnIniciarSesion").click(function () {
    var x = document.getElementById("recordar");
    var check;
    if (x.checked) {
        check = "true";
    } else {
        check = "false";
    }
    $.ajax({
        type: "POST",
        url: "/WebMovil/SMovil",
        data: {
            "accion": "iniciarSesion",
            "nickname": $("#txtNickname").val().toString(),
            "recordar": check.toString(),
            "contrasenia": md5($("#txtPass").val().toString())
        },
        success: function (data) {
            if (data.toString() === "correcto") {
                window.location = "/WebMovil/SMovil?accion=Inicio";
            } else {
                window.location = "/WebMovil/SMovil?accion=error&mensaje=" + data.toString();
            }
        }

    });

});



