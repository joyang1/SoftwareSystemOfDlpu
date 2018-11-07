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
 *
 * 这是一个对管理员进行添加和编辑的servlet
 *
 * @author 挺
 */
public class AdminManageServlet_1 extends HttpServlet {

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
        String flag = request.getParameter("flag");  //接收一个flag标志，判断是进行添加(flag=1)还是编辑(flag=2)，删除(flag=3)操作
        String a_id = request.getParameter("aid");   //接收管理员id
        String a_name = request.getParameter("aname"); //接收管理员名
        String sql = "";
        String data = "";  //返回数据

        //1为添加，2为编辑, 3为删除
        if (flag.equals("1")) {
            if (operator.isSameName("a_name", "admin", a_name)) {
                data = "{\"data\":\"4\"}";  //该用户名已经存在
                out.write(data);
                return;
            }
            sql = "insert into admin values(" + null + ",'" + a_name + "','" + MD5.GetMD5Code("123456") + "');";
            if (operator.SqlQuery(sql) != 0) {
                data = "{\"data\":\"0\"}";  //添加成功
            } else {
                data = "{\"data\":\"2\"}";  //添加失败 
            }
        } else if (flag.equals("2")) {
            sql = "update admin set a_name ='" + a_name + "' where a_id='" + a_id + "'";
            if (operator.SqlQuery(sql) != 0) {
                data = "{\"data\":\"1\"}";  //编辑成功
            } else {
                data = "{\"data\":\"3\"}";  //编辑失败
            }
        } else if (flag.equals("3")) {
            sql = "delete from admin where a_id='" + a_id + "'";
            if (operator.SqlQuery(sql) != 0) {
                data = "{\"data\":\"5\"}";  //删除成功
            } else {
                data = "{\"data\":\"6\"}";  //删除失败
            }
        }
        out.write(data);
    }

}
