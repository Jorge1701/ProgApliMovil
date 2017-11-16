<%-- 
    Document   : Listado
    Created on : 31/10/2017, 01:18:03 AM
    Author     : Brian
--%>

<%@page import="servicios.DtUsuario"%>
<%@page import="servicios.DtLista"%>
<%@page import="java.util.ArrayList"%>
<%@page import="servicios.DtAlbum"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Espotify</title>
        <link rel="stylesheet" type="text/css" href="estilos/inicio.css">
        <jsp:include page="../scripts/Inicio.html"/>
        <jsp:include page="include.html"/>
    </head>
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
                font-size:20px;
            }
        }
        h1 {
            font-size:15px;
        }



    </style>
    <body>
        <%
            DtUsuario user = (DtUsuario) request.getSession().getAttribute("usuario");
        %>



        <div class="tab-content">

        </div>
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
                            <a class="nav-link " data-toggle="tab" onclick="irInicio()" role="tab">Inicio</a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="albumes" class ="tab-pane fade in active">              
                    <%  ArrayList<DtAlbum> albumes = (ArrayList<DtAlbum>) request.getAttribute("albumes");
                        if (albumes.size() == 0) {
                            out.print("<div class=\"panel panel-default col-lg-3 col-xs-6 col-sm-6 col-md-6\"><h1>No hay Albumes</h1></div>");
                        } else {
                            out.print("<div class=\"row\"><div style=\"margin-top: 20px\"></div></div>");
                            for (int i = 0; i < albumes.size(); i++) {
                         
                                if (i == 0 || i % 4 == 0) {
                                    if (i != 0) {
                                        out.print("</div>");
                                    }
                                    out.print("<div class=\"row\">");
                                }
                                out.print("<div class=\"col-lg-3 col-xs-6 col-sm-6 col-md-6\">");
                                out.print("<div class=\"panel panel-default\" style=\"margin-left: 10px; margin-right: 10px \" onclick=\"ConsultaAlbum('" + albumes.get(i).getNickArtista() + "','" + albumes.get(i).getNombre() + "')\">");
                                out.print("<h1 class=\"text-center\" >" + albumes.get(i).getNombre() + "</h1>");
                                out.print("</div>");
                                out.print("</div>");
                       
                            }
                            out.print("</div>");
                        }%>
                </div>
            </div>
        </nav>
    </body>
</html>
