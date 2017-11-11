$("#CerrarSesion").click(function () {
    $.ajax({
        type: "POST",
        url: "/WebMovil/SMovil",
        data: {
            "accion": "CerrarSesion"
        },
        success: function (data) {
            alert("Correcto");
            }
        });

});


