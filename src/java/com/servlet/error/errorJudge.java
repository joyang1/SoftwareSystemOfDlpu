/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.servlet.error;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 小小一
 */
public class errorJudge extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; setchar=utf-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        int error = Integer.parseInt(request.getParameter("error"));
        String album_id = request.getParameter("id");//相册id
         switch (error) {
            case 1: {
                response.sendRedirect("error/error.jsp?error=t_m&id="+album_id+"");
            }
            break;
            case 2: {
                response.sendRedirect("error/error.jsp?error=u_p");
            }
            break;
            case 3: {
                response.sendRedirect("error/error.jsp?error=y_z");
            }
            break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
