/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Configuracion.Configuracion;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import servicios.DtAlbumContenido;
import servicios.DtArtista;
import servicios.DtCliente;
import servicios.DtPerfilArtista;
import servicios.DtSuscripcion;
import servicios.DtUsuario;
import servicios.PMovil;
import servicios.PMovilService;

/**
 *
 * @author Brian
 */
@WebServlet(name = "SMovil", urlPatterns = {"/SMovil"})
public class SMovil extends HttpServlet {

    PMovil port;

    public SMovil() {
        Configuracion.cargar();
        try {
            URL url = new URL("http://" + Configuracion.get("ip") + ":" + Configuracion.get("puerto") + "/" + Configuracion.get("PMovil"));
            PMovilService webserv = new PMovilService(url);
            port = webserv.getPMovilPort();
        } catch (MalformedURLException ex) {
            Logger.getLogger(SMovil.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("accion") == null) {
            log("a");
            DtUsuario dtu = null;
            if (request.getSession().getAttribute("usuario") != null) {
                request.getSession().removeAttribute("usuario");
                request.getRequestDispatcher("vistas/InicioSesion.jsp").forward(request, response);
                return;
            } else {
                Cookie[] todoLosCockies = request.getCookies();
                if (todoLosCockies != null) {
                    log("b");
                    for (int i = 0; i < todoLosCockies.length; i++) {
                        log("c");
                        if (todoLosCockies[i].getName().equals("nick")) {
                            log("d");
                            dtu = port.getDataCliente(todoLosCockies[i].getValue());
                            request.getSession().setAttribute("usuario", dtu);
                            request.setAttribute("generos", (ArrayList) port.obtenerGeneros().getString());
                            request.setAttribute("artistas", (ArrayList) port.listarArtistas().getUsuarios());
                            request.getRequestDispatcher("vistas/Inicio.jsp").forward(request, response);
                            break;
                        }
                    }
                } else {
                    request.getRequestDispatcher("vistas/InicioSesion.jsp").forward(request, response);
                    return;
                }
            }

        } else {
            String accion = request.getParameter("accion");

            switch (accion) {
                case "error":
                    if (request.getParameter("mensaje") == null) {
                        request.setAttribute("error", "Error desconocido");
                        request.getRequestDispatcher("vistas/InicioSesion.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", request.getParameter("mensaje"));
                        request.getRequestDispatcher("vistas/InicioSesion.jsp").forward(request, response);
                    }

                    break;
                case "consultarAlbum":
                    if (request.getSession().getAttribute("usuario") == null) {
                        request.setAttribute("error", "Iniciar Sesion");
                        request.getRequestDispatcher("vistas/InicioSesion.jsp").forward(request, response);
                    } else {
                        String nickArtista = request.getParameter("nickArtista");
                        if (port.getDataUsuario(nickArtista) == null) {
                            request.setAttribute("mensaje_error", "El artista no existe");
                            request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                            return;
                        }
                        DtUsuario artista = (DtUsuario) port.getDataUsuario(nickArtista);
                        String nomAlbum = URLDecoder.decode(request.getParameter("nomAlbum"), "UTF-8");
                        DtAlbumContenido dtAlbum = null;
                        try {
                            dtAlbum = port.obtenerAlbumContenido(nickArtista, nomAlbum);
                        } catch (UnsupportedOperationException e) {
                            request.setAttribute("mensaje_error", "El artista " + nickArtista + " no tiene el album " + nomAlbum);
                            request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                            return;
                        }
                        if (dtAlbum == null) {
                            request.setAttribute("mensaje_error", "El artista " + nickArtista + " no tiene el album " + nomAlbum);
                            request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                            return;

                        }
                        request.setAttribute("Album", dtAlbum);
                        request.setAttribute("Artista", artista);
                        request.getRequestDispatcher("/vistas/ConsultaAlbum.jsp").forward(request, response);

                    }
                    break;
                case "Inicio":
                    request.setAttribute("generos", (ArrayList) port.obtenerGeneros().getString());
                    request.setAttribute("artistas", (ArrayList) port.listarArtistas().getUsuarios());
                    request.getRequestDispatcher("vistas/Inicio.jsp").forward(request, response);
                    break;
                case "consultarGenero":
                    if (request.getParameter("genero") == null) {
                        request.setAttribute("mensaje_error", "Faltan parámetros");
                        request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                    } else {
                        String genero = request.getParameter("genero");
                        if (port.existeGenero(genero)) {
                            if (request.getSession().getAttribute("usuario") != null) {
                                DtUsuario dtu = (DtUsuario) request.getSession().getAttribute("usuario");
                                if (dtu instanceof DtCliente) {
                                    request.setAttribute("suscripcion", ((DtCliente) dtu).getActual());
                                }
                            }
                            if (port.listarLisReproduccion(genero) == null) {
                                log("Lista");

                            }
                            if (port.listarAlbumesGenero(genero) == null) {
                                log("Album");
                            }
                            request.setAttribute("genero", genero);
                            request.setAttribute("albumes", (ArrayList) port.listarAlbumesGenero(genero).getAlbum());
                            request.setAttribute("listas", (ArrayList) port.listarLisReproduccion(genero).getListas());
                            request.getRequestDispatcher("vistas/Listado.jsp").forward(request, response);
                        } else {
                            request.setAttribute("mensaje_error", "El genero no existe");
                            request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                        }
                    }
                    break;
                case "consultarArtista":
                    if (request.getParameter("nick") == null) {
                        request.setAttribute("mensaje_error", "No se ingreso que usuario quiere consultar");
                        request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                        return;
                    }

                    String nickUs = "";
                    if (request.getParameter("nick") != null) {
                        nickUs = request.getParameter("nick");
                    }
                    DtUsuario DtUs = port.getDataUsuario(nickUs);//iUsuario.getDataUsuario(nickUs);
                    if (DtUs == null) {

                        request.setAttribute("mensaje_error", "No existe el usuario " + nickUs);
                        request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                    }

                    if (DtUs instanceof DtArtista) {
                        DtPerfilArtista dtPerfilArtista = (DtPerfilArtista) port.obtenerPerfilArtista(nickUs);//iUsuario.obtenerPerfilArtista(nickUs);
                        request.setAttribute("albumes", (ArrayList) dtPerfilArtista.getAlbumes());
                        request.getRequestDispatcher("vistas/Listado.jsp").forward(request, response);
                    }
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("accion") == null) {
            request.setAttribute("mensaje_error", "No hay una accion");
            request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
            return;
        }
        String accion = request.getParameter("accion");
        switch (accion) {

            case "iniciarSesion":

                if (request.getSession().getAttribute("usuario") != null) {
                    request.setAttribute("mensaje_error", "Ya hay un usuario logueado");
                    request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                    return;
                }
                if (request.getParameter("nickname") == null || request.getParameter("contrasenia") == null) {
                    response.setContentType("text/plain");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("Faltan Campos");
                } else {
                    if (request.getSession().getAttribute("usuario") != null) {
                        log(((DtUsuario) request.getSession().getAttribute("usuario")).getNickname());
                    } else {
                        log("Sin Usuario");
                    }
                    String nickname = port.chequearLogin(request.getParameter("nickname"), request.getParameter("contrasenia"));
                    if (!nickname.contains("Error")) {
                        DtUsuario dtu = null;
                        DtSuscripcion actual = null;
                        if (port.esCliente(nickname)) {
                            dtu = port.getDataCliente(nickname);

                        } else {
                            response.setContentType("text/plain");
                            response.setCharacterEncoding("UTF-8");
                            response.getWriter().write("Error: Debe Ser Un Cliente");
                            return;
                        }
                        if (request.getParameter("recordar").equals("true")) {
                            Cookie nick = new Cookie("nick", dtu.getNickname());
                            nick.setMaxAge(1 * 365 * 24 * 60 * 60);
                            response.addCookie(nick);
                        } else {
                            Cookie[] todoLosCockies = request.getCookies();
                            for (int i = 0; i < todoLosCockies.length; i++) {

                                if (todoLosCockies[i].getName().equals("nick")) {
                                    todoLosCockies[i].setMaxAge(0);
                                }
                            }
                        }
                        request.getSession().setAttribute("usuario", dtu);
                        response.setContentType("text/plain");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write("correcto");
                    } else {
                        response.setContentType("text/plain");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write(nickname);
                    }
                }

                break;

            case "CerrarSesion":
                if (request.getSession().getAttribute("usuario") == null) {
                    request.setAttribute("mensaje_error", "Debe haber un usuario logueado");
                    request.getRequestDispatcher("vistas/pagina_error.jsp").forward(request, response);
                    return;
                }
                request.getSession().removeAttribute("usuario");
                request.getRequestDispatcher("SMovil").forward(request, response);
                processRequest(request, response);
                break;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
