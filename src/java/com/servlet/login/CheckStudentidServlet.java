/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.login;

import com.javabean.login.Login;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 检查学号是否存在
 *
 * @author 挺
 */
public class CheckStudentidServlet extends HttpServlet {
    private Login lg;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String studentid = request.getParameter("studentid");
        lg = new Login();
        int length = lg.getLength();
        String[] student = new String[length];
        student = lg.getStudentid();
        String flag ="0";
        for (int i = 0; i < length; i++) {
            if (studentid.equals(student[i])) {
                flag = "1";
                if (flag.equals("1")) {
                    break;
                }
            }
        }
        out.println("{\"id\":\""+flag+"\"}");
    }

}
