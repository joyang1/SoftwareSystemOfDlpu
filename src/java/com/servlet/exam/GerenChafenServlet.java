/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.exam;

import com.yt.connectdb.dbOperator;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 挺
 */
public class GerenChafenServlet extends HttpServlet {

    private dbOperator db = null;

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
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        String sno = request.getParameter("sno");
        String sname = request.getParameter("sname"); 
        db = new dbOperator();
        ResultSet rs = db.getRs("select score from score where student_no='"+sno+"' and name='"+sname+"' limit 0,1");
        String data = "";
        try {
            if(rs.next()){
                int score = rs.getInt(1);
                data = sname+"，你的分数是"+score;
            }else{
                data = "没有该用户!";
            }
        } catch (SQLException ex) {
            data="未知错误!";
        }
        out.write("{\"data\":\""+data+"\"}");
    }

}
