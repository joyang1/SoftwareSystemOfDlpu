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
 * @author 挺
 */
public class UserAdminServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        operator = new dbOperator();
        String flag = request.getParameter("flag");  //接收一个flag标志，判断是进行添加(flag=1)还是编辑(flag=2)，删除(flag=3),重置密码(flag=4)操作
        String u_id = request.getParameter("ustudentid");   //接收用户id
        String sql = "";
        String data = "";  //返回数据

        //1为添加，2为编辑, 3为删除
        if (flag.equals("1")) {
            String u_name = request.getParameter("uname"); //接收用户名
            String u_rname = request.getParameter("urealname"); //接收用户名
            String u_age = request.getParameter("uage");
            String u_sex = request.getParameter("usex");
            String u_address = request.getParameter("uaddress");
            String u_institute = request.getParameter("uinstitute");
            String u_major = request.getParameter("umajor");
            String u_class = request.getParameter("uclass");
            String u_email = request.getParameter("uemail");
            if(operator.isSameName("u_studentid", "user", u_id)){
                data = "{\"data\":\"error\"}";  //添加的用户名相同
                out.write(data);
                return;
            }
            sql = "insert into user values(" + null + ",'" + u_name + "','" + MD5.GetMD5Code("123456") + "',"
                    + " '" + u_rname + "'," + u_age + ",'" + u_sex + "','" + u_address + "','" + "" + "','" + u_institute + "'"
                    + ",'" + u_major + "','" + u_class + "','"+u_id+"','" + u_email + "')";
            //System.out.println(""+sql);
            if (operator.SqlQuery(sql) != 0) {
                data = "{\"data\":\"0\"}";  //添加成功
            } else {
                data = "{\"data\":\"2\"}";  //添加失败 
            }
        } else if (flag.equals("2")) {
            String u_name = request.getParameter("uname"); //接收用户名
            String u_rname = request.getParameter("urealname"); //接收用户名
            String u_age = request.getParameter("uage");
            String u_sex = request.getParameter("usex");
            String u_address = request.getParameter("uaddress");
            String u_institute = request.getParameter("uinstitute");
            String u_major = request.getParameter("umajor");
            String u_class = request.getParameter("uclass");
            String u_email = request.getParameter("uemail");
            sql = "update user set u_name ='" + u_name + "', u_realname='" + u_rname + "', u_age=" + u_age + " ,"
                    + " u_sex='" + u_sex + "', u_address='" + u_address + "', u_institute='" + u_institute + "', u_major='" + u_major + "', "
                    + " u_class='" + u_class + "' ,u_email ='" + u_email + "' where u_studentid='" + u_id + "'";
            //System.out.println(""+sql);
            if (operator.SqlQuery(sql) != 0) {
                data = "{\"data\":\"1\"}";  //编辑成功
            } else {
                data = "{\"data\":\"3\"}";  //编辑失败
            }
        } else if (flag.equals("3")) {
            sql = "delete from user where u_studentid='" + u_id + "'";
            if (operator.SqlQuery(sql) != 0) {
                data = "{\"data\":\"5\"}";  //删除成功
            } else {
                data = "{\"data\":\"6\"}";  //删除失败
            }
        } else if (flag.equals("4")) {
            sql = "update user set u_password = '" + MD5.GetMD5Code("123456") + "' where u_studentid = '" + u_id + "'";
            if (operator.SqlQuery(sql) != 0) {
                data = "{\"data\":\"7\"}";  //重置成功
            } else {
                data = "{\"data\":\"8\"}";  //重置失败
            }
        }
        out.write(data);
    }
}
