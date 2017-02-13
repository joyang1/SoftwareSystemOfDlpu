/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.user;

import com.javabean.login.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 对用户基本信息的管理，得到用户信息发送到前台
 *
 * @author 挺
 */
public class UserServlet extends HttpServlet {

    private User u = null;

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
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        u = new User();
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
        String sql = "select u_name,u_realname,u_age,u_sex,u_address, u_institute, u_major, u_class, u_studentid, u_email from user";
        String json = u.getUserJson(u.getRs(sql),pageNumber,pageSize);
        //System.out.println(json);
        out.write(json);
    }

}
