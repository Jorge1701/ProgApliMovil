<%-- c
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
        <title>Espotify</title>
        <link rel="stylesheet" type="text/css" href="estilos/inicio.css">
        <jsp:include page="../scripts/Inicio.html"/>
        <jsp:include page="include.html"/>
        <style>           
        </style>

    </head>
    <body style="background-color: black" >
        <%
            DtUsuario user = (DtUsuario) request.getSession().getAttribute("usuario");
            DtSuscripcion actual = ((DtCliente) user).getActual();
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
                            <a class="nav-link active" data-toggle="tab" onclick="irInicio()" role="tab">Inicio</a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="row "  >
                <div class="col-lg-12 col-xs-12 col-sm-12 col-md-12" >
                    <td><h2 class="text-center" style="color: whitesmoke"><%= nombre%> <%= apellido%></h2></td
                    <td><br></td>
                    <td><h4 class="text-center" style="color: whitesmoke"><%= nombreAlbum%></h4></td>
                    <td><br></td>
                    <td><h5 class="text-center" style="color: whitesmoke">Año: <%= anioCreacion%></h5></td>
                    <td><h5 class="text-center" style="color: whitesmoke">Géneros: | <% for (int i = 0; i < Generos.size(); i++) {%><%= Generos.get(i) + " | "%><%}%></h5></td>
                </div>
            </div>          
        </div> 
        <%-- Temas --%>
        <div class="table-responsive col-lg-10 col-md-10 col-md-offset-1 col-lg-offset-1" style=" border-color: transparent"  >
            <div class="panel-group" >
                <div class="panel panel-default" >
                    <% for (int i = 0; i < temas.size(); i++) {
                    %>
                    <div class="panel" style="background-color: black;border-bottom-width: 1px; border-bottom-color:white "  >
                        <div class="row"> <div class="panel-heading">
                                <h2 class="panel-title col-lg-11 col-xs-10 col-md-11 .col-xl-11" style="color: whitesmoke"><%=temas.get(i).getNombre()%> </h2>
                                <a class="col-lg-1 " data-toggle="collapse"  href="#<%=i%>" >
                                    <span class="glyphicon glyphicon-plus  "></span></a>     
                            </div>
                        </div>
                    </div>
                    <div id="<%= i%>" class="panel-collapse collapse" >
                        <ul class="list-group"  >
                            <li class="list-group-item" style="color: black; width: 250px">Duracion: <%= temas.get(i).getDuracion().getHoras()%>:<%= temas.get(i).getDuracion().getMinutos()%>:<%= temas.get(i).getDuracion().getSegundos()%></li>
                            <li class="list-group-item" style="color: black; width: 250px">Ubicacion: <%= temas.get(i) instanceof DtTemaLocal ? ((DtTemaLocal) temas.get(i)).getDirectorio() : ((DtTemaRemoto) temas.get(i)).getUrl()%></li>

                            <%  if (temas.get(i) instanceof DtTemaLocal) {
                                    if (actual != null) {
                                        if (actual.getEstado().equals("Vigente")) {
                            %>
                            <li class="list-group-item" style="color: black; width: 250px">Cantidad De Descargas: <%= ((DtTemaLocal) temas.get(i)).getDescargas()%></li>
                            <li class="list-group-item" style="color: black; width: 250px">Cantidad De Reproducciones:  <%= ((DtTemaLocal) temas.get(i)).getReproducciones()%></li>
                            <li class="list-group-item" style="color: black; width: 250px"><input readonly onclick="Descarga('<%=((DtTemaLocal) temas.get(i)).getDirectorio()%>', '<%= ((DtTemaLocal) temas.get(i)).getArtista()%>', '<%=((DtTemaLocal) temas.get(i)).getAlbum()%>', '<%=((DtTemaLocal) temas.get(i)).getNombre()%>')" class="btn btn-info" id="btnDescargar" value="Descargar"></li>
                                <%} else {%>   
                            <li class="list-group-item" style="color: black; width: 250px">Sin Suscripcion</li>
                                <% }
                                    }%>
                                <%} else {%>
                            <li class="list-group-item" style="color: black;width: 250px"><button type="button" class="btn btn-default" aria-label="Left Align">
                                    <span class="glyphicon glyphicon-play-circle" aria-hidden="true"  onclick="reproducirRemoto('<%= ((DtTemaRemoto) temas.get(i)).getUrl()%>', '<%= ((DtTemaRemoto) temas.get(i)).getArtista().replace("'", "\\'")%>', '<%= ((DtTemaRemoto) temas.get(i)).getAlbum().replace("'", "\\'")%>', '<%= ((DtTemaRemoto) temas.get(i)).getNombre().replace("'", "\\'")%>')"></span></button></li>
                                    <%}%>
                        </ul>
                    </div>
                    <%}%>

                </div>
            </div>
        </div>
    </nav>

</body>
</html>
