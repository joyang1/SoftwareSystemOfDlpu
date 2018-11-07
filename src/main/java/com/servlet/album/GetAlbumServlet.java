/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.servlet.album;

import com.javabean.admin.GetJson;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 挺
 */
public class GetAlbumServlet extends HttpServlet {

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
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        String str_pageNum = request.getParameter("page");
        String str_pageSize = request.getParameter("rows");
        if (str_pageNum == null || str_pageNum == "0") {
            str_pageNum = "1";
        }
        if (str_pageSize == null || str_pageSize == "0") {
            str_pageSize = "10";
        }
        int pageNumber = Integer.parseInt(str_pageNum);
        int pageSize = Integer.parseInt(str_pageSize);
        String json = GetJson.getAlbumJson(pageNumber,pageSize);
        out.println(json);
    }

}
