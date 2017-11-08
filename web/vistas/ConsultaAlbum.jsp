<%-- 
    Document   : ConsultaAlbum
    Created on : 27/10/2017, 04:16:18 PM
    Author     : Brian
--%>

<%@page import="servicios.DtTemaRemoto"%>
<%@page import="servicios.DtSuscripcion"%>
<%@page import="servicios.DtCliente"%>
<%@page import="servicios.DtUsuario"%>
<%@page import="servicios.DtTemaLocal"%>
<%@page import="servicios.DtTema"%>
<%@page import="java.util.ArrayList"%>
<%@page import="servicios.DtAlbumContenido"%>
<%@page import="servicios.DtAlbum"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="estilos/inicio.css">
        <jsp:include page="../scripts/Inicio.html"/>
        <jsp:include page="include.html"/>
        <style>           

        </style>
    </head>
    <body style="background-color: black" >
        <%
            DtAlbumContenido albumes = (DtAlbumContenido) request.getAttribute("Album");
            DtUsuario artista = (DtUsuario) request.getAttribute("Artista");
            DtAlbum inf = (DtAlbum) albumes.getInfo();
            ArrayList<String> Generos = (ArrayList) albumes.getGeneros();
            ArrayList<DtTema> temas = (ArrayList) albumes.getTemas();
            String nombre = artista.getNombre();
            String apellido = artista.getApellido();
            String imagen = inf.getImagen();
            String nombreAlbum = inf.getNombre();
            int anioCreacion = inf.getAnio();
        %>
        <div class="row "  >
            <div class="col-lg-12 col-xs-6 col-sm-6 col-md-6 col-md-offset-5 col-xs-offset-3 col-sm-offset-4 col-lg-offset-5" >
                <td><h2 style="color: whitesmoke"><%= nombre%> <%= apellido%></h2></td>
                <td><h2 style="color: whitesmoke"><%= nombreAlbum%>,<%= anioCreacion%> </h2></td>
                <td><h2 style="color: whitesmoke">Generos: <% for (int i = 0; i < Generos.size(); i++) {%><%= Generos.get(i)%><%}%></h2></td>
            </div>
        </div>          
    </div> 
    <%-- Temas --%>
    <div class="table-responsive col-lg-10 col-md-10 col-md-offset-1 col-lg-offset-1" style=" border-color: transparent"  >
        <div class="panel-group" >
            <div class="panel panel-default" >
                <% for (int i = 0; i < temas.size(); i++) {%>
                <div class="panel" style="background-color: black;border-bottom-width: 1px; border-bottom-color:white "  >
                    <div class="row"><h2 class="panel-title col-lg-11 col-xs-10 col-md-11 .col-xl-11" style="color: whitesmoke"><%=temas.get(i).getNombre()%> </h2>
                        <a class="col-lg-1" data-toggle="collapse" href="#<%=i%>" >
                            <span class="glyphicon glyphicon-plus  " aria-hidden="true"></span></a>                      
                    </div>
                </div>
                <div id="<%= i%>" class="panel-collapse collapse" >
                    <ul class="list-group"  >
                        <li class="list-group-item" style="color: black">Duracion: <%= temas.get(i).getDuracion().getHoras()%>:<%= temas.get(i).getDuracion().getMinutos()%>:<%= temas.get(i).getDuracion().getSegundos()%></li>
                        <li class="list-group-item" style="color: black">Ubicacion: <%= temas.get(i) instanceof DtTemaLocal ? ((DtTemaLocal) temas.get(i)).getDirectorio() : ((DtTemaRemoto) temas.get(i)).getUrl()%></li>
                        <li class="list-group-item" style="color: black"><input readonly onclick="Descarga('<%=((DtTemaLocal) temas.get(i)).getDirectorio()%>')" class="btn btn-info" id="btnDescargar" value="Descargar"></li>
                        
                    </ul>
                </div>
                <% }%>
            </div>
        </div>
    </div>

</body>
</html>
