<%-- 
    Document   : pagina_error
    Created on : 27/10/2017, 07:06:36 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina de error</title>
        <link rel="stylesheet" type="text/css" href="estilos/inicio.css">
        <jsp:include page="../scripts/Inicio.html"/>
        <jsp:include page="include.html"/>
    </head>
    <body style="background-color: black">
        <nav class="navbar navbar-inverse navbar-fixed-top"  style="background-color: black">
            
                        
            <div class="table-responsive col-lg-10 col-md-10 col-md-offset-1 col-lg-offset-1" style=" border-color: transparent"  >
                
                 <div>
                    <ul class="nav nav-pills" >
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" onclick="irInicio()" role="tab">Ir al Inicio</a>
                        </li>
                    </ul>
                </div>
                <div>
                    <h1 style="color: greenyellow"> <%= request.getAttribute("mensaje_error")%> </h1>
                </div>    
            </div>    
        </nav>       
    </body>
</html>
