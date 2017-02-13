/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.post;

import com.javabean.login.Login;
import com.javabean.post.Post;
import com.yt.getTime.GetTime;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 挺
 */
public class FSPostServlet extends HttpServlet {

    private Login lg = null;
    private Post p = null;
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
        response.setContentType("text/html; charset=utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        lg = new Login();
        p = new Post();
        HttpSession session = request.getSession();
        String user = session.getAttribute("user").toString();
        String userpower = session.getAttribute("userpower").toString();
        String name = request.getParameter("p_name");
        String content = request.getParameter("p_content");
        String realname = lg.getRealname(user);
        String time = GetTime.getTime();

        //判断是不是空帖
        if (name.equals("") || content.equals("")) {          
            response.sendRedirect("PostServlet");
            out.println("<script>alert(\"帖子和内容都不能为空!\");</script>");
            return;
        }

        if (userpower.equals("1")) {
            if (p.addpost(name, content, user, realname, time)) {
                response.sendRedirect("PostServlet");
            }
        } else {
            if (p.addpost(name, content, user, "admin", time)) {
                response.sendRedirect("PostServlet");
            }
        }
    }

}
