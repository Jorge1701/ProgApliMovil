<%-- 
    Document   : InicioSesion
    Created on : 27/10/2017, 04:21:33 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="include.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Espotify</title>

    </head>
    <body style="background-color: #2e6da4">


        <div class="col-lg-4 col-md-3 col-sm-2 col-xs-1"></div>

        <div class="col-lg-4 col-md-6 col-sm-8 col-xs-12">

            <div class="row "  >
                <div class="col-lg-7 col-xs-10 col-sm-6 col-sm-offset-3 col-md-7 col-md-offset-1 col-xs-offset-1  col-lg-offset-3" >
                    <td><img src="media/icono.png" class="center-block"  width="100" height="100" style="margin-top: 4px"></td>
                    <td><h1 style="color: white" >Iniciar Sesión</h1></td>
               
                </div>
            </div>  

            
            
            <form action="/WebMovil/SMovil" method="POST" id="iniciar">
                <div class="input-group input-group-md" style="margin-top: 50px">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                    <input id="txtNickname" type="text" class="form-control" name="nickname" placeholder="Nickname" required="required"  autofocus="autofocus">
                </div>

                <br>
                <div class="input-group input-group-md">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>

                    <input id="txtPass" type="password" class="form-control" name="contrasenia" placeholder="Contraseña" required="required" >

                </div>
                <div class="input-group input-group-md"style="margin-top: 10px">
                    <input id="recordar" type="checkbox" ><text style="color: white"> Recordarme</text>
                </div>

                <%
                    String error = "";
                    if (request.getAttribute("error") != null) {
                        error = request.getAttribute("error").toString();
                    }

                    if (!error.equals("")) {
                %>
                <div id="mensajeError">
                    <br>
                    <span class="glyphicon glyphicon-alert" style="color: red"> <%= error%> </span>
                    <br>
                </div>
                <% }%>

                <br>
                <input type="button" class="btn btn-default" id="btnIniciarSesion" value="Iniciar Sesion"/>
            </form>
        </div>


        <script src="scripts/md5.min.js" type="text/javascript"></script>
        <script src="scripts/IniciarSesion.js" type="text/javascript"></script>
    </body>
</html>
