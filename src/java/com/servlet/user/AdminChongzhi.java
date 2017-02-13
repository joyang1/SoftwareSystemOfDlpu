/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.servlet.user;

import com.yt.connectdb.dbOperator;
import com.yt.md5.MD5;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *重置管理员密码
 * 
 * @author 挺
 */
public class AdminChongzhi extends HttpServlet {
    private dbOperator operator = null;
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
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        operator = new dbOperator();
        String data = "";
        String a_id = request.getParameter("aid");  //获得需要重置密码的管理员的id
        String sql = "update admin set a_password = '"+MD5.GetMD5Code("123456")+"' where a_id = '"+a_id+"'";
        if(operator.SqlQuery(sql) != 0){
            data = "{\"data\":\"0\"}"; //重置成功
        }else{
            data = "{\"data\":\"1\"}"; //重置失败
        }
        out.write(data);
    }

}
