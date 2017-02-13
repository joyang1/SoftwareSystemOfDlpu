/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.login;

import com.javabean.login.Login;
import com.yt.check.CheckCode;
import com.yt.md5.MD5;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * doGet显示个人信息
 *
 * doPost判断用户的类型，同时设置权限，管理员为"2",普通用户为"1",游客为"0"
 *
 * @author 挺
 */
public class LoginServlet extends HttpServlet {

    private Login lg;
    private CheckCode ck;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String user = session.getAttribute("user").toString();
        lg = new Login();
        String[] usercontent = new String[8];
        usercontent = lg.getUserContent(user);
        for (int i = 0; i < usercontent.length; i++) {
            request.setAttribute("usercontent"+i, usercontent[i]);
        }
//        out.print(usercontent[0]);
        request.getRequestDispatcher("login/personal.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        //PrintWriter out = response.getWriter();
        String studentid = request.getParameter("u_studentid");
        String password = request.getParameter("u_password");
        String dbpassword = MD5.GetMD5Code(password);
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        String rcode = (String) session.getAttribute("validateCode");
        lg = new Login();
        ck = new CheckCode();
        //得到此前用户权限
        String userpower = session.getAttribute("userpower").toString();
        //用户名
        String user;
        if (ck.checkcode(code,rcode)) {
            if (lg.checkadmin(studentid, dbpassword)) {
                //管理员登陆成功，同时修改权限                
                session.setAttribute("userpower", "2");
                user = studentid;
                response.sendRedirect("admin/adminmanage.jsp");
            } else if (lg.checkuser(studentid, dbpassword)) {
                //用户登陆成功，同时修改权限    
                session.setAttribute("userpower", "1");
                user = lg.getUsername(studentid);
                response.sendRedirect("home/homepage.jsp");
            } else {
                //用户登陆失败
                user = "null";
                response.sendRedirect("errorJudge?error="+2); 
//                response.sendRedirect("login/login.jsp");
            }
        } else {
            //管理员或用户登陆失败
            user = "null";
            response.sendRedirect("errorJudge?error="+3); 
        }
        session.setAttribute("user", user);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
