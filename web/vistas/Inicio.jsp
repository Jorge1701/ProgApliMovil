<%-- 
    Document   : Inicio
    Created on : 29/10/2017, 10:55:54 PM
    Author     : Brian
--%>

<%@page import="servicios.DtListaParticular"%>
<%@page import="servicios.DtUsuario"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Espotify</title>

        <jsp:include page="../scripts/Inicio.html"/>
        <jsp:include page="include.html"/>
        <style>


            @media (max-width: 700px) { 
                ul {
                    list-style-type: none;
                    margin: 0;
                    padding: 0;
                    width: 60px;
                } 

                li a.nav-link {
                    display: block;
                }
                h1 {
                    font-size:20px;
                }

            }

            @media (max-width: 500px) { 
                h1 {
                    height: 30px;
                    font-size:20 px;
                }
            }
            h1 {
                font-size:15px;
            }



        </style>  
        <%
            DtUsuario user = (DtUsuario) request.getSession().getAttribute("usuario");
        %>
    </head>

    <body style="background-color: black">
        <!-- Static navbar -->
        <nav class="navbar navbar-inverse navbar-fixed-top"  style="background-color: black">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span style="color: greenyellow" class="sr-only">Menu</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#" style="color: greenyellow">Bienvenido <%= user.getNickname()%></a>
                </div>
                <!-- Nav tabs -->
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav nav-pills" >
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#Generos" role="tab">Generos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#Artistas" role="tab">Artistas</a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" id="Generos" role="tabpanel">
                    <%
                        // Cargar Generos
                        ArrayList<String> generos = (ArrayList<String>) request.getAttribute("generos");
                        if (generos.size() == 0) {
                            // Mostrar mensaje si no hay generos
                            out.print("<div class=\"panel panel-default\"><h1>No hay generos</h1></div>");
                        } else {
                            //  Separador para que haya un margen arriba
                            out.print("<div class=\"row\"><div style=\"margin-top: 20px\"></div></div>");
                            // Recorrer generos
                            for (int i = 0; i < generos.size(); i++) {
                                if (i == 0 || i % 4 == 0) { // Cada 4 generos ir a una nueva fila (4 generos por columna)
                                    if (i != 0) {
                                        out.print("</div>");
                                    }
                                    out.print("<div class=\"row\">");
                                }
                                out.print("<div class=\" col-lg-3 col-xs-6 col-sm-6 col-md-6\">"); // El 3 sale de 12 / generos por columnas
                                out.print("<div class=\"panel panel-default\" style=\"margin-left: 10px;margin-right: 10px;\" onclick =\"irAGenero('" + generos.get(i) + "')\">"
                                ); // Llama a la funcion irAGenero con el nombre del genero
                                out.print("<h1 class=\"text-center\">" + generos.get(i) + "</h1>"); // Muestra el nombre de genero
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                        }
                    %>    
                </div>
                <div class="tab-pane" id="Artistas" role="tabpanel">
                    <%
                        // Cargar artistas
                        ArrayList<DtUsuario> artistas = (ArrayList<DtUsuario>) request.getAttribute("artistas");

                        if (artistas.size() == 0) {
                            // Mostrar mensaje si no hay artistas
                            out.print("<div class=\"panel panel-default\"><h1>No hay artistas</h1></div>");
                        } else {
                            // Separador para que haya un margen arriba
                            out.print("<div class=\"row\"><div style=\"margin-top: 20px\"></div></div>");

                            // Recorrer artistas
                            for (int i = 0; i < artistas.size(); i++) {
                                if (i == 0 || i % 4 == 0) { // Cada 4 artistas ir a una nueva fila (4 artistas por columna)
                                    if (i != 0) {
                                        out.print("</div>");
                                    }
                                    out.print("<div class=\"row\">");
                                }
                                out.print("<div class=\"col-lg-3 col-xs-6 col-sm-6 col-md-6\">"); // El 3 sale de 12 / artistas por columnas
                                out.print("<div class=\"panel panel-default\" style=\"margin-left: 2px;margin-right: 2px;\" onclick=\"irAPerfil('" + artistas.get(i).getNickname() + "')\">"); // Llama a la funcion irAPerfil con el nick del artista
                                out.print("<h1 class=\"text-center\">" + artistas.get(i).getNombre() + " " + artistas.get(i).getApellido() + "</h1>"); // Muestra el nombre de artista
                                out.print("</div>");
                                out.print("</div>");
                            }

                            out.print("</div>");
                        }
                    %>

                </div>
            </div>
        </nav>

    </body>
</html>
