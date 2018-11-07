/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.judgepage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 挺
 */
public class JudgeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int judge = Integer.parseInt(request.getParameter("judge"));
        String userpower = "";
        if (request.getSession().getAttribute("userpower") == "") {
            response.sendRedirect("login/login.jsp");
        }else{
            userpower = request.getSession().getAttribute("userpower").toString();
        }
        switch (judge) {
            case 1:
                response.sendRedirect("home/homepage.jsp");
                break;
            case 2: {
                if (!userpower.equals("0")) {
                    response.sendRedirect("NewsServlet");
                } else {
                    response.sendRedirect("login/login.jsp");
                }
            }
            break;
            case 3: {
                if (!userpower.equals("0")) {
                    response.sendRedirect("PostServlet");
                } else {
                    response.sendRedirect("login/login.jsp");
                }
            }
            break;
            case 4:
                if (!userpower.equals("0")) {
                    response.sendRedirect("AlbumServlet");
                } else {
                    response.sendRedirect("login/login.jsp");
                }
                break;
            case 5: {
                if (!userpower.equals("0")) {
                    response.sendRedirect("ResServlet");
                } else {
                    response.sendRedirect("login/login.jsp");
                }
            }
            break;
            case 6: {
                if (!userpower.equals("0")) {
                    response.sendRedirect("QuestionServlet");
                } else {
                    response.sendRedirect("login/login.jsp");
                }
            }
            break;
            case 7: {
                if (!userpower.equals("0")) {
                    response.sendRedirect("test/temp.jsp");
                } else {
                    response.sendRedirect("login/login.jsp");
                }

            }

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
