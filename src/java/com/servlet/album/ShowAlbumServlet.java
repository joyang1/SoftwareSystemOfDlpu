/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.servlet.album;

import com.javabean.album.Album;
import com.javabean.picture.Picture;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * @author 挺
 */
public class ShowAlbumServlet extends HttpServlet {
    private Picture p = null;
    private Album a = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=utf-8");
        //PrintWriter out = response.getWriter();
        p = new Picture();
        a = new Album();
        
        int album_id = Integer.parseInt(request.getParameter("album_id"));
        String albumurl = a.getAlbumUrl(album_id);
        int albumpicturecount = p.getEachAlbumPictureCount(album_id);
        int[] id = new int[albumpicturecount];
        String[] introduce = new String[albumpicturecount];
        String[] name = new String[albumpicturecount];
        id = p.getPictureId(album_id);
        for(int i=albumpicturecount-1; i>=0; i--){
            introduce[i] = p.getIntroduce(id[i]);
            name[i] = p.getName(id[i]);
            request.setAttribute("introduce" + i, introduce[i]);
            request.setAttribute("name" + i, name[i]);
            //out.println(introduce[i]);
        }
        request.setAttribute("albumurl", albumurl);
        request.setAttribute("album_id", album_id);
        request.setAttribute("albumpicturecount", albumpicturecount);
        request.getRequestDispatcher("album/showalbum.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
